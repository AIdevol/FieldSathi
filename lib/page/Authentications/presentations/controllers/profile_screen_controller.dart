import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../navigations/navigation.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../services/login_service.dart';

class ProfileViewScreenController extends GetxController {
  // Country selection
  CountryCode? selectedCountry;
  late TextEditingController countryController;

  // Form controllers
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController companyNameController;
  late TextEditingController employeesController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  // Focus nodes
  late FocusNode companyNameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode employeesFocusNode;
  late FocusNode countryFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode addressFocusNode;

  // Observables
  final RxBool isLoggedOut = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxString profileImageUrl = RxString('');
  final RxBool isLoading = false.obs;

  Timer? _timer;
  File? selectedImage ;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    initializeControllers();
    hituserDetailsApiCall();
    super.onInit();
  }

  void initializeControllers() {
    countryController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    companyNameController = TextEditingController();
    employeesController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    companyNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    employeesFocusNode = FocusNode();
    countryFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    addressFocusNode = FocusNode();
  }

  @override
  void onClose() {
    disposeControllers();
    _timer?.cancel();
    super.onClose();
  }

  void disposeControllers() {
    countryController.dispose();
    emailController.dispose();
    nameController.dispose();
    companyNameController.dispose();
    employeesController.dispose();
    phoneController.dispose();
    addressController.dispose();

    companyNameFocusNode.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    employeesFocusNode.dispose();
    countryFocusNode.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
  }

  void refreshUserData() {
    clearControllers();
    hituserDetailsApiCall();
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    companyNameController.clear();
    countryController.clear();
    employeesController.clear();
    phoneController.clear();
    addressController.clear();
    profileImageUrl.value = '';
    profileImage.value = null;
  }
