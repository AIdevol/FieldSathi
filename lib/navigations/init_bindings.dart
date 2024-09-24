import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/bindings/bindings.dart';

import '../page/home/bindings/home_bindings.dart';
import '../services/APIs/auth_services/auth_api_services.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeBinding>(HomeBinding());
    Get.lazyPut<AuthenticationBinding>(
            () => AuthenticationBinding());
    Get.lazyPut<AuthenticationApiService>(
            () => AuthenticationApiService());
  }
}