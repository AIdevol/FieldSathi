class ServicesResponseModel {
  ServicesResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  final int? count;
  final int? totalPages;
  final int? currentPage;
  final List<Service> results;

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json){
    return ServicesResponseModel(
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      results: json["results"] == null ? [] : List<Service>.from(json["results"]!.map((x) => Service.fromJson(x))),
    );
  }

}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    required this.serviceImage1,
    required this.serviceImage2,
    required this.serviceImage3,
    required this.serviceSubCategory,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceName;
  final String? servicePrice;
  final String? serviceContactNumber;
  final String? serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final String? serviceImage3;
  final ServiceSubCategory? serviceSubCategory;
  final int? createdBy;
  final int? admin;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      id: json["id"],
      serviceName: json["service_name"],
      servicePrice: json["service_price"],
      serviceContactNumber: json["service_contact_number"],
      serviceDescription: json["service_description"],
      serviceImage1: json["service_image1"],
      serviceImage2: json["service_image2"],
      serviceImage3: json["service_image3"],
      serviceSubCategory: json["service_sub_category"] == null ? null : ServiceSubCategory.fromJson(json["service_sub_category"]),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class ServiceSubCategory {
  ServiceSubCategory({
    required this.id,
    required this.serviceSubCategoryName,
    required this.serviceSubCatDescription,
    required this.serviceSubImage,
    required this.serviceCategory,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceSubCategoryName;
  final String? serviceSubCatDescription;
  final String? serviceSubImage;
  final ServiceCategory? serviceCategory;
  final int? createdBy;
  final int? admin;

  factory ServiceSubCategory.fromJson(Map<String, dynamic> json){
    return ServiceSubCategory(
      id: json["id"],
      serviceSubCategoryName: json["service_sub_category_name"],
      serviceSubCatDescription: json["service_sub_cat_description"],
      serviceSubImage: json["service_sub_image"],
      serviceCategory: json["service_category"] == null ? null : ServiceCategory.fromJson(json["service_category"]),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class ServiceCategory {
  ServiceCategory({
    required this.id,
    required this.serviceCategoryName,
    required this.serviceCatDescriptions,
    required this.serviceCatImage,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceCategoryName;
  final String? serviceCatDescriptions;
  final String? serviceCatImage;
  final int? createdBy;
  final int? admin;

  factory ServiceCategory.fromJson(Map<String, dynamic> json){
    return ServiceCategory(
      id: json["id"],
      serviceCategoryName: json["service_category_name"],
      serviceCatDescriptions: json["service_cat_descriptions"],
      serviceCatImage: json["service_cat_image"],
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}