class SubServicesResponseModel {
  int? id;
  String? serviceSubCategoryName;
  String? serviceSubCatDescription;
  String? serviceSubImage;
  ServiceCategory? serviceCategory;
  int? createdBy;
  int? admin;

  SubServicesResponseModel({
    this.id,
    this.serviceSubCategoryName,
    this.serviceSubCatDescription,
    this.serviceSubImage,
    this.serviceCategory,
    this.createdBy,
    this.admin,
  });

  factory SubServicesResponseModel.fromJson(Map<String, dynamic> json) {
    return SubServicesResponseModel(
      id: json['id'],
      serviceSubCategoryName: json['service_sub_category_name'],
      serviceSubCatDescription: json['service_sub_cat_description'],
      serviceSubImage: json['service_sub_image'],
      serviceCategory: json['service_category'] != null
          ? ServiceCategory.fromJson(json['service_category'])
          : null,
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_sub_category_name': serviceSubCategoryName,
      'service_sub_cat_description': serviceSubCatDescription,
      'service_sub_image': serviceSubImage,
      'service_category': serviceCategory?.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceCategory {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  ServiceCategory({
    this.id,
    this.serviceCategoryName,
    this.serviceCatDescriptions,
    this.serviceCatImage,
    this.createdBy,
    this.admin,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      serviceCategoryName: json['service_category_name'],
      serviceCatDescriptions: json['service_cat_descriptions'],
      serviceCatImage: json['service_cat_image'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_category_name': serviceCategoryName,
      'service_cat_descriptions': serviceCatDescriptions,
      'service_cat_image': serviceCatImage,
      'created_by': createdBy,
      'admin': admin,
    };
  }
}
//=========================================================================Get ResponseModel==================================================
class SubServicesGetResponseModel {
  List<SubService>? subServices;

  SubServicesGetResponseModel({this.subServices});

  factory SubServicesGetResponseModel.fromJson(List<dynamic> json) {
    return SubServicesGetResponseModel(
      subServices: json.map((item) => SubService.fromJson(item)).toList(),
    );
  }

  List<dynamic> toJson() {
    return subServices?.map((item) => item.toJson()).toList() ?? [];
  }
}

class SubService {
  int? id;
  String? serviceSubCategoryName;
  String? serviceSubCatDescription;
  String? serviceSubImage;
  ServiceCategory? serviceCategory;
  int? createdBy;
  int? admin;

  SubService({
    this.id,
    this.serviceSubCategoryName,
    this.serviceSubCatDescription,
    this.serviceSubImage,
    this.serviceCategory,
    this.createdBy,
    this.admin,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      serviceSubCategoryName: json['service_sub_category_name'],
      serviceSubCatDescription: json['service_sub_cat_description'],
      serviceSubImage: json['service_sub_image'],
      serviceCategory: json['service_category'] != null
          ? ServiceCategory.fromJson(json['service_category'])
          : null,
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_sub_category_name': serviceSubCategoryName,
      'service_sub_cat_description': serviceSubCatDescription,
      'service_sub_image': serviceSubImage,
      'service_category': serviceCategory?.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class SubServiceCategory {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  SubServiceCategory({
    this.id,
    this.serviceCategoryName,
    this.serviceCatDescriptions,
    this.serviceCatImage,
    this.createdBy,
    this.admin,
  });

  factory SubServiceCategory.fromJson(Map<String, dynamic> json) {
    return SubServiceCategory(
      id: json['id'],
      serviceCategoryName: json['service_category_name'],
      serviceCatDescriptions: json['service_cat_descriptions'],
      serviceCatImage: json['service_cat_image'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_category_name': serviceCategoryName,
      'service_cat_descriptions': serviceCatDescriptions,
      'service_cat_image': serviceCatImage,
      'created_by': createdBy,
      'admin': admin,
    };
  }
}
