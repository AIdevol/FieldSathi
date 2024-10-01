import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/OtpViewController.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/attendance_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/calender_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/customer_list_view_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/fsr_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/login_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/map_Screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/profile_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/service_request_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/services_Categories_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/technician_list_view_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/ticket_list_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/bindings/bindings.dart';
import 'package:tms_sathi/page/home/notification_service/bindings/notification_view_screen.dart';
import '../presentations/controllers/account_view_screen_controller.dart';
import '../presentations/controllers/lead_list_view_controller.dart';
import '../presentations/controllers/register_screen_controller.dart';
import '../presentations/controllers/super_view_screen_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WidgetBindings>(()=> WidgetBindings());
    Get.lazyPut<NotificationBindings>(()=> NotificationBindings());
    Get.lazyPut<LoginScreenController>(()=> LoginScreenController());
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<FsrViewcontroller>(()=> FsrViewcontroller());
    Get.lazyPut<AttendanceScreenController>(()=> AttendanceScreenController());
    Get.lazyPut<ExpenditureScreenController>(()=> ExpenditureScreenController());
    Get.lazyPut<ServiceRequestScreenController>(()=> ServiceRequestScreenController());
    Get.lazyPut<AMCScreenController>(()=> AMCScreenController());
    Get.lazyPut<AgentsViewScreenController>(()=> AgentsViewScreenController());
    Get.lazyPut<MapViewScreenController>(()=> MapViewScreenController());
    Get.lazyPut<ProfileViewScreenController>(()=> ProfileViewScreenController());
    Get.lazyPut<TicketListController>(()=> TicketListController());
    Get.lazyPut<LeaveReportViewScreenController>(()=> LeaveReportViewScreenController());
    Get.lazyPut<CustomerListViewController>(()=> CustomerListViewController());
    Get.lazyPut<LeadListViewController>(()=> LeadListViewController());
    Get.lazyPut<ServiceCategoriesController>(()=> ServiceCategoriesController());
    Get.lazyPut<SuperViewScreenController>(()=> SuperViewScreenController());
    Get.lazyPut<AccountViewScreenController>(()=> AccountViewScreenController());
    Get.lazyPut<TechnicianListViewScreenController>(()=> TechnicianListViewScreenController());
  }
}