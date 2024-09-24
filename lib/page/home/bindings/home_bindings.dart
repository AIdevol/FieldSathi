import 'package:get/get.dart';
import 'package:tms_sathi/page/home/presentations/controllers/graph_view_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/home_screen_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<GraphViewController>(() => GraphViewController());
  }

}