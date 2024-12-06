import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/login_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/register_screen_controller.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../constans/role_based_keys.dart';
import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class OtpViewController extends GetxController {
  late TextEditingController otpviewController;
  late FocusNode otpFocusNode;
  final loginScreenController = Get.put(LoginScreenController());
  final registerScreenController = Get.put(RegisterScreenController());
  final isResending = false.obs;
  late String email = '';
  final RxInt timeLeft = 30.obs;
  Timer? _timer;
  OtpResponseModel logInData = OtpResponseModel();

  @override
  void onInit() {
    otpviewController = TextEditingController();
    otpFocusNode = FocusNode();
    super.onInit();
    startTimer();
    checkVerificationStatus();
  }


  void checkVerificationStatus()async {
    String? token = storage.read(LOCALKEY_token);
    print("token data: $token");
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    bool isVerified = storage.read('isVerified') ?? false;
    if (token != null && token.isNotEmpty && isLoggedIn && isVerified) {
      Get.offAllNamed(AppRoutes.homeScreen);
    }
    // await storage.write(, value)
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
    otpFocusNode.dispose();
    _timer?.cancel();
    super.onClose();
  }

  String get timerText {
    int minutes = timeLeft.value ~/ 60;
    int seconds = timeLeft.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> hitOtpVerifyAPiCall()async {
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
      await storage.write(userRole, logInData.userDetails?.role??'');
      print("data body=${logInData.accessToken}");
      toast(logInData.message ?? '');
      await _saveUserData();
      await Get.offAllNamed(AppRoutes.homeScreen);
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


  Future<void> hitresendOtpAPiCall() async {
    final emailData = storage.read(emailKey);
    var resendValue = {
      "email_or_phone": emailData
    };
    Get.find<AuthenticationApiService>().resendOtpApiCall(dataBody: resendValue).then((value) async {
      toast("your otp: ${value.otp!}");
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