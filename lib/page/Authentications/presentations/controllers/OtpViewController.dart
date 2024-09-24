// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:tms_sathi/navigations/navigation.dart';
// import 'package:tms_sathi/page/Authentications/presentations/controllers/register_screen_controller.dart';
// import 'package:tms_sathi/response_models/otp_response_model.dart';
//
// import '../../../../constans/const_local_keys.dart';
// import '../../../../main.dart';
// import '../../../../services/APIs/auth_services/auth_api_services.dart';
//
// class OtpViewController extends GetxController{
//   late TextEditingController otpviewController ;
//   late final String? email;
//   //
//   OtpViewController({required this.email});
//   final RxInt timeLeft = 30.obs; // 2 minutes in seconds
//   Timer? _timer;
// OtpResponseModel logInData = OtpResponseModel();
//   @override
//   void onInit() {
//     otpviewController = TextEditingController();
//     super.onInit();
//     startTimer();
//   }
//
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timeLeft.value > 0) {
//         timeLeft.value--;
//       } else {
//         _timer?.cancel();
//       }
//     });
//   }
//
//   void resendOtp() {
//     // Implement your OTP resend logic here
//     timeLeft.value = 30; // Reset the timer
//     startTimer();
//   }
//
//   @override
//   void onClose() {
//     otpviewController.dispose();
//     _timer?.cancel();
//     super.onClose();
//   }
//
//   String get timerText {
//     int minutes = timeLeft.value ~/ 60;
//     int seconds = timeLeft.value % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }
//
//   void hitOtpVerifyAPiCall(){
//     customLoader.show();
//     var resendValue = {
//       "email_or_phone": /*email*/ 'devesh@weboappdiscovery.com',
//       "otp": otpviewController.text
//     };
//     Get.find<AuthenticationApiService>().verifyOtpApiCall(dataBody: resendValue ).then((value)async {
//       customLoader.hide();
//       logInData = value;
//       toast(logInData.message ?? '');
//       storage.write(LOCALKEY_token, logInData.accessToken ?? "");
//       storage.write(userId, logInData.userDetails?.id.toString() ?? "");
//       storage.write(RefreshToken, logInData.refreshToken ?? "");
//       if (storage.read(isVerifiedQr) == true &&
//           (storage.read(isSubscribed) == true)) {
//         Get.offAllNamed(AppRoutes.homeScreen);
//         customLoader.hide();
//       } else {
//         Get.offAllNamed(AppRoutes.homeScreen);
//         customLoader.hide();
//       }
//
//       update();
//     }).onError((error, stackError){
//       customLoader.hide();
//       toast(error.toString());
//     });
//   }
//
//   void hitresendOtpAPiCall(){
//     customLoader.show();
//     var resendValue = {
//       "email_or_phone": email
//     };
//     Get.find<AuthenticationApiService>().resendOtpApiCall(dataBody: resendValue ).then((value)async {
//       toast('Login successfully enter your OTP');
//       customLoader.hide();
//       update();
//     }).onError((error, stackError){
//       customLoader.hide();
//       toast(error.toString());
//     });
//   }
// }
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/login_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/register_screen_controller.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class OtpViewController extends GetxController {
  late TextEditingController otpviewController;

  // final String email;
  // OtpViewController({required this.email});
  final RxInt timeLeft = 30.obs;
  Timer? _timer;
  OtpResponseModel logInData = OtpResponseModel();

  @override
  void onInit() {
    otpviewController = TextEditingController();
    super.onInit();
    startTimer();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    String? token = storage.read(LOCALKEY_token);
    if (token != null && token.isNotEmpty) {
      // User is already logged in, navigate to home screen
      Get.offAllNamed(AppRoutes.homeScreen);
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resendOtp() {
    timeLeft.value = 30;
    startTimer();
    hitresendOtpAPiCall();
  }

  @override
  void onClose() {
    otpviewController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  String get timerText {
    int minutes = timeLeft.value ~/ 60;
    int seconds = timeLeft.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void hitOtpVerifyAPiCall() {
    final email = Get.find<LoginScreenController>().emailcontroller.text;
    customLoader.show();
    var resendValue = {
      "email_or_phone": email,
      "otp": otpviewController.text
    };
    Get.find<AuthenticationApiService>().verifyOtpApiCall(dataBody: resendValue).then((value) async {
      print("data body+${value}");
      customLoader.hide();
      logInData = value;
      toast(logInData.message ?? '');
      await storage.write(LOCALKEY_token, logInData.accessToken ?? "");
      await storage.write(userId, logInData.userDetails?.id.toString() ?? "");
      await storage.write(RefreshToken, logInData.refreshToken ?? "");
      await storage.write('isLoggedIn', true);
      toast("Login successful");
      Get.offAllNamed(AppRoutes.homeScreen);
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }


  void hitresendOtpAPiCall() {
    final email = Get.find<LoginScreenController>().emailcontroller.text;
    customLoader.show();
    var resendValue = {
      "email_or_phone": email
    };
    Get.find<AuthenticationApiService>().resendOtpApiCall(dataBody: resendValue).then((value) async {
      toast('OTP resent successfully');
      customLoader.hide();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  // New method for logging out
  void logout() async {
    await storage.remove(LOCALKEY_token);
    await storage.remove(userId);
    await storage.remove(RefreshToken);
    await storage.remove('isLoggedIn');
    Get.offAllNamed(AppRoutes.login);  // Navigate to login screen
  }
}