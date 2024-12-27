class FsrResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<Result>? results;

  FsrResponseModel({
    this.count,
    this.totalPages,
    this.currentPage,
    this.results,
  });

  factory FsrResponseModel.fromJson(Map<String, dynamic> json) => FsrResponseModel(
    count: json["count"],
    totalPages: json["total_pages"],
    currentPage: json["current_page"],
    results: json["results"] != null
        ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "total_pages": totalPages,
    "current_page": currentPage,
    "results": results != null ? List<dynamic>.from(results!.map((x) => x.toJson())) : null,
  };
}

class Result {
  int? id;
  String? fsrName;
  List<Category>? categories;
  int? createdBy;
  int? admin;

  Result({
    this.id,
    this.fsrName,
    this.categories,
    this.createdBy,
    this.admin,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fsrName: json["fsrName"],
    categories: json["categories"] != null
        ? List<Category>.from(json["categories"].map((x) => Category.fromJson(x)))
        : null,
    createdBy: json["created_by"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fsrName": fsrName,
    "categories": categories != null ? List<dynamic>.from(categories!.map((x) => x.toJson())) : null,
    "created_by": createdBy,
    "admin": admin,
  };
}

class Category {
  int? id;
  String? name;
  List<Checkpoint>? checkpoints;
  int? createdBy;
  int? admin;

  Category({
    this.id,
    this.name,
    this.checkpoints,
    this.createdBy,
    this.admin,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    checkpoints: json["checkpoints"] != null
        ? List<Checkpoint>.from(json["checkpoints"].map((x) => Checkpoint.fromJson(x)))
        : null,
    createdBy: json["created_by"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "checkpoints": checkpoints != null ? List<dynamic>.from(checkpoints!.map((x) => x.toJson())) : null,
    "created_by": createdBy,
    "admin": admin,
  };
}

class Checkpoint {
  int? id;
  String? checkpointName;
  int? createdBy;
  int? admin;

  Checkpoint({
    this.id,
    this.checkpointName,
    this.createdBy,
    this.admin,
  });

  factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
    id: json["id"],
    checkpointName: json["checkpoint_name"],
    createdBy: json["created_by"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "checkpoint_name": checkpointName,
    "created_by": createdBy,
    "admin": admin,
  };
}

//================================================================== FSR Checking response Model =========================================
class CheckAndUpdateCheckingPointForFsrResponseModel {
  CheckAndUpdateCheckingPointForFsrResponseModel({
    required this.id,
    required this.checkpointName,
    required this.checkpointStatuses,
    required this.displayType,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? checkpointName;
  final List<String> checkpointStatuses;
  final String? displayType;
  final int? createdBy;
  final int? admin;

  factory CheckAndUpdateCheckingPointForFsrResponseModel.fromJson(Map<String, dynamic> json){
    return CheckAndUpdateCheckingPointForFsrResponseModel(
      id: json["id"],
      checkpointName: json["checkpoint_name"],
      checkpointStatuses: json["checkpointStatuses"] == null ? [] : List<String>.from(json["checkpointStatuses"]!.map((x) => x)),
      displayType: json["displayType"],
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}
