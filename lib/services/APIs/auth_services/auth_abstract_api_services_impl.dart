import '../../../response_models/login_response_model.dart';
import '../../../response_models/otp_response_model.dart';
import '../../../response_models/register_response_model.dart';
import '../../../response_models/resend_otp_api_call.dart';

abstract class AuthenticationApi{
  Future<LoginResponseModel> loginApiCall({Map<String, dynamic>? dataBody});
  Future<RegisterResponseModel> registerApiCall({Map<String, dynamic>? dataBody});
  Future<ResendOtpApiCall> resendOtpApiCall({Map<String, dynamic>? dataBody});
  Future<OtpResponseModel> verifyOtpApiCall({Map<String, dynamic>? dataBody});

}