import 'dart:io';

import '../../../response_models/add_technician_response_model.dart';
import '../../../response_models/agents_response_model.dart';
import '../../../response_models/amc_response_model.dart';
import '../../../response_models/attendance_response_model.dart';
import '../../../response_models/check_points_response_model.dart';
import '../../../response_models/customer_list_response_model.dart';
import '../../../response_models/expenses_response_model.dart';
import '../../../response_models/fsr_response_model.dart';
import '../../../response_models/holidays_calender_response_model.dart';
import '../../../response_models/lead_response_model.dart';
import '../../../response_models/leave_allocation_response_model.dart';
import '../../../response_models/leaves_response_model.dart';
import '../../../response_models/login_response_model.dart';
import '../../../response_models/otp_response_model.dart';
import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';
import '../../../response_models/service_requests_response_model.dart';
import '../../../response_models/services_response_model.dart';
import '../../../response_models/sub_service_response_model.dart';
import '../../../response_models/super_user_response_model.dart';
import '../../../response_models/technician_response_model.dart';
import '../../../response_models/ticket_response_model.dart';
import '../../../response_models/user_response_model.dart';

abstract class AuthenticationApi {
  Future<LoginResponseModel> loginApiCall({Map<String, dynamic>? dataBody});

  Future<RegisterResponseModel> registerApiCall(
      {Map<String, dynamic>? dataBody});

  Future<ResendOtpApiCall> resendOtpApiCall({Map<String, dynamic>? dataBody});
  Future<OtpResponseModel> verifyOtpApiCall({Map<String, dynamic>? dataBody});
  Future<UserResponseModel>userDetailsApiCall({Map<String, dynamic>? dataBody, String? id});
  Future<UserResponseModel>updateUserDetailsApiCall({Map<String, dynamic>? dataBody, String? id});
  Future<UserResponseModel> userProfileImageUpdateApiCall(File imageFile);
  Future<HolidaysCalendarResponseModel>holidaysCalenderApiCall({Map<String, dynamic>? dataBody});
  // Future<List<TicketResponseModel>>getticketDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<TicketResponseModel>getticketDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<TicketResponseModel>postTicketDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<LeaveResponseModel>getLeavesApiCall({Map<String, dynamic>? dataBody});
  Future<LeaveResponseModel>putLeavesApiCall({Map<String, dynamic>? dataBody,id});
  Future<SuperUsersResponseModel>getSuperUserApiCall({Map<String, dynamic>? dataBody});
  Future<SuperUsersResponseModel> postSuperUserApiCall({Map<String, dynamic>?dataBody});
  Future<AddTechnicianResponseModel>addTechnicialPostApiCall({Map<String, dynamic>? dataBody, parameters});
  Future<TechnicianResponseModel>getTechnicianDetailsApiCall({Map<String, dynamic>? dataBody, parameters});
  // Future<List<FsrResponseModel>>getfsrDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<FsrResponseModel>getfsrDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<CheckPointsResponseModel>postcheckPointStatusDetailsApiCall({Map<String, dynamic>? dataBody,});
  Future<LeaveAllocationResponseModel>getLeavesALLocationApiCall({Map<String, dynamic>? dataBody});
  Future<LeaveAllocationResponseModel>putLeavesAllocationApiCall({Map<String, dynamic>? dataBody,id});
  Future<SuperUsersResponseModel>getAgentDetailsApiCall({Map<String, dynamic>? dataBody,parameters} );
  Future<AgentsPostResponseModel> postAgentDetailwsApiCall({Map<String, dynamic>? dataBody, parameters});
  Future<AgentsPostResponseModel> putAgentDetailwsApiCall({Map<String, dynamic>? dataBody, parameters,required String id});
  Future<CustomerListResponseModel>getCustomerListApiCall({Map<String, dynamic>?dataBody, parameters});
  Future<CustomerDataResponseModel>postCustomerListApiCall({Map<String, dynamic>?dataBody, parameters});
  Future<List<LeadGetResponseModel>>getLeadListApiCall({Map<String, dynamic>?dataBody, parameters});
  Future<LeadPostResponseModel>postLeadListApiCall({Map<String, dynamic>?dataBody});
  Future<LeadPostResponseModel>delLeadListApiCall({Map<String, dynamic>?dataBody, String? id});
  Future<LeadPostResponseModel>putLeadListApiCall({Map<String, dynamic>?dataBody, String? id});
  Future<ServiceCategoryResponseModel>getServiceCategoriesApiCall({Map<String, dynamic>? dataBody});
  Future<ServiceCategoryResponseModel>postServiceCategoriesApiCall({Map<String, dynamic>? dataBody});
  Future<SubService>getSub_ServiceCategoriesApiCall({Map<String, dynamic>? dataBody});
  Future<TMSResponseModel>getuserDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<String>downLoadTicketDatabyUserName({Map<String, dynamic>? dataBody,id});
  // Future<List<TMSResponseModel>>getuserDetailsApiCall({Map<String, dynamic>? dataBody});
  Future<TechnicianAttendanceResponseModel>getAttendanceApiCall({Map<String, dynamic>? dataBody , dynamic parameters});
  Future<ExpensesResponseModel>getExpensesApiCall({Map<String, dynamic>? dataBody, parameters});
  // Future<List<ExpensesResponseModel>>getExpensesApiCall({Map<String, dynamic>?dataBody, parameters});
  Future<List<ServiceRequestsResponseModel>> getServiceRequestsApiCall({Map<String, dynamic>?dataBody, parameters});
  Future<TechnicianResponseModel>getTechnicianApiCall({Map<String, dynamic>? dataBody, parameters}) ;
  Future<AmcResponseModel>getAmcDetailsApiCall({Map<String, dynamic>?dataBody});
}