class SubServiceResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<SubService>? results;

  SubServiceResponseModel(
      {this.count, this.totalPages, this.currentPage, this.results});

  SubServiceResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    if (json['results'] != null) {
      results = <SubService>[];
      json['results'].forEach((v) {
        results!.add(new SubService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubService {
  int? id;
  String? serviceSubCategoryName;
  String? serviceSubCatDescription;
  String? serviceSubImage;
  ServiceCategories? serviceCategory;
  int? createdBy;
  int? admin;

  SubService(
      {this.id,
        this.serviceSubCategoryName,
        this.serviceSubCatDescription,
        this.serviceSubImage,
        this.serviceCategory,
        this.createdBy,
        this.admin});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceSubCategoryName = json['service_sub_category_name'];
    serviceSubCatDescription = json['service_sub_cat_description'];
    serviceSubImage = json['service_sub_image'];
    serviceCategory = json['service_category'] != null
        ? new ServiceCategories.fromJson(json['service_category'])
        : null;
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_sub_category_name'] = this.serviceSubCategoryName;
    data['service_sub_cat_description'] = this.serviceSubCatDescription;
    data['service_sub_image'] = this.serviceSubImage;
    if (this.serviceCategory != null) {
      data['service_category'] = this.serviceCategory!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class ServiceCategories {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  ServiceCategories(
      {this.id,
        this.serviceCategoryName,
        this.serviceCatDescriptions,
        this.serviceCatImage,
        this.createdBy,
        this.admin});

  ServiceCategories.fromJson(Map<String, dynamic> json) {
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

// ==============================================================post service==========================================
class PostSubServiceResponseModel {
  int? id;
  String? serviceSubCategoryName;
  String? serviceSubCatDescription;
  String? serviceSubImage;
  ServiceCategoryDetails? serviceCategory;
  int? createdBy;
  int? admin;

  PostSubServiceResponseModel(
      {this.id,
        this.serviceSubCategoryName,
        this.serviceSubCatDescription,
        this.serviceSubImage,
        this.serviceCategory,
        this.createdBy,
        this.admin});

  PostSubServiceResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceSubCategoryName = json['service_sub_category_name'];
    serviceSubCatDescription = json['service_sub_cat_description'];
    serviceSubImage = json['service_sub_image'];
    serviceCategory = json['service_category'] != null
        ? new ServiceCategoryDetails.fromJson(json['service_category'])
        : null;
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_sub_category_name'] = this.serviceSubCategoryName;
    data['service_sub_cat_description'] = this.serviceSubCatDescription;
    data['service_sub_image'] = this.serviceSubImage;
    if (this.serviceCategory != null) {
      data['service_category'] = this.serviceCategory!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class ServiceCategoryDetails {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  ServiceCategoryDetails(
      {this.id,
        this.serviceCategoryName,
        this.serviceCatDescriptions,
        this.serviceCatImage,
        this.createdBy,
        this.admin});

  ServiceCategoryDetails.fromJson(Map<String, dynamic> json) {
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
