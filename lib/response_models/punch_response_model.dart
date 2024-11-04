class PunchInResponseModel {
  final String message;
  final PunchInData data;

  PunchInResponseModel({
    required this.message,
    required this.data,
  });

  factory PunchInResponseModel.fromJson(Map<String, dynamic> json) {
    return PunchInResponseModel(
      message: json['message'],
      data: PunchInData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class PunchInData {
  final int id;
  final int user;
  final String punchIn;
  final String? punchOut;
  final String status;
  final String date;

  PunchInData({
    required this.id,
    required this.user,
    required this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory PunchInData.fromJson(Map<String, dynamic> json) {
    return PunchInData(
      id: json['id'],
      user: json['user'],
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'punch_in': punchIn,
      'punch_out': punchOut,
      'status': status,
      'date': date,
    };
  }
}
