// class ServicesResponseModel {
//   int? id;
//   String? serviceName;
//   String? servicePrice;
//   String? serviceContactNumber;
//   String? serviceDescription;
//   String? serviceImage1;
//   String? serviceImage2;
//   String? serviceImage3;
//   ServiceSubCategory? serviceSubCategory;
//   int? createdBy;
//   int? admin;
//
//   ServicesResponseModel({
//     this.id,
//     this.serviceName,
//     this.servicePrice,
//     this.serviceContactNumber,
//     this.serviceDescription,
//     this.serviceImage1,
//     this.serviceImage2,
//     this.serviceImage3,
//     this.serviceSubCategory,
//     this.createdBy,
//     this.admin,
//   });
//
//   factory ServicesResponseModel.fromJson(Map<String, dynamic> json) {
//     return ServicesResponseModel(
//       id: json['id'],
//       serviceName: json['service_name'],
//       servicePrice: json['service_price'],
//       serviceContactNumber: json['service_contact_number'],
//       serviceDescription: json['service_description'],
//       serviceImage1: json['service_image1'],
//       serviceImage2: json['service_image2'],
//       serviceImage3: json['service_image3'],
//       serviceSubCategory: json['service_sub_category'] != null
//           ? ServiceSubCategory.fromJson(json['service_sub_category'])
//           : null,
//       createdBy: json['created_by'],
//       admin: json['admin'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'service_name': serviceName,
//       'service_price': servicePrice,
//       'service_contact_number': serviceContactNumber,
//       'service_description': serviceDescription,
//       'service_image1': serviceImage1,
//       'service_image2': serviceImage2,
//       'service_image3': serviceImage3,
//       'service_sub_category': serviceSubCategory?.toJson(),
//       'created_by': createdBy,
//       'admin': admin,
//     };
//   }
// }
//
// class ServiceSubCategory {
//   int? id;
//   String? serviceSubCategoryName;
//   String? serviceSubCatDescription;
//   String? serviceSubImage;
//   ServiceCategory? serviceCategory;
//   int? createdBy;
//   int? admin;
//
//   ServiceSubCategory({
//     this.id,
//     this.serviceSubCategoryName,
//     this.serviceSubCatDescription,
//     this.serviceSubImage,
//     this.serviceCategory,
//     this.createdBy,
//     this.admin,
//   });
//
//   factory ServiceSubCategory.fromJson(Map<String, dynamic> json) {
//     return ServiceSubCategory(
//       id: json['id'],
//       serviceSubCategoryName: json['service_sub_category_name'],
//       serviceSubCatDescription: json['service_sub_cat_description'],
//       serviceSubImage: json['service_sub_image'],
//       serviceCategory: json['service_category'] != null
//           ? ServiceCategory.fromJson(json['service_category'])
//           : null,
//       createdBy: json['created_by'],
//       admin: json['admin'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'service_sub_category_name': serviceSubCategoryName,
//       'service_sub_cat_description': serviceSubCatDescription,
//       'service_sub_image': serviceSubImage,
//       'service_category': serviceCategory?.toJson(),
//       'created_by': createdBy,
//       'admin': admin,
//     };
//   }
// }
//
// class ServiceCategory {
//   int? id;
//   String? serviceCategoryName;
//   String? serviceCatDescriptions;
//   String? serviceCatImage;
//   int? createdBy;
//   int? admin;
//
//   ServiceCategory({
//     this.id,
//     this.serviceCategoryName,
//     this.serviceCatDescriptions,
//     this.serviceCatImage,
//     this.createdBy,
//     this.admin,
//   });
//
//   factory ServiceCategory.fromJson(Map<String, dynamic> json) {
//     return ServiceCategory(
//       id: json['id'],
//       serviceCategoryName: json['service_category_name'],
//       serviceCatDescriptions: json['service_cat_descriptions'],
//       serviceCatImage: json['service_cat_image'],
//       createdBy: json['created_by'],
//       admin: json['admin'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'service_category_name': serviceCategoryName,
//       'service_cat_descriptions': serviceCatDescriptions,
//       'service_cat_image': serviceCatImage,
//       'created_by': createdBy,
//       'admin': admin,
//     };
//   }
// }
// //=================================================service category=================================================
// class ServiceCategoriesResponseModel {
//   int id;
//   String serviceCategoryName;
//   String serviceCatDescriptions;
//   String? serviceCatImage;
//   int createdBy;
//   int admin;
//
//   ServiceCategoriesResponseModel({
//     required this.id,
//     required this.serviceCategoryName,
//     required this.serviceCatDescriptions,
//     this.serviceCatImage,
//     required this.createdBy,
//     required this.admin,
//   });
//
//   factory ServiceCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
//     return ServiceCategoriesResponseModel(
//       id: json['id'],
//       serviceCategoryName: json['service_category_name'],
//       serviceCatDescriptions: json['service_cat_descriptions'],
//       serviceCatImage: json['service_cat_image'],
//       createdBy: json['created_by'],
//       admin: json['admin'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'service_category_name': serviceCategoryName,
//       'service_cat_descriptions': serviceCatDescriptions,
//       'service_cat_image': serviceCatImage,
//       'created_by': createdBy,
//       'admin': admin,
//     };
//   }
// }
// //===============================================================Post Modals===============================
// class ServicePostResponseModel {
//   int? id;
//   String? serviceCategoryName;
//   String? serviceCatDescriptions;
//   String? serviceCatImage;
//   int? createdBy;
//   int? admin;
//
//   ServicePostResponseModel(
//       {this.id,
//         this.serviceCategoryName,
//         this.serviceCatDescriptions,
//         this.serviceCatImage,
//         this.createdBy,
//         this.admin});
//
//   ServicePostResponseModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceCategoryName = json['service_category_name'];
//     serviceCatDescriptions = json['service_cat_descriptions'];
//     serviceCatImage = json['service_cat_image'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['service_category_name'] = this.serviceCategoryName;
//     data['service_cat_descriptions'] = this.serviceCatDescriptions;
//     data['service_cat_image'] = this.serviceCatImage;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     return data;
//   }
// }
class ServiceCategoryResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<ServiceCategory> results;

  ServiceCategoryResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory ServiceCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<ServiceCategory>.from(
        json['results'].map((item) => ServiceCategory.fromJson(item)),
      ),
    );
  }
}

class ServiceCategory {
  final int id;
  final String serviceCategoryName;
  final String serviceCatDescriptions;
  final String? serviceCatImage;
  final int createdBy;
  final int admin;

  ServiceCategory({
    required this.id,
    required this.serviceCategoryName,
    required this.serviceCatDescriptions,
    this.serviceCatImage,
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
}
//====================================================================post Api Call ====================================
class PostServiceCategoryResponseModel {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  PostServiceCategoryResponseModel(
      {this.id,
        this.serviceCategoryName,
        this.serviceCatDescriptions,
        this.serviceCatImage,
        this.createdBy,
        this.admin});

  PostServiceCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCategoryName = json['service_category_name'];
    serviceCatDescriptions = json['service_cat_descriptions'];
    serviceCatImage = json['service_cat_image'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_category_name'] = this.serviceCategoryName;
    data['service_cat_descriptions'] = this.serviceCatDescriptions;
    data['service_cat_image'] = this.serviceCatImage;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}
