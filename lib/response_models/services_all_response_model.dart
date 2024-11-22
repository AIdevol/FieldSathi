class ServicesResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<Service> results;

  ServicesResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) {
    return ServicesResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<Service>.from(
        json['results'].map((x) => Service.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}

class Service {
  final int id;
  final String serviceName;
  final String servicePrice;
  final String serviceContactNumber;
  final String serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final String? serviceImage3;
  final ServiceSubCategory serviceSubCategory;
  final int createdBy;
  final int admin;

  Service({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    required this.serviceSubCategory,
    required this.createdBy,
    required this.admin,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
      servicePrice: json['service_price'],
      serviceContactNumber: json['service_contact_number'],
      serviceDescription: json['service_description'],
      serviceImage1: json['service_image1'],
      serviceImage2: json['service_image2'],
      serviceImage3: json['service_image3'],
      serviceSubCategory: ServiceSubCategory.fromJson(json['service_sub_category']),
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
      'service_price': servicePrice,
      'service_contact_number': serviceContactNumber,
      'service_description': serviceDescription,
      'service_image1': serviceImage1,
      'service_image2': serviceImage2,
      'service_image3': serviceImage3,
      'service_sub_category': serviceSubCategory.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceSubCategory {
  final int id;
  final String serviceSubCategoryName;
  final String serviceSubCatDescription;
  final String? serviceSubImage;
  final ServiceCategory serviceCategory;
  final int createdBy;
  final int admin;

  ServiceSubCategory({
    required this.id,
    required this.serviceSubCategoryName,
    required this.serviceSubCatDescription,
    this.serviceSubImage,
    required this.serviceCategory,
    required this.createdBy,
    required this.admin,
  });

  factory ServiceSubCategory.fromJson(Map<String, dynamic> json) {
    return ServiceSubCategory(
      id: json['id'],
      serviceSubCategoryName: json['service_sub_category_name'],
      serviceSubCatDescription: json['service_sub_cat_description'],
      serviceSubImage: json['service_sub_image'],
      serviceCategory: ServiceCategory.fromJson(json['service_category']),
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
      'service_category': serviceCategory.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceCategory {
  final int id;
  final String serviceCategoryName;
  final String serviceCatDescriptions;
  final String serviceCatImage;
  final int createdBy;
  final int admin;

  ServiceCategory({
    required this.id,
    required this.serviceCategoryName,
    required this.serviceCatDescriptions,
    required this.serviceCatImage,
    required this.createdBy,
    required this.admin,
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
