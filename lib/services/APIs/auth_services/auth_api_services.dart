import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/response_models/login_response_model.dart';
import 'package:tms_sathi/response_models/otp_response_model.dart';
import 'package:tms_sathi/services/APIs/dio_client.dart';

import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';
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
}