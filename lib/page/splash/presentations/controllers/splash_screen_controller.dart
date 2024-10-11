import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../navigations/navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _navigateToNextScreen();
    super.onInit();
  }

  _navigateToNextScreen() => Timer(const Duration(milliseconds: 3500), () async {
    String? token = storage.read(LOCALKEY_token);
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    bool isVerified = storage.read('isVerified') ?? false;
    bool isFirstTimeUser = storage.read(isFirstTime) ?? true;

    if (token != null && token.isNotEmpty && isLoggedIn && isVerified) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else if (!isFirstTimeUser) {
      Get.offAndToNamed(AppRoutes.login);
    } else {
      Get.offAndToNamed(AppRoutes.login);
      print("akdfjlakdjfalkdfjj tum per ho bhai++==");
    }
  } );
}
