import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/response_models/add_technician_response_model.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/response_models/login_response_model.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';
import 'package:tms_sathi/response_models/ticket_response_model.dart';
import 'package:tms_sathi/response_models/user_response_model.dart';
import 'package:tms_sathi/services/APIs/dio_client.dart';

import '../../../response_models/check_points_response_model.dart';
import '../../../response_models/holidays_calender_response_model.dart';
import '../../../response_models/leave_allocation_response_model.dart';
import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';
import '../../../response_models/super_user_response_model.dart';
import '../api_end.dart';
import '../network_except.dart';
import 'auth_abstract_api_services_impl.dart';

class AuthenticationApiService extends GetxService
implements AuthenticationApi{
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
      final response = await dioClient!.post(ApiEnd.verifyotpEnd, data: dataBody);
      return OtpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<ResendOtpApiCall> resendOtpApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(ApiEnd.resendOtpEnd, data: dataBody);
      return ResendOtpApiCall.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel>userDetailsApiCall({Map<String, dynamic>? dataBody, String? id})async{
    try{
      final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}/$id/", data: dataBody);
      return UserResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel>updateUserDetailsApiCall({Map<String, dynamic>? dataBody, String? id})async{
    try{
      final response = await dioClient!.put("${ApiEnd.tmsUsersEnd}/$id/", data: dataBody, skipAuth: false);
      return UserResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<UserResponseModel>ticketDetailsApiCall({Map<String, dynamic>? dataBody, String? id})async{
    try{
      final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}/$id/", data: dataBody);
      return UserResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


// =====================================================Page ApI's=======================================================================
  @override
  Future<HolidaysCalenderResponseModel>holidaysCalenderApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.holidaysApiEnd}", data: dataBody);
      return HolidaysCalenderResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<List<TicketResponseModel>>getticketDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.get_ticketEnd}", data: dataBody);
      print("inside api calling method: ${response}");
      if (response is List) {
        return response.map((item) => TicketResponseModel.fromJson(item)).toList();
      } else if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> data = response['data'];
        return data.map((item) => TicketResponseModel.fromJson(item)).toList();
      }
      throw Exception('Unexpected response format');
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<TicketResponseModel>postTicketDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.post("${ApiEnd.get_ticketEnd}", data: dataBody,skipAuth: false);
      return TicketResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<LeaveResponseModel>getLeavesApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.leavesReportEnd}", data: dataBody,skipAuth: false);
      return LeaveResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<LeaveResponseModel>putLeavesApiCall({Map<String, dynamic>? dataBody,id})async{
    try{
      final response = await dioClient!.put("${ApiEnd.leavesReportEnd}$id/", data: dataBody,skipAuth: false);
      return LeaveResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<SuperUsersResponseModel>getSuperUserApiCall({Map<String, dynamic>? dataBody, parameters})async{
    try{
      final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}", data: dataBody,skipAuth: false,queryParameters: parameters );
      return SuperUsersResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<AddTechnicianResponseModel>addTechnicialPostApiCall({Map<String, dynamic>? dataBody, parameters})async{
    try{
      final response = await dioClient!.post("${ApiEnd.tmsUsersEnd}", data: dataBody,skipAuth: false,queryParameters: parameters );
      return AddTechnicianResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<List<FsrResponseModel>>getfsrDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.fsrApiEnd}", data: dataBody,skipAuth: false,);
      if(response is List){
        return response.map((item) => FsrResponseModel.fromJson(item)).toList();
      }else if(response is Map<String, dynamic> && response.containsKey('data')){
        final List<dynamic> data = response['data'];
        return data.map((item) => FsrResponseModel.fromJson(item)).toList();
      }
      return [];
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<FsrResponseModel>postfsrDetailsApiCall({Map<String, dynamic>? dataBody, parameters})async{
    try{
      final response = await dioClient!.post("${ApiEnd.fsrApiEnd}", data: dataBody,skipAuth: false,queryParameters: parameters );
      return FsrResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<CheckPointsResponseModel>postcheckPointStatusDetailsApiCall({Map<String, dynamic>? dataBody,})async{
    try{
      final response = await dioClient!.post("${ApiEnd.checkingPointStatusApiEnd}", data: dataBody,skipAuth: false);
      return CheckPointsResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
// ===========================================================Leaves Api Call=============================================================
  @override
  Future<List<LeaveAllocationResponseModel>> getLeavesALLocationApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.leaveEditPeriodEnd}", data: dataBody);
      if(response is List){
        return response.map((item) => LeaveAllocationResponseModel.fromJson(item)).toList();
      }else if(response is Map<String, dynamic> && response.containsKey('data')){
        final List<dynamic> data = response['data'];
        return data.map((item)=>LeaveAllocationResponseModel.fromJson(item)).toList();
      }
      return [];
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<LeaveAllocationResponseModel>putLeavesAllocationApiCall({Map<String, dynamic>? dataBody,id})async{
    try{
      final response = await dioClient!.put("${ApiEnd.leaveEditPeriodEnd}$id/", data: dataBody,);
      return LeaveAllocationResponseModel.fromJson(response);
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<List<AmcResponseModel>>getAmcDetailsApiCall({Map<String, dynamic>? dataBody})async{
    try{
      final response = await dioClient!.get("${ApiEnd.amcEnd}", data: dataBody,skipAuth: false);
      if(response is List){
        return response.map((item)=> AmcResponseModel.fromJson(item)).toList();
      }else if (response is Map<String, dynamic>&& response.containsKey('data')){
        final List<dynamic>data = response['data'];
        return data.map((item)=> AmcResponseModel.fromJson(item)).toList();
      }
      return [];
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
  // ==============================================================Agents details=============================================================================
  @override
  Future<SuperUsersResponseModel>getAgentDetailsApiCall({Map<String, dynamic>? dataBody,parameters} )async{
    try{
      final response = await dioClient!.get("${ApiEnd.tmsUsersEnd}", data: dataBody,skipAuth: false, queryParameters: parameters);
      return SuperUsersResponseModel.fromJson(response);
      // if(response is List){
      //   return response.map((item)=> SuperUsersResponseModel.fromJson(item)).toList();
      // }else if (response is Map<String, dynamic>&& response.containsKey('data')){
      //   final List<dynamic>data = response['data'];
      //   return data.map((item)=> SuperUsersResponseModel.fromJson(item)).toList();
      // }
      // return [];
    }catch(e){
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
}