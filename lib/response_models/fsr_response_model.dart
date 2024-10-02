class FsrResponseModel {
  int? id;
  List<Categories>? categories;
  String? fsrName;
  int? createdBy;
  int? admin;

  FsrResponseModel(
      {this.id, this.categories, this.fsrName, this.createdBy, this.admin});

  FsrResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    fsrName = json['fsrName'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['fsrName'] = this.fsrName;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  List<Checkpoints>? checkpoints;

  Categories({this.id, this.name, this.checkpoints});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['checkpoints'] != null) {
      checkpoints = <Checkpoints>[];
      json['checkpoints'].forEach((v) {
        checkpoints!.add(new Checkpoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.checkpoints != null) {
      data['checkpoints'] = this.checkpoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Checkpoints {
  int? id;
  String? checkpointName;

  Checkpoints({this.id, this.checkpointName});

  Checkpoints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkpointName = json['checkpoint_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkpoint_name'] = this.checkpointName;
    return data;
  }
}