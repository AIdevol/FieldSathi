import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/profile_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import 'package:tms_sathi/Extentions/text_field_extentions.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ProfileViewScreen extends GetView<ProfileViewScreenController>{
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ProfileViewScreenController>(
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black.withOpacity(.0),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: whiteColor),
                  onPressed: () => Get.back(),
                ),
              ),
              body: _mainScreen(context),
            ),
          );
        },
      ),
    );
  }

  Widget _mainScreen(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: Get.height,
          width: Get.width,
          color: appColor,
          child: Image.asset(appIcon, fit: BoxFit.contain),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.of(context).size.height * 0.30,
          bottom: 0,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: Get.height * 0.6,
              ),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: _loginTextfields(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginTextfields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          vGap(15),
          Text(
            'Profile'.tr,
            style: MontserratStyles.montserratBoldTextStyle(
              color: blackColor,
              size: 25,
            ),
            textAlign: TextAlign.center,
          ),
          vGap(15),
          Text(
            'Create your profile'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: Colors.grey,
              size: 16,
            ),
            textAlign: TextAlign.center,
          ),
          vGap(20),
          _imagePickerWidget(),
          _form(context),
        ],
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          vGap(10),
          CustomTextField(
            hintText: "Name".tr,
            controller: controller.nameController,
            textInputType: TextInputType.name,
            focusNode: controller.nameFocusNode,
            onFieldSubmitted: (String? value) {
              FocusScope.of(context).requestFocus(controller.emailFocusNode);
            },
            labletext: "Name".tr,
            prefix: Icon(Icons.person, color: Colors.black),
            validator: (value) {
              return value?.isEmptyField(messageTitle: "name");
            },
          ),
          vGap(16),
          CustomTextField(
            hintText: "Email".tr,
            controller: controller.emailController,
            textInputType: TextInputType.emailAddress,
            focusNode: controller.emailFocusNode,
            onFieldSubmitted: (String? value) {
              FocusScope.of(context).requestFocus(controller.companyNameFocusNode);
            },
            labletext: "Email".tr,
            prefix: Icon(FeatherIcons.mail, color: Colors.black),
            validator: (value) {
              return value?.isEmptyField(messageTitle: "email");
            },
          ),
          vGap(16),
          CustomTextField(
            hintText: "Company Name".tr,
            controller: controller.companyNameController,
            textInputType: TextInputType.text,
            focusNode: controller.companyNameFocusNode,
            onFieldSubmitted: (String? value) {
              FocusScope.of(context).requestFocus(controller.employeesFocusNode);
            },
            labletext: "Company Name".tr,
            prefix: Icon(FeatherIcons.briefcase, color: Colors.black),
            validator: (value) {
              return value?.isEmptyField(messageTitle: "company name");
            },
          ),
          vGap(16),
          CustomTextField(
            hintText: "Employees".tr,
            controller: controller.employeesController,
            textInputType: TextInputType.number,
            focusNode: controller.employeesFocusNode,
            onFieldSubmitted: (String? value) {
              FocusScope.of(context).requestFocus(controller.countryFocusNode);
            },
            labletext: "Employees".tr,
            prefix: Icon(FeatherIcons.users, color: Colors.black),
            validator: (value) {
              return value?.isEmptyField(messageTitle: "employees");
            },
          ),
          vGap(16),
          CustomTextField(
            hintText: "Country".tr,
            controller: controller.countryController,
            textInputType: TextInputType.text,
            focusNode: controller.countryFocusNode,
            onFieldSubmitted: (String? value) {
              // Handle field submission if needed
            },
            labletext: "Country".tr,
            prefix: Icon(FeatherIcons.globe, color: Colors.black),
            suffix: InkWell(
              onTap: () {
                _showCountryPicker(context: context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.arrow_drop_down, color: Colors.black,size: 30,),
              ),
            ),
            validator: (value) {
              return value?.isEmptyField(messageTitle: "country");
            },
            // readOnly: true,
          ),
          vGap(20),
          InkWell(
            onTap: () {
              if (formGlobalKey.currentState!.validate()) {
                controller.hitRegisterApicall();
                // _openForgotcontainerBottomsheet();
                print('Registration button tapped');
              }
            },
            child: Container(
              height: Get.height * 0.06,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: appColor,
              ),
              child: Center(
                child: Text(
                  'Update'.tr,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: blackColor,
                    size: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // vGap(20),
          // _goToLoginView(),
        ],
      ),
    );
  }

  /*Widget _goToLoginView() {
    return Text.rich(
      TextSpan(
          text: "Already have an account? ".tr,
          style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black45),
          children: [
            TextSpan(
              text: "Login".tr,
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  Get.offAllNamed(AppRoutes.login);
                },
              style: MontserratStyles.montserratSemiBoldTextStyle(color: appColor),
            ),
          ]
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }*/

  Container _showCountryPicker({required BuildContext context}) {
    return Container(
      child: CountryCodePicker(
        onChanged: (CountryCode countryCode) {
          controller.countryController.text = countryCode.name ?? '';
          controller.selectedCountry = countryCode;
          controller.update();
          Navigator.pop(context);
        },
        initialSelection: 'IN',
        favorite: ['+1', 'US', '+91', 'IN'],
        showCountryOnly: true,
        showOnlyCountryWhenClosed: true,
        alignLeft: false,
        showFlag: true,
        showFlagDialog: true,
        builder: (CountryCode? countryCode) {
          return ListTile(
            leading: Container(
              width: 30,
              height: 20,
              child: countryCode != null ? Text(countryCode.flagUri ?? '') : SizedBox(),
            ),
            title: Text(countryCode?.name ?? ''),
            trailing: Text(countryCode?.dialCode ?? ''),
          );
        },
      ),
    );

  }
  Widget _imagePickerWidget() {
    return GetBuilder<ProfileViewScreenController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => _showImagePickerOptions(Get.context!),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
            backgroundImage: controller.profileImage != null
                ? FileImage(File(controller.profileImage!.path))
                : null,
            child: controller.profileImage == null
                ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                : null,
          ),
        );
      },
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  controller.getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a Photo'),
                onTap: () {
                  controller.getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

}