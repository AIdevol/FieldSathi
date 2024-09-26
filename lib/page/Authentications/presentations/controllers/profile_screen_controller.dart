import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../navigations/navigation.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../services/login_service.dart';
import '../../../../utilities/helper_widget.dart';
import '../views/otp_view_screen.dart';

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
  late FocusNode emailFocusNode ;
  late FocusNode nameFocusNode;
  late FocusNode employeesFocusNode ;
  late FocusNode countryFocusNode ;
  late FocusNode phoneFocusNode;
  late FocusNode addressFocusNode;

  // Observables
  final RxBool isLoggedOut = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);

  Timer? _timer;

  @override
  void onClose() {
    // Dispose of controllers and focus nodes
    countryController.dispose();
    emailController.dispose();
    nameController.dispose();
    companyNameController.dispose();
    employeesController.dispose();
    phoneController.dispose();
    addressController.dispose();

    countryFocusNode.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    employeesFocusNode.dispose();
    companyNameFocusNode.dispose();
    addressFocusNode.dispose();

    _timer?.cancel();
    super.onClose();
  }
@override
  void onInit(){
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

  hituserDetailsApiCall();
  super.onInit();
}
/*  void hitRegisterApiCall() {
    if (emailController.text.isEmpty) {
      toast('Please enter email or phone');
      return;
    }
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    final loginReq = {
      "email_or_phone": emailController.text,
      "first_name": nameController.text,
      "companyName": companyNameController.text,
      "employees": employeesController.text,
      "country": countryController.text
    };

    Get.find<AuthenticationApiService>().registerApiCall(dataBody: loginReq).then((value) async {
      toast('Login successfully, enter your OTP');
      _openForgotContainerBottomsheet();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
    }).whenComplete(() => customLoader.hide());
  }*/

/*
  void _openForgotContainerBottomsheet() {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: whiteColor,
        ),
        child: Column(
          children: [
            vGap(15),
            Container(
              height: 10,
              width: 60,
              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
            ),
            vGap(15),
             Expanded(child: OtpViewScreen()),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
*/
  // ==========================================================fetch profile data========================================
  void refreshUserData() async {
    // Clear all text controllers before fetching new data
    clearControllers();
    hituserDetailsApiCall();
  }

void  clearControllers(){
    nameController.clear();
    emailController.clear();
    companyNameController.clear();
    countryController.clear();
    employeesController.clear();
    phoneController.clear();
    addressController.clear();
}

  void hituserDetailsApiCall(){
    final id= storage.read(userId);
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>().userDetailsApiCall(id:id).then((value){
     var userData = value;
     nameController.text = userData.firstName??'';
     emailController.text = userData.email??'';
     phoneController.text = userData.phoneNumber??'';
     companyNameController.text = userData.companyName??'';
     countryController.text = userData.country??'';
     employeesController.text = userData.employees??'';
     addressController.text = userData.companyAddress??'';
     print("userData= $userData");
     customLoader.hide();
     update();
     toast("data successfully fetch");
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitUserupdateProfile(){
    customLoader.show();
    Get.put(GetLoginModalService());

    FocusManager.instance.primaryFocus?.unfocus();
    final id = storage.read(userId);

    var userUpdatedData = {
      "first_name":nameController.text,
      "email":emailController.text,
      "company_name": companyNameController.text,
      "employees":employeesController.text,
      "country":countryController.text,
      "phone_number": phoneController.text,
      "": addressController.text
    };
    Get.find<AuthenticationApiService>().updateUserDetailsApiCall(id:id, dataBody: userUpdatedData).then((value){
      var updateData = value;
      Get.find<GetLoginModalService>().getUserDataModal(UserDataModel: value);
      print("update data: ${updateData}");
      refreshUserData();
      customLoader.hide();
      toast("Updated successfully your profile");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
  
  Future<void> logout() async {

    if (isLoggedOut.value) return;

    isLoggedOut.value = true;
    _timer?.cancel();
    try {
      await Future.wait([
        storage.remove(LOCALKEY_token),
        storage.remove(userId),
        storage.remove(RefreshToken),
        storage.remove('isLoggedIn'),
        storage.remove('isVerified'),
      ]);
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      customLoader.hide();
      print("Error during logout: $e");
      isLoggedOut.value = false; // Reset the flag if logout fails
    }
  }

  Future<void> getImage(ImageSource source) async {
    final PermissionStatus status = await _requestPermission(source);

    if (status.isGranted) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: source);

        if (image != null) {
          profileImage.value = File(image.path);
        }
      } catch (e) {
        print('Error picking image: $e');
        Get.snackbar('Error', 'Failed to pick image. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else if (status.isDenied) {
      Get.snackbar('Permission Denied',
          'Please grant permission to access ${source == ImageSource.camera ? 'camera' : 'gallery'}.',
          snackPosition: SnackPosition.BOTTOM);
    } else if (status.isPermanentlyDenied) {
      Get.snackbar('Permission Permanently Denied',
          'Please enable ${source == ImageSource.camera ? 'camera' : 'storage'} permission from app settings.',
          snackPosition: SnackPosition.BOTTOM);
      await openAppSettings();
    }
  }

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
}