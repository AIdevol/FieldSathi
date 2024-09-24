class ErrorResModel {
  List<String>? email;
  List<String>? phoneNumber;

  ErrorResModel({this.email, this.phoneNumber});

  ErrorResModel.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    phoneNumber = json['phone_number'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    return data;
  }
}

class ErrorMessageResponseModel {
  bool? success;
  String? message;
  String? copyrighths;

  ErrorMessageResponseModel({this.success, this.message, this.copyrighths});

  ErrorMessageResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map toJson() {
    final Map data = {};
    data['success'] = success;
    data['message'] = message;
    data['copyrighths'] = copyrighths;
    return data;
  }
}
