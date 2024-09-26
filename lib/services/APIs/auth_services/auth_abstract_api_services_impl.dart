import '../../../response_models/holidays_calender_response_model.dart';
import '../../../response_models/login_response_model.dart';
import '../../../response_models/otp_response_model.dart';
import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';
import '../../../response_models/user_response_model.dart';

abstract class AuthenticationApi {
  Future<LoginResponseModel> loginApiCall({Map<String, dynamic>? dataBody});

  Future<RegisterResponseModel> registerApiCall(
      {Map<String, dynamic>? dataBody});

  Future<ResendOtpApiCall> resendOtpApiCall({Map<String, dynamic>? dataBody});

  Future<OtpResponseModel> verifyOtpApiCall({Map<String, dynamic>? dataBody});
  Future<UserResponseModel>userDetailsApiCall({Map<String, dynamic>? dataBody, String? id});
  Future<UserResponseModel>updateUserDetailsApiCall({Map<String, dynamic>? dataBody, String? id});
  Future<HolidaysCalenderResponseModel>holidaysCalenderApiCall({Map<String, dynamic>? dataBody});
}