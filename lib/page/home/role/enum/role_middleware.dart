import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/home/role/enum/role_controller.dart';

import '../../../../navigations/navigation.dart';

class RoutePermissionMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    final roleManager = Get.find<RoleBasedRouteManager>();

    if (route != AppRoutes.login && route != AppRoutes.splash) {
      if (!roleManager.hasRoutePermission(route!)) {
        LoggerX.write('Access denied to route: $route');
        return const RouteSettings(name: AppRoutes.homeScreen);
      }
    }
    return null;
  }
}
