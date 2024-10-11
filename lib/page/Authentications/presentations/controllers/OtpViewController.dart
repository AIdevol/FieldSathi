import 'dart:async';
import 'package:flutter/material.dart';
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
  final loginScreenController = Get.put(LoginScreenController());
  final registerScreenController = Get.put(RegisterScreenController());
  late String email = '';
  final RxInt timeLeft = 30.obs;
  Timer? _timer;
  OtpResponseModel logInData = OtpResponseModel();

  @override
  void onInit() {
    otpviewController = TextEditingController();
    super.onInit();
    startTimer();
    checkVerificationStatus();
  }


  void checkVerificationStatus() {
    String? token = storage.read(LOCALKEY_token);
    print("token data: $token");
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    bool isVerified = storage.read('isVerified') ?? false;
    if (token != null && token.isNotEmpty && isLoggedIn && isVerified) {
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
    final emailData = storage.read(emailKey);
    customLoader.show();
    var resendValue = {
      "email_or_phone": emailData,
      "otp": otpviewController.text
    };
    print("emailKey: ${storage.read(emailKey)}");
    Get.find<AuthenticationApiService>().verifyOtpApiCall(dataBody: resendValue).then((value) async {
      customLoader.hide();
      logInData = value;
      print("data body=${logInData.accessToken}");
      toast(logInData.message ?? '');
      await _saveUserData();
      Get.offAllNamed(AppRoutes.homeScreen);
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  Future _saveUserData() async {
    //
    // try {
    //   await _authService.saveUserData({
    //     'accessToken': logInData.accessToken,
    //     'userId': logInData.userDetails?.id.toString(),
    //     'refreshToken': logInData.refreshToken,
    //   });
    //   Get.offAllNamed(AppRoutes.homeScreen);
    // } catch (error) {
    //   print("Error saving user data: $error");
    //   toast("Failed to save user data. You may need to log in again.");
    // }
    try {
      await storage.write(LOCALKEY_token, logInData.accessToken ?? "");
      await storage.write(userId, logInData.userDetails?.id.toString() ?? "");
      await storage.write(RefreshToken, logInData.refreshToken ?? "");
      await storage.write(isFirstTime, false);
      await storage.write('isLoggedIn', true);
      await storage.write('isVerified', true);
      print("User data saved successfully");
    } catch (error) {
      print("Error saving user data: $error");
      toast("Failed to save user data. You may need to log in again.");
    }
  }


  void hitresendOtpAPiCall() {
    // final email = Get.find<LoginScreenController>().emailcontroller.text;
    final emailData = storage.read(emailKey);
    customLoader.show();
    var resendValue = {
      "email_or_phone": emailData
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
  // void logout() async {
  //   await _authService.clearUserData();
  //   Get.offAllNamed(AppRoutes.login);
  // }
  void logout() async {
    await storage.remove(LOCALKEY_token);
    await storage.remove(userId);
    await storage.remove(RefreshToken);
    await storage.remove('isLoggedIn');
    await storage.remove('isVerified');
    Get.offAllNamed(AppRoutes.login);
  }
}