import 'package:get/get.dart';
import 'package:tms_sathi/page/home/role/enum/role_enum.dart';
import 'package:tms_sathi/page/home/role/enum/role_permission.dart';

class RoleBasedRouteManager extends GetxController {
  final Rx<UserRole> _currentRole = UserRole.Admin.obs;

  UserRole get currentRole => _currentRole.value;

  void setRole(UserRole role) {
    _currentRole.value = role;
  }

  bool hasRoutePermission(String route) {
    return RoutePermission.roleRoutes[currentRole]?.contains(route) ?? false;
  }
}