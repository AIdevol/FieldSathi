class LeadSourceTypeResponseModel {
  LeadSourceTypeResponseModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? name;
  final int? createdBy;
  final int? admin;

  factory LeadSourceTypeResponseModel.fromJson(Map<String, dynamic> json){
    return LeadSourceTypeResponseModel(
      id: json["id"],
      name: json["name"],
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}
//========================================================================
class PostLeadSourceTypeResponseModel {
  PostLeadSourceTypeResponseModel({
    required this.message,
  });

  final String? message;

  factory PostLeadSourceTypeResponseModel.fromJson(Map<String, dynamic> json){
    return PostLeadSourceTypeResponseModel(
      message: json["message"],
    );
  }

}
