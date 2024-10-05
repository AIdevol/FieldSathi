class FsrResponseModel {
  final int id;
  final List<Category> categories;
  final String fsrName;
  final int createdBy;
  final int admin;

  FsrResponseModel({
    required this.id,
    required this.categories,
    required this.fsrName,
    required this.createdBy,
    required this.admin,
  });

  factory FsrResponseModel.fromJson(Map<String, dynamic> json) {
    return FsrResponseModel(
      id: json['id'],
      categories: List<Category>.from(
        json['categories'].map((category) => Category.fromJson(category)),
      ),
      fsrName: json['fsrName'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categories': List<dynamic>.from(categories.map((category) => category.toJson())),
      'fsrName': fsrName,
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class Category {
  final int id;
  final String name;
  final List<dynamic> checkpoints;

  Category({
    required this.id,
    required this.name,
    required this.checkpoints,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      checkpoints: List<dynamic>.from(json['checkpoints']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'checkpoints': List<dynamic>.from(checkpoints),
    };
  }
}
