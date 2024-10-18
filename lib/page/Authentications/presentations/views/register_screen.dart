import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/login_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/register_screen_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import 'package:tms_sathi/Extentions/text_field_extentions.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../controllers/OtpViewController.dart';
import 'otp_view_screen.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  final formGlobalKey = GlobalKey<FormState>();
  final RegisterScreenController controller = Get.put(RegisterScreenController());

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<RegisterScreenController>(
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
            'Register'.tr,
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
          vGap(16),
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
            readOnly: true,
            hintText: "Country".tr,
            controller: controller.countryController,
            textInputType: TextInputType.text,
            focusNode: controller.countryFocusNode,
            onFieldSubmitted: (String? value) {
              // Handle field submission if needed
            },
            labletext: "Country".tr,
            prefix: Icon(FeatherIcons.globe, color: Colors.black),
            suffix: IconButton(onPressed:(){_openCountryPicker(context);},icon: const Icon(Icons.arrow_drop_down, color: Colors.black,size: 30,)),
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
                  'Register'.tr,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: blackColor,
                    size: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          vGap(20),
          _goToLoginView(),
        ],
      ),
    );
  }

  Widget _goToLoginView() {
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
  }
  void _openCountryPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: CupertinoColors.white,
      context: context,
      builder: (context) => CountryCodePicker(
        onChanged: (countryCode) {
          // Set the selected country in the controller
          controller.countryController.text = countryCode.name ?? '';
          Navigator.of(context).pop(); // Close the modal after selection
        },
        initialSelection: controller.countryController.text,
        showCountryOnly: true,
        favorite: ['+1','US','+91', 'IN', ],
        showOnlyCountryWhenClosed: true,
        alignLeft: true,
      ),
    );
  }
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
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    //   ),
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: MediaQuery.of(context).size.height * 0.7,
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Text(
    //               'Select Country',
    //               style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 18),
    //             ),
    //           ),
    //           Expanded(
    //             child: CountryCodePicker(
    //               onChanged: (CountryCode countryCode) {
    //                 controller.countryController.text = countryCode.name ?? '';
    //                 controller.selectedCountry = countryCode;
    //                 controller.update();
    //                 Navigator.pop(context);
    //               },
    //               initialSelection: 'IN',
    //               favorite: ['+1', 'US', '+91', 'IN'],
    //               showCountryOnly: true,
    //               showOnlyCountryWhenClosed: true,
    //               alignLeft: false,
    //               showFlag: true,
    //               showFlagDialog: true,
    //               builder: (CountryCode? countryCode) {
    //                 return ListTile(
    //                   leading: Container(
    //                     width: 30,
    //                     height: 20,
    //                     child: countryCode != null ? Text(countryCode.flagUri ?? '') : SizedBox(),
    //                   ),
    //                   title: Text(countryCode?.name ?? ''),
    //                   trailing: Text(countryCode?.dialCode ?? ''),
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }


}