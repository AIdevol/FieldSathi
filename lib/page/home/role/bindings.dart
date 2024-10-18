import 'package:get/get.dart';
import 'package:tms_sathi/page/home/role/enum/role_controller.dart';

class RoleManagerBindings extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<RoleBasedRouteManager>(()=> RoleBasedRouteManager());
  }
}