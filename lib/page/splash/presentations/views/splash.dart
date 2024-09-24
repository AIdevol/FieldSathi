import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<SplashController>(
      builder: (controller) {
        return Container(
          alignment: Alignment.center,
          height: Get.height,width: Get.width,
          color: appColor,
          child:  Image.asset(appIcon,height: Get.height,width: Get.width,fit: BoxFit.contain,),
        );
      },
    ));
  }
}