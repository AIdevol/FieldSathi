import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/OtpViewController.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class OtpViewScreen extends GetView<OtpViewController>{
  // late String? email;
  // OtpViewScreen({required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(
                'Enter OTP',
                style: MontserratStyles.montserratSemiBoldTextStyle(size: 25, color: blackColor),
                // textAlign: TextAlign.center,
              ),),
              vGap(20),
              Text(
                'We have sent the code to the email on your device',
                style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              vGap(50),
              Container(
                alignment: Alignment.center,
                height: Get.height * 0.2,
                width: Get.width,
                child: Image.asset(
                  otpicon,
                  fit: BoxFit.contain,
                ),
              ),
              // Add more widgets here as needed, such as email input field and submit button
              // _emailView(),
              vGap(20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: _otpField(),
              ),
              vGap(15),
              _expirationCounter(),
              vGap(15),
             Center(child:  goToResendOtp(),),
              vGap(25),
              _bottonFieldForm()
            ],
          ),
        ),
      ),
    );
  }
  // Widget _emailView(){
  //   return Center(child: Text(
  //   controller.email,
  //   style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.grey),));
  // }
  Widget _otpField() {
    return PinCodeTextField(
      appContext: Get.context!,
      length: 4,
      obscureText: false,
      controller: controller.otpviewController,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.transparent,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        activeColor: appColor,
        inactiveColor: Colors.grey,
        selectedColor: appColor,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
    );
  }
  Widget _expirationCounter() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Code expires in: ',
          style: MontserratStyles.montserratRegularTextStyle(size: 14, color: Colors.grey),
        ),
        Text(
          controller.timerText,
          style: MontserratStyles.montserratBoldTextStyle(size: 14, color: appColor),
        ),
        // if (controller.timeLeft.value == 0)
        //   TextButton(
        //     onPressed: controller.resendOtp,
        //     child: Text(
        //       'Resend OTP',
        //       style: MontserratStyles.montserratBoldTextStyle(size: 14, color: appColor),
        //     ),
        //   ),
      ],
    ));
  }
  _bottonFieldForm(){
    return InkWell(onTap: (){
      controller.hitOtpVerifyAPiCall();
    },child: Container( height: Get.height*0.06,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: appColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('Verify',style: MontserratStyles.montserratSemiBoldTextStyle(color: blackColor, size: 18),)),
      ),),);

  }
  goToResendOtp() {
    return Text.rich(
      TextSpan(
          text: "Don't receive code? ".tr,
          style:
          MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black45),
          children: [
            TextSpan(
              text: "Resend Code".tr,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // controller.hitresendOtpAPiCall();
                },
              style: MontserratStyles.montserratSemiBoldTextStyle(color: appColor),
            ),
          ]),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
  }