// Future<void> hitUserUpdateProfileImage()async {
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.context;
//     Get.find<AuthenticationApiService>().userProfileImageUpdateApiCall().then((value){}).onError((error, stackError){});
// }
  void hituserDetailsApiCall() {
    final id = storage.read(userId);
    isLoading.value = true;

    Get.find<AuthenticationApiService>().userDetailsApiCall(id: id).then((value) {
      var userData = value;
      nameController.text = userData.firstName ?? '';
      emailController.text = userData.email ?? '';
      phoneController.text = userData.phoneNumber ?? '';
      companyNameController.text = userData.companyName ?? '';
      countryController.text = userData.country ?? '';
      employeesController.text = userData.employees ?? '';
      addressController.text = userData.primaryAddress ?? '';
      profileImageUrl.value = userData.profileImage ?? '';

      isLoading.value = false;
      update();
    }).onError((error, stackError) {
      isLoading.value = false;
      toast(error.toString());
    });
  }

  void hitUserupdateProfile() {
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    final id = storage.read(userId);
    var userUpdatedData = {
      "first_name": nameController.text,
      "email": emailController.text,
      "company_name": companyNameController.text,
      "employees": employeesController.text,
      "primary_address": addressController.text,
      "country": countryController.text,
      "phone_number": phoneController.text,
      "company_address": addressController.text
    };

    Get.find<AuthenticationApiService>()
        .updateUserDetailsApiCall(id: id, dataBody: userUpdatedData)
        .then((value) {
      var updateData = value;
      Get.find<GetLoginModalService>().getUserDataModal(UserDataModel: updateData);
      hitUploadProfileImage(profileImage.value!);
      refreshUserData();
      isLoading.value = false;
      toast("Updated successfully your profile");
    }).onError((error, stackError) {
      isLoading.value = false;
      toast(error.toString());
    });
  }

  Future<void> logout() async {
    if (isLoggedOut.value) return;
    isLoggedOut.value = true;
    _timer?.cancel();
    FocusManager.instance.primaryFocus!.context;
    try {
      await Future.wait([
        storage.remove(LOCALKEY_token),
        storage.remove(userId),
        storage.remove(RefreshToken),
        storage.remove('isLoggedIn'),
        storage.remove('isVerified'),
      ]);
      toast('logout successfully');
      Get.offAllNamed(AppRoutes.login);
      update();
    } catch (e) {
      customLoader.hide();
      isLoggedOut.value = false; // Reset the flag if logout fails
    }
  }

 void getImage(ImageSource source) async {
    try {
      final PermissionStatus status = await _requestPermission(source);

      if (status.isGranted) {
        final XFile? image = await _picker.pickImage(
          source: source, imageQuality: 80, maxWidth: 1200, maxHeight: 1200,
        );
        if (image != null) {
          profileImage.value = File(image.path);
          await hitUploadProfileImage(profileImage.value!);
          update();
        }
      } else if (status.isDenied) {
        _showPermissionDialog();
      } else if (status.isPermanentlyDenied) {
        _showSettingsDialog();
      }
    } catch (e) {
      toast('Failed to pick image. Please try again.');
    }
  }
  void _showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Permission Required'.tr),
        content: Text('Please grant the required permission to access photos/camera.'.tr),
        actions: [
          TextButton(
            child: Text('Cancel'.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Settings'.tr),
            onPressed: () {
              Get.back();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }
  void _showSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Permission Denied'.tr),
        content: Text('Permission is permanently denied. Please enable it from app settings.'.tr),
        actions: [
          TextButton(
            child: Text('Cancel'.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Open Settings'.tr),
            onPressed: () {
              Get.back();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  Future<void> hitUploadProfileImage(File imageFile)async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().userProfileImageUpdateApiCall(imageFile).then((value){
      profileImageUrl.value = value.profileImage ?? '';
      customLoader.hide();
      isLoading.value = false;
      toast("Profile image updated successfully");
      update();
    }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
    });
  }
  // Future<void> uploadProfileImage(File imageFile) async {
  //   try {
  //     isLoading.value = true;
  //     update();
  //
  //     final id = storage.read(userId);
  //     if (id == null) throw Exception('User ID not found');
  //
  //     final uri = Uri.parse('YOUR_API_ENDPOINT/update-profile-image/$id');
  //
  //     var request = http.MultipartRequest('POST', uri);
  //     request.files.add(
  //         await http.MultipartFile.fromPath('profile_image', imageFile.path)
  //     );
  //
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //       profileImageUrl.value = jsonResponse['image_url'] ?? '';
  //       toast("Profile image updated successfully");
  //     } else {
  //       throw Exception('Server returned ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     toast("Failed to upload image: $e");
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }
    // final PermissionStatus status = await _requestPermission(source);
    //
    // if (status.isGranted) {
    //   try {
    //     final ImagePicker picker = ImagePicker();
    //     final XFile? image = await picker.pickImage(source: source);
    //
    //     if (image != null) {
    //       profileImage.value = File(image.path);
    //       await uploadProfileImage(profileImage.value!);
    //     }
    //   } catch (e) {
    //     print('Error picking image: $e');
    //     Get.snackbar('Error', 'Failed to pick image. Please try again.',
    //         snackPosition: SnackPosition.BOTTOM);
    //   }
    // } else if (status.isPermanentlyDenied) {
    //   Get.snackbar(
    //     'Permission Permanently Denied',
    //     'Please enable ${source == ImageSource.camera ? 'camera' : 'storage'} permission from app settings.',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   await openAppSettings();
    // }

  }
  // Future<void> selectImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     selectedImage = File(image.path);
  //     print("adfkladjfadjfkladjfklajsdfkladjsfajdsf>>>: $selectedImage");
  //     update();
  //   }
  // }
  Future<PermissionStatus> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request();
    } else {
      if (Platform.isAndroid) {
        return _isAndroid13OrHigher()
            ? await Permission.photos.request()
            : await Permission.storage.request();
      } else {
        return await Permission.photos.request();
      }
    }
  }

  bool _isAndroid13OrHigher() {
    if (Platform.isAndroid) {
      final androidSdkInt = int.tryParse(Platform.operatingSystemVersion.split(' ').first) ?? 0;
      return androidSdkInt >= 33;
    }
    return false;
  }
