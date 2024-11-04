import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:tms_sathi/response_models/add_technician_response_model.dart';
import 'package:tms_sathi/response_models/agents_response_model.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/response_models/login_response_model.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';
import 'package:tms_sathi/response_models/services_response_model.dart';
import 'package:tms_sathi/response_models/sub_service_response_model.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';
import 'package:tms_sathi/response_models/ticket_response_model.dart';
import 'package:tms_sathi/response_models/user_response_model.dart';
import 'package:tms_sathi/services/APIs/dio_client.dart';

import '../../../response_models/check_points_response_model.dart';
import '../../../response_models/export_import_directory/expense_export_response_model.dart';
import '../../../response_models/holidays_calender_response_model.dart';
import '../../../response_models/leave_allocation_response_model.dart';
import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';
import '../../../response_models/service_requests_response_model.dart';
import '../../../response_models/super_user_response_model.dart';
import '../api_end.dart';
import '../network_except.dart';
import 'auth_abstract_api_services_impl.dart';

class AuthenticationApiService extends GetxService
implements AuthenticationApi {
  late DioClient? dioClient;
  var deviceName, deviceType, deviceID;

  Dio dio = Dio();

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.device;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceType = "2";
    }
  }


  @override
  void onInit() {
    var dio = Dio();
    dioClient = DioClient(ApiEnd.baseUrl, dio);
    getDeviceData();
  }

  @override
  Future<LoginResponseModel> loginApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(ApiEnd.loginEnd, data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<RegisterResponseModel> registerApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(ApiEnd.signUpEnd, data: dataBody);
      return RegisterResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<OtpResponseModel> verifyOtpApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
          ApiEnd.verifyotpEnd, data: dataBody);
      return OtpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ResendOtpApiCall> resendOtpApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
          ApiEnd.resendOtpEnd, data: dataBody);
      return ResendOtpApiCall.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel> userProfileImageUpdateApiCall(File imageFile) async {
    try {
      String fileName = imageFile.path
          .split('/')
          .last;
      dioo.FormData formData = dioo.FormData.fromMap({
        "profile_image": await dioo.MultipartFile.fromFile(
            imageFile.path, filename: fileName,),
      });
      final response = await dioClient!.post(
          "${ApiEnd.userProfileImageEnd}/", data: formData, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel> userDetailsApiCall(
      {Map<String, dynamic>? dataBody, String? id}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.tmsUsersEnd}/$id/", data: dataBody);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel> updateUserDetailsApiCall(
      {Map<String, dynamic>? dataBody, String? id}) async {
    try {
      final response = await dioClient!.put(
          "${ApiEnd.tmsUsersEnd}/$id/", data: dataBody, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel> ticketDetailsApiCall(
      {Map<String, dynamic>? dataBody, String? id}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.tmsUsersEnd}/$id/", data: dataBody);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


// =====================================================Page ApI's=======================================================================
  @override
  Future<HolidaysCalenderResponseModel> holidaysCalenderApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.holidaysApiEnd}", data: dataBody);
      return HolidaysCalenderResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<TicketResponseModel>getticketDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get('${ApiEnd.get_ticketEnd}', data: dataBody, skipAuth: false);
      return TicketResponseModel.fromJson(response);
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }
  // Future<List<TicketResponseModel>> getticketDetailsApiCall(
  //     {Map<String, dynamic>? dataBody}) async {
  //   try {
  //     final response = await dioClient!.get(
  //         "${ApiEnd.get_ticketEnd}", data: dataBody);
  //     print("inside api calling method: ${response}");
  //     if (response is List) {
  //       return response.map((item) => TicketResponseModel.fromJson(item))
  //           .toList();
  //     } else
  //     if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic> data = response['data'];
  //       return data.map((item) => TicketResponseModel.fromJson(item)).toList();
  //     }
  //     throw Exception('Unexpected response format');
  //   } catch (e) {
  //     return Future.error(NetworkExceptions.getDioException(e));
  //   }
  // }

  @override
  Future<TicketResponseModel> postTicketDetailsApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.get_ticketEnd}", data: dataBody, skipAuth: false);
      return TicketResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<LeaveResponseModel> getLeavesApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.leavesReportEnd}", data: dataBody, skipAuth: false);
      return LeaveResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<LeaveResponseModel> putLeavesApiCall(
      {Map<String, dynamic>? dataBody, id}) async {
    try {
      final response = await dioClient!.put(
          "${ApiEnd.leavesReportEnd}$id/", data: dataBody, skipAuth: false);
      return LeaveResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  // ====================================================================================Super Api Call ======================================
  @override
  Future<SuperUsersResponseModel> getSuperUserApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.tmsUsersEnd}", data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      return SuperUsersResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<SuperUsersResponseModel> postSuperUserApiCall(
      {Map<String, dynamic>?dataBody}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.tmsUsersEnd}", data: dataBody, skipAuth: false);
      return SuperUsersResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  // =====================================================================================Technical Api Call =====================================
  @override
  Future<AddTechnicianResponseModel> addTechnicialPostApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.tmsUsersEnd}", data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      return AddTechnicianResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<FsrResponseModel>getfsrDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.fsrApiEnd}", data: dataBody, skipAuth: false,);
      return FsrResponseModel.fromJson(response);
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }
  // Future<List<FsrResponseModel>> getfsrDetailsApiCall(
  //     {Map<String, dynamic>? dataBody}) async {
  //   try {
  //     final response = await dioClient!.get(
  //       "${ApiEnd.fsrApiEnd}", data: dataBody, skipAuth: false,);
  //     if (response is List) {
  //       return response.map((item) => FsrResponseModel.fromJson(item)).toList();
  //     } else
  //     if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic> data = response['data'];
  //       return data.map((item) => FsrResponseModel.fromJson(item)).toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     return Future.error(NetworkExceptions.getDioException(e));
  //   }
  // }

  @override
  Future<FsrResponseModel> postfsrDetailsApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.fsrApiEnd}", data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      return FsrResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<CheckPointsResponseModel> postcheckPointStatusDetailsApiCall(
      {Map<String, dynamic>? dataBody,}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.checkingPointStatusApiEnd}", data: dataBody,
          skipAuth: false);
      return CheckPointsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

