import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/OtpViewController.dart';
import 'package:tms_sathi/response_models/login_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/utilities/cherry_toast_message_method.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/helper_widget.dart';
import '../views/otp_view_screen.dart';

class LoginScreenController extends GetxController{
  late TextEditingController emailcontroller;
  late Rx<LoginResponseModel> loginData = LoginResponseModel().obs;
  final RxBool isLoading = false.obs;
@override
  void onInit() {
    // TODO: implement onInit
  emailcontroller = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailcontroller.dispose();
    super.onClose();
  }


 void hitloginApicall(){
   if (emailcontroller.text.isEmpty) {
     toast('Please enter email or phone');
     return;
   }
   storage.write(emailKey, emailcontroller.text);
  customLoader.show();
  FocusManager.instance.primaryFocus!.unfocus();
  var loginReq = {
      "email_or_phone":emailcontroller.text
  };
  print(emailcontroller);
    Get.find<AuthenticationApiService>().loginApiCall(dataBody: loginReq ).then((value)async {
    toast("Your Otp: ${value.otp}");
    //   CherryToast();
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