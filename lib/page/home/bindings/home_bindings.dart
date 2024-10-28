import 'package:get/get.dart';
import 'package:tms_sathi/page/home/presentations/controllers/amc_status_monitor_graph_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/graph_view_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/home_screen_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/leave_update_screen_controller.dart';
import 'package:tms_sathi/page/home/role/bindings.dart';
import 'package:tms_sathi/page/home/role/enum/role_controller.dart';

import '../../../services/login_service.dart';
import '../presentations/controllers/attendance_monitor_graph_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<GraphViewController>(() => GraphViewController());
    Get.lazyPut<AttendanceGraphViewController>(() => AttendanceGraphViewController());
    Get.lazyPut<AmcStatusMonitorGraphController>(() => AmcStatusMonitorGraphController());
    Get.lazyPut<LeaveUpdateScreenController>(() => LeaveUpdateScreenController());
    Get.lazyPut<GetLoginModalService>(() => GetLoginModalService());
    // Get.lazyPut<RoleManagerBindings>(()=> RoleManagerBindings());
  }
}