// ===========================================================Leaves Api Call=============================================================
  @override
  Future<List<LeaveAllocationResponseModel>> getLeavesALLocationApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.leaveEditPeriodEnd}", data: dataBody);
      if (response is List) {
        return response.map((item) =>
            LeaveAllocationResponseModel.fromJson(item)).toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> data = response['data'];
        return data.map((item) => LeaveAllocationResponseModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<LeaveAllocationResponseModel> putLeavesAllocationApiCall(
      {Map<String, dynamic>? dataBody, id}) async {
    try {
      final response = await dioClient!.put(
        "${ApiEnd.leaveEditPeriodEnd}$id/", data: dataBody,);
      return LeaveAllocationResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  // @override
  // Future<List<AmcResponseModel>> getAmcDetailsApiCall(
  //     {Map<String, dynamic>? dataBody}) async {
  //   try {
  //     final response = await dioClient!.get(
  //         "${ApiEnd.amcEnd}", data: dataBody, skipAuth: false);
  //     if (response is List) {
  //       return response.map((item) => AmcResponseModel.fromJson(item)).toList();
  //     } else
  //     if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic>data = response['data'];
  //       return data.map((item) => AmcResponseModel.fromJson(item)).toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     return Future.error(NetworkExceptions.getDioException(e));
  //   }
  // }

  // ==============================================================Agents details=============================================================================
  @override
  Future<AmcResponseModel>getAmcDetailsApiCall({Map<String, dynamic>?dataBody})async{
    try{
      final response = await dioClient!.get('${ApiEnd.amcEnd}', data: dataBody, skipAuth: false);
      return AmcResponseModel.fromJson(response);
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<SuperUsersResponseModel> getAgentDetailsApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.tmsUsersEnd}", data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      return SuperUsersResponseModel.fromJson(response);
      // if(response is List){
      //   return response.map((item)=> SuperUsersResponseModel.fromJson(item)).toList();
      // }else if (response is Map<String, dynamic>&& response.containsKey('data')){
      //   final List<dynamic>data = response['data'];
      //   return data.map((item)=> SuperUsersResponseModel.fromJson(item)).toList();
      // }
      // return [];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<AgentsPostResponseModel> postAgentDetailwsApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.tmsUsersEnd}", queryParameters: parameters,
          skipAuth: false);
      return AgentsPostResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<AgentsPostResponseModel> putAgentDetailwsApiCall(
      {Map<String, dynamic>? dataBody, parameters, required String id}) async {
    try {
      final response = await dioClient!.put(
          "${ApiEnd.tmsUsersEnd}$id/", queryParameters: parameters,
          skipAuth: false);
      return AgentsPostResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

//   =======================================================================Customer List Manage Api Calls=========================================

  @override
  Future<CustomerListResponseModel> getCustomerListApiCall(
      {Map<String, dynamic>?dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.tmsUsersEnd}", queryParameters: parameters,
          skipAuth: false);
      return CustomerListResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<CustomerDataResponseModel> postCustomerListApiCall(
      {Map<String, dynamic>?dataBody, parameters}) async {
    try {
      final response = await dioClient!.post(
          "${ApiEnd.tmsUsersEnd}", queryParameters: parameters,
          skipAuth: false);
      return CustomerDataResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

// ============================================================================Lead End Api Call===============================================================
  @override
  Future<List<LeadGetResponseModel>> getLeadListApiCall(
      {Map<String, dynamic>?dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.leadEnd}", queryParameters: parameters, skipAuth: false);
      if (response is List) {
        return response.map((item) => LeadGetResponseModel.fromJson(item))
            .toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic>data = response['data'];
        return data.map((item) => LeadGetResponseModel.fromJson(item)).toList();
      }
      return [];
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<LeadPostResponseModel> postLeadListApiCall(
      {Map<String, dynamic>?dataBody}) async {
    try {
      final response = await dioClient!.post(
          ApiEnd.leadEnd, data: dataBody, skipAuth: false);
      return LeadPostResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<LeadPostResponseModel> delLeadListApiCall(
      {Map<String, dynamic>?dataBody, String? id}) async {
    try {
      final response = await dioClient!.delete(
          "${ApiEnd.leadEnd}$id/", data: dataBody, skipAuth: false);
      return LeadPostResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<LeadPostResponseModel> putLeadListApiCall(
      {Map<String, dynamic>?dataBody, String? id}) async {
    try {
      final response = await dioClient!.delete(
          "${ApiEnd.leadEnd}$id/", data: dataBody, skipAuth: false);
      return LeadPostResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

// ==================================================================================Service Categories api Call===============================================================
  /*@override
  Future<List<ServiceCategoriesResponseModel>> getServiceCategoriesApiCall(
      {Map<String, dynamic>?dataBody}) async {
    try {
      final response = await dioClient!.get(
          "${ApiEnd.serviceCategories}", skipAuth: false, data: dataBody);
      if (response is List) {
        return response.map((item) =>
            ServiceCategoriesResponseModel.fromJson(item)).toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic>data = response['data'];
        return data.map((item) => ServiceCategoriesResponseModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }
*/
  Future<ServiceCategoryResponseModel>getServiceCategoriesApiCall({Map<String, dynamic>? dataBody})async{
    try{
        final response = await dioClient!.get(
        "${ApiEnd.serviceCategories}", skipAuth: false, data: dataBody);
        return ServiceCategoryResponseModel.fromJson(response);
    }catch(error){
          return Future.error(NetworkExceptions.getDioException(error));
    }
}
  @override
  Future<ServiceCategoryResponseModel> postServiceCategoriesApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
          ApiEnd.serviceCategories, data: dataBody, skipAuth: false);
      return ServiceCategoryResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  // ====================================================Sub Service Api Call =======================================================
  @override
  Future<SubService> getSub_ServiceCategoriesApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.get(
          ApiEnd.serviceSubCategories, data: dataBody, skipAuth: false);
      return SubService.fromJson(response);
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

// ===============================================================Get Technician Attendance Api Call ==========================================
  @override
  Future<TMSResponseModel>getuserDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}", data: dataBody, skipAuth: false);
      return TMSResponseModel.fromJson(response);
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  // @override
  // Future<List<TMSResponseModel>>getuserDetailsApiCall({Map<String, dynamic>? dataBody}) async{
  //   try {
  //     final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}", data: dataBody, skipAuth: false);
  //     if (response is List) {
  //       return response.map((item) =>
  //           TMSResponseModel.fromJson(item)).toList();
  //     }else if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic>data = response['data'];
  //       return data.map((item) =>
  //           TMSResponseModel.fromJson(item)).toList();
  //     }
  //     return [];
  //     // return TMSResponseModel.fromJson(response);
  //   } catch (e) {
  //     return Future.error(NetworkExceptions.getDioException(e));
  //   }
  // }
/*  @override
  Future<List<TechnicianAttendanceResponseModel>> getAttendanceApiCall(
      {Map<String, dynamic>? dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(ApiEnd.tmsUsersEnd, data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      if (response is List) {
        return response.map((item) =>
            TechnicianAttendanceResponseModel.fromJson(item)).toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic>data = response['data'];
        return data.map((item) =>
            TechnicianAttendanceResponseModel.fromJson(item)).toList();
      }
      return [];
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }*/
  @override
Future<TechnicianAttendanceResponseModel>getAttendanceApiCall({Map<String, dynamic>? dataBody , dynamic parameters})async{
  try{
    final response = await dioClient!.get(ApiEnd.tmsUsersEnd, data: dataBody, skipAuth: false, queryParameters: parameters );
    return TechnicianAttendanceResponseModel.fromJson(response);
  }catch(error){
    return Future.error(NetworkExceptions.getDioException(error));
  }
}
// ============================================================================Get Expenses Api Call=================================================
  @override
Future<List<ExpensesResponseModel>> getExpensesApiCall(
      {Map<String, dynamic>?dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(ApiEnd.expensesEnd, data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      if (response is List) {
        return response.map((item) => ExpensesResponseModel.fromJson(item))
            .toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic>data = response['data'];
        return data.map((item) => ExpensesResponseModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }
  //=========================================================================== Service Requests Response Api Call ==================================================

  @override
  Future<List<ServiceRequestsResponseModel>> getServiceRequestsApiCall({Map<String, dynamic>?dataBody, parameters}) async {
    try {
      final response = await dioClient!.get(ApiEnd.serviceRequestsEnd, data: dataBody,
          skipAuth: false,
          queryParameters: parameters);
      if (response is List) {
        return response.map((item) => ServiceRequestsResponseModel.fromJson(item))
            .toList();
      } else
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic>data = response['data'];
        return data.map((item) => ServiceRequestsResponseModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (error) {
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }

  Future<ExportServiceResponse>getDownLoadExportServiceResponse()async{
    try{
      final response = await dioClient!.get(ApiEnd.exportServiceRequestEnd, skipAuth: false);
      return ExportServiceResponse.fromJson(jsonDecode(response.body));
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
  }
//==================================================================================== technician api call ==============================================================================

  // @override
  // Future<List<TechnicianResponseModel>> getTechnicianApiCall(
  //     {Map<String, dynamic>? dataBody, parameters}) async {
  //   try {
  //     final response = await dioClient!.get(ApiEnd.tmsUsersEnd, data: dataBody,
  //         skipAuth: false,
  //         queryParameters: parameters);
  //     if (response is List) {
  //       return response.map((item) =>
  //           TechnicianResponseModel.fromJson(item)).toList();
  //     } else
  //     if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic>data = response['data'];
  //       return data.map((item) =>
  //           TechnicianResponseModel.fromJson(item)).toList();
  //     }
  //     return [];
  //   } catch (error) {
  //     return Future.error(NetworkExceptions.getDioException(error));
  //   }
  // }
 @override
  Future<TechnicianResponseModel>getTechnicianApiCall({Map<String, dynamic>? dataBody, parameters})async{
    try{
      final response = await dioClient!.get(ApiEnd.tmsUsersEnd, data: dataBody,
              skipAuth: false,
              queryParameters: parameters);
      return TechnicianResponseModel.fromJson(response);
    }catch(error){
      return Future.error(NetworkExceptions.getDioException(error));
    }
 }
//   =============================
}


