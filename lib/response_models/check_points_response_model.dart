class CheckPointsResponseModel {
  int? id;
  String? statusName;
  String? checkpoint;
  int? createdBy;
  int? admin;

  CheckPointsResponseModel(
      {this.id, this.statusName, this.checkpoint, this.createdBy, this.admin});

  CheckPointsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusName = json['status_name'];
    checkpoint = json['checkpoint'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_name'] = this.statusName;
    data['checkpoint'] = this.checkpoint;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

//=========================================================================update status==========================================
class UpdateCheckPointStatusApiCall {
  UpdateCheckPointStatusApiCall({
    required this.message,
  });

  final String? message;

  factory UpdateCheckPointStatusApiCall.fromJson(Map<String, dynamic> json){
    return UpdateCheckPointStatusApiCall(
      message: json["message"],
    );
  }

}
