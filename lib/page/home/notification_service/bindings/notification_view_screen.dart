

import 'package:get/get.dart';
import 'package:tms_sathi/page/home/notification_service/controller/notification_view_screen_controller.dart';

class NotificationBindings extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<NotificationViewScreenController>(()=> NotificationViewScreenController());
  }
}