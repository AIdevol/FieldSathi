class ResendOtpResponseModel {
  String? message;
  String? otp;

  ResendOtpResponseModel({this.message, this.otp});

  ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}
