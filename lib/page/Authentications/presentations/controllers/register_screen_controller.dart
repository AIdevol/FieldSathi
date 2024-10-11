import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../utilities/helper_widget.dart';
import '../views/otp_view_screen.dart';
import 'OtpViewController.dart';

class RegisterScreenController extends GetxController{
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
    storage.write(emailKey, emailController.text);
    print("emailKey: ${emailController.text}");
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
      toast("your otp: ${value.otp}");
      _openForgotcontainerBottomsheet();
      customLoader.hide();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }


  _openForgotcontainerBottomsheet() {
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

}