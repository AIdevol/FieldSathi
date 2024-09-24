import 'package:get/get.dart';

import '../presentations/controllers/splash_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );

    // Get.put(() => GetLoginModalService(),permanent: true);
  }
}
