import 'package:get/get.dart';
import 'package:tms_sathi/page/home/presentations/controllers/amc_status_monitor_graph_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/attendance_graph_view_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/graph_view_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/home_screen_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<GraphViewController>(() => GraphViewController());
    Get.lazyPut<AttendanceGraphViewController>(() => AttendanceGraphViewController());
    Get.lazyPut<AmcStatusMonitorGraphController>(() => AmcStatusMonitorGraphController());
  }

}