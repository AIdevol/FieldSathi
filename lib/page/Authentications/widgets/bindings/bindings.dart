import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_fsr_view_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_technician_list_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/calender_view_amc_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/lead_form_field_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/principal_customer_view_controller.dart';

class WidgetBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PrincipalCstomerViewController>(() => PrincipalCstomerViewController());
    Get.lazyPut<AddFSRViewController>(() => AddFSRViewController());
    Get.lazyPut<CreateAMCViewScreenController>(() => CreateAMCViewScreenController());
    Get.lazyPut<CalenderViewAmcController>(() => CalenderViewAmcController());
    Get.lazyPut<LeadFormFieldController>(() => LeadFormFieldController());
    Get.lazyPut<AddTechnicianListController>(() => AddTechnicianListController());
  }

}