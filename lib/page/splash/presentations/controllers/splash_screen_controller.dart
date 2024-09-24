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

  _navigateToNextScreen() =>
      Timer(const Duration(milliseconds: 3500), () async {
        if (storage.read(isFirstTime) ?? true) {
          Get.offAndToNamed(AppRoutes.login);
        } else {
          Get.offAndToNamed(AppRoutes.homeScreen);
        }
      });
}