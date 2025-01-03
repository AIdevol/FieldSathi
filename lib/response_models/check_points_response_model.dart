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
//====================================================Fsr CheckPoints status =======================================================
class FSRCheckpointsStatusResponseModel {
  int? id;
  String? checkpointName;
  List<String>? checkpointStatuses;
  String? displayType;
  int? createdBy;
  int? admin;

  FSRCheckpointsStatusResponseModel(
      {this.id,
        this.checkpointName,
        this.checkpointStatuses,
        this.displayType,
        this.createdBy,
        this.admin});

  FSRCheckpointsStatusResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkpointName = json['checkpoint_name'];
    checkpointStatuses = json['checkpointStatuses'].cast<String>();
    displayType = json['displayType'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkpoint_name'] = this.checkpointName;
    data['checkpointStatuses'] = this.checkpointStatuses;
    data['displayType'] = this.displayType;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}
//==============================================================================Delete Response Model=======================================
class FSRDeleteRespnseModel {
  String? message;

  FSRDeleteRespnseModel({this.message});

  FSRDeleteRespnseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}