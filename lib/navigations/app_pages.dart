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
import 'package:tms_sathi/page/Authentications/presentations/views/service_request_view_screen.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/ticket_list_screen.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_amc_view_screen.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/add_fsr_view.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/principal_customer_view.dart';
import 'package:tms_sathi/page/home/bindings/home_bindings.dart';
import 'package:tms_sathi/page/home/presentations/views/home_screen.dart';

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
    ),
    GetPage(
      name: AppRoutes.login,
      binding: AuthenticationBinding(),
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      binding: AuthenticationBinding(),
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      binding: AuthenticationBinding(),
      page: () => OtpViewScreen(),
    ),
    GetPage(
      name: AppRoutes.calendarScreen,
      binding: AuthenticationBinding(),
      page: () => CalendarView(),
    ),
    GetPage(
      name: AppRoutes.fsrScreen,
      binding: AuthenticationBinding(),
      page: () => FsrViewScreen(),
    ),
    GetPage(
      name: AppRoutes.attendanceScreen,
      binding: AuthenticationBinding(),
      page: () => AttendanceScreen(),
    ),
    GetPage(
      name: AppRoutes.expenditureScreen,
      binding: AuthenticationBinding(),
      page: () => ExpenditureScreen(),
    ),
    GetPage(
      name: AppRoutes.serviceReqScreen,
      binding: AuthenticationBinding(),
      page: () => ServiceRequestViewScreen(),
    ),
    GetPage(
      name: AppRoutes.amcScreen,
      binding: AuthenticationBinding(),
      page: () => AMCViewScreen(),
    ),
    GetPage(
      name: AppRoutes.agentsScreen,
      binding: AuthenticationBinding(),
      page: () => AgentsViewScreen(),
    ),
    GetPage(
      name: AppRoutes.mapView,
      binding: AuthenticationBinding(),
      page: () => MapViewScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      binding: AuthenticationBinding(),
      page: () => ProfileViewScreen(),
    ),
    GetPage(
      name: AppRoutes.ticketListScreen,
      binding: AuthenticationBinding(),
      page: () => TicketListViewScreen(),
    ),
    GetPage(
      name: AppRoutes.addfsrScreen,
      binding: AuthenticationBinding(),
      page: () => AddFSRViewScreen(),
    ),
    GetPage(
      name: AppRoutes.leaveReportScreen,
      binding: AuthenticationBinding(),
      page: () => LeaveReportViewScreen(),
    ),
    GetPage(
      name: AppRoutes.createamcScreen,
      binding: AuthenticationBinding(),
      page: () => CreateAMCViewScreen(),
    ),
    GetPage(
      name: AppRoutes.calenderViewScreen,
      binding: AuthenticationBinding(),
      page: () => CalendarView(),
    ),
    GetPage(
      name: AppRoutes.customerListScreen,
      binding: AuthenticationBinding(),
      page: () => CustomerListViewScreen(),
    ),
    GetPage(
      name: AppRoutes.principleCustomerScreen,
      binding: AuthenticationBinding(),
      page: () => PrincipalCustomerView(),
    ),
    GetPage(
      name: AppRoutes.leadListScreen,
      binding: AuthenticationBinding(),
      page: () => LeadListViewScreen(),
    ),
  ];
}