import '../main.dart';

abstract class AppRoutes {
  static const splash = '/splash';
  static const homeScreen = '/homeScreen';
  static const signUp = '/signUp';
  static const editProfile = '/editProfile';
  static const login = '/login';
  static const fsrScreen= '/fsrScreen';
  static const attendanceScreen = '/attendanceScreen';
  static const otpScreen = '/otpScreen';
  static const calendarScreen = '/calendarScreen';
  static const expenditureScreen = '/expenditureScreen';
  static const serviceReqScreen = '/serviceReqScreen';
  static const amcScreen = '/amcScreen';
  static const agentsScreen = '/agentsScreen';
  static const mapView = '/mapView';
  static const uploadDocumenth = '/uploadDocumenth';
  static const ticketListScreen = '/ticketListScreen';
  static const addfsrScreen = '/addfsrScreen';
  static const leaveReportScreen = '/leaveReportScreen';
  static const createamcScreen = '/createamcScreen';
  static const calenderViewScreen = '/calenderViewScreen';
  static const customerListScreen = '/customerListScreen';
  static const principleCustomerScreen = '/principleCustomerScreen';
  static const leadListScreen = '/leadListScreen';
  static const leadFormFieldScreen = '/leadformFieldScreen';
  static const serviceCategoriesScreen = '/serviceCategoriesEnd';
  static const SuperAgentsScreen = '/SuperAgentsScreen';
  static const accountViewScreen = '/accountViewScreen';
  static const technicianListsScreen ='/technicianListsScreen';
  static const addtechnicianListScreen = '/addtechnicianListScreen';
  static const notificationsScreen = '/notificationsScreen';
  static const ticketListCreationScreen = '/ticketListCreationScreen';
  static const leaveUpdateScreen= '/leaveUpdateScreen';
  static const addAmcCallenderScreen = '/addAmcCallenderScreen';
  static const pricingScreenView = '/pricingScreenView';
  static const addSuperuserViewScreen = '/addSuperuserViewScreen';
  static const showViewAllDataAttendanceScreen = '/showViewAllDataAttendanceScreen';
}

class RoutesArgument {
  static const emailKey = "emailKey";
  static const userKey = "userKey";
}

class LoggerX {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => isError ? log.v("$text") : log.i("$text"));
  }
}
