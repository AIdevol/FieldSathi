import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constans/color_constants.dart';
import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../utilities/helper_widget.dart';
import '../views/otp_view_screen.dart';
import 'OtpViewController.dart';

class ProfileViewScreenController extends GetxController{
  CountryCode? selectedCountry;
  TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController employeesController = TextEditingController();

  FocusNode companyNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode employeesFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();


  @override
  void onClose() {
    countryController.dispose();
    countryFocusNode.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    employeesFocusNode.dispose();
    companyNameFocusNode.dispose();
    super.onClose();
  }



  void hitRegisterApicall(){
    if (emailController.text.isEmpty) {
      toast('Please enter email or phone');
      return;
    }
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = {
      "email_or_phone":emailController.text,
      "first_name": nameController.text,
      "companyName": companyNameController.text,
      "employees":employeesController.text,
      "country":countryController.text
    };
    Get.find<AuthenticationApiService>().registerApiCall(dataBody: loginReq ).then((value)async {
      toast('Login successfully enter your OTP');
      _openForgotcontainerBottomsheet();
      customLoader.hide();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }


  _openForgotcontainerBottomsheet() {
    // Get.put(OtpViewController(email: emailController.text));
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height * 0.9, // 90% of the screen height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
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
            Expanded(
              child: OtpViewScreen(),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }


  File? profileImage;

  Future<void> getImage(ImageSource source) async {
  final PermissionStatus status = await _requestPermission(source);

  if (status.isGranted) {
  try {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: source);

  if (image != null) {
  profileImage = File(image.path);
  update();
  }
  } catch (e) {
  print('Error picking image: $e');
  Get.snackbar('Error', 'Failed to pick image. Please try again.',
  snackPosition: SnackPosition.BOTTOM);
  }
  } else if (status.isDenied) {
  Get.snackbar('Permission Denied', 'Please grant permission to access ${source == ImageSource.camera ? 'camera' : 'gallery'}.',
  snackPosition: SnackPosition.BOTTOM);
  } else if (status.isPermanentlyDenied) {
  Get.snackbar('Permission Permanently Denied', 'Please enable ${source == ImageSource.camera ? 'camera' : 'storage'} permission from app settings.',
  snackPosition: SnackPosition.BOTTOM);
  await openAppSettings();
  }
  }

  Future<PermissionStatus> _requestPermission(ImageSource source) async {
  if (source == ImageSource.camera) {
  return await Permission.camera.request();
  } else {
  if (Platform.isAndroid) {
  if (_isAndroid13OrHigher()) {
  return await Permission.photos.request();
  } else {
  return await Permission.storage.request();
  }
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