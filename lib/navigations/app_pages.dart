import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tms_sathi/page/Authentications/bindings/bindings.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/OtpViewController.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/calender_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/agents_View_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/amc_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/attendance_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/calender_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/customer_list_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/expenditure_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/fsr_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/lead_list_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/leave_report_view.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/login_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/map_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/otp_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/profile_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/register_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/sales_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/service_request_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/services_View_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/super_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/technician_list_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/ticket_list_screen.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_amc_calender_view.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_amc_view_screen.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_fsr_view.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_superUser_View.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_technician_list.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/lead_form_field.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/principal_customer_view.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/ticket_list_creation.dart';
import 'package:tms_sathi/page/home/bindings/home_bindings.dart';
import 'package:tms_sathi/page/home/notification_service/views/notification_view_screen.dart';
import 'package:tms_sathi/page/home/presentations/views/home_screen.dart';
import 'package:tms_sathi/page/home/role/enum/role_enum.dart';
import 'package:tms_sathi/page/home/role/enum/role_middleware.dart';
import 'package:tms_sathi/page/home/role/enum/role_permission.dart';
import 'package:tms_sathi/page/home/widget/leave_update_screen.dart';
import 'package:tms_sathi/page/plans/view/pricing_view_screen.dart';

import '../page/Authentications/presentations/views/account_view_screen.dart';
import '../page/Authentications/widgets/views/show_technician_data.dart';
import '../page/splash/bindings/splash_bindings.dart';
import '../page/splash/presentations/views/splash.dart';
import 'navigation.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;
  static final routes = [
  GetPage(
    name: AppRoutes.splash,
    binding: SplashBinding(),
    page: () => SplashScreen(),
  ),

    GetPage(
      name: AppRoutes.homeScreen,
      binding: HomeBinding(),
      page: () => HomeScreen(),
       middlewares: [
         RoutePermissionMiddleware()
       ]
    ),
    GetPage(
      name: AppRoutes.login,
      binding: AuthenticationBinding(),
      page: () => LoginScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.signUp,
      binding: AuthenticationBinding(),
      page: () => RegisterScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      binding: AuthenticationBinding(),
      page: () => OtpViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.calendarScreen,
      binding: AuthenticationBinding(),
      page: () => CalendarView(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.fsrScreen,
      binding: AuthenticationBinding(),
      page: () => FsrViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.attendanceScreen,
      binding: AuthenticationBinding(),
      page: () => AttendanceScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.expenditureScreen,
      binding: AuthenticationBinding(),
      page: () => ExpenditureScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.serviceReqScreen,
      binding: AuthenticationBinding(),
      page: () => ServiceRequestViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.amcScreen,
      binding: AuthenticationBinding(),
      page: () => AMCViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.agentsScreen,
      binding: AuthenticationBinding(),
      page: () => AgentsViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.mapView,
      binding: AuthenticationBinding(),
      page: () => MapViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.editProfile,
      binding: AuthenticationBinding(),
      page: () => ProfileViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.ticketListScreen,
      binding: AuthenticationBinding(),
      page: () => TicketListScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.addfsrScreen,
      binding: AuthenticationBinding(),
      page: () => AddFSRViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.leaveReportScreen,
      binding: AuthenticationBinding(),
      page: () => LeaveReportViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.createamcScreen,
      binding: AuthenticationBinding(),
      page: () => CreateAMCViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.calenderViewScreen,
      binding: AuthenticationBinding(),
      page: () => CalendarView(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.customerListScreen,
      binding: AuthenticationBinding(),
      page: () => CustomerListViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.principleCustomerScreen,
      binding: AuthenticationBinding(),
      page: () => PrincipalCustomerView(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.leadListScreen,
      binding: AuthenticationBinding(),
      page: () => LeadListViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.leadFormFieldScreen,
      binding: AuthenticationBinding(),
      page: () => LeadFormFieldScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.serviceCategoriesScreen,
      binding: AuthenticationBinding(),
      page: () => ServicesViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.SuperAgentsScreen,
      binding: AuthenticationBinding(),
      page: () => SuperViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.addSuperuserViewScreen,
      binding: AuthenticationBinding(),
      page: () => AddSuperuserView(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.accountViewScreen,
      binding: AuthenticationBinding(),
      page: () => AccountViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.technicianListsScreen,
      binding: AuthenticationBinding(),
      page: () => TechnicianListViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
        name: AppRoutes.salesListScreen,
        binding: AuthenticationBinding(),
        page: () => SalesViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.addtechnicianListScreen,
      binding: AuthenticationBinding(),
      page: () => AddTechnicianList(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.notificationsScreen,
      binding: AuthenticationBinding(),
      page: () => NotificationViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.ticketListCreationScreen,
      binding: AuthenticationBinding(),
      page: () => TicketListCreation(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.leaveUpdateScreen,
      binding: AuthenticationBinding(),
      page: () => LeaveUpdateScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.addAmcCallenderScreen,
      binding: AuthenticationBinding(),
      page: () => AddAmcCalenderView(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.pricingScreenView,
      binding: AuthenticationBinding(),
      page: () => PricingViewScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
    GetPage(
      name: AppRoutes.showViewAllDataAttendanceScreen,
      binding: AuthenticationBinding(),
      page: () => TechniciansFullViewDetailsDescriptionScreen(),
        middlewares: [
          RoutePermissionMiddleware()
        ]
    ),
  ];
}