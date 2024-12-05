class SubServiceBySubServiceIdResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<Results>? results;

  SubServiceBySubServiceIdResponseModel(
      {this.count, this.totalPages, this.currentPage, this.results});

  SubServiceBySubServiceIdResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
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

class Results {
  int? id;
  String? serviceName;
  String? servicePrice;
  String? serviceContactNumber;
  String? serviceDescription;
  String? serviceImage1;
  String? serviceImage2;
  String? serviceImage3;
  ServiceSubCategory? serviceSubCategory;
  int? createdBy;
  int? admin;

  Results(
      {this.id,
        this.serviceName,
        this.servicePrice,
        this.serviceContactNumber,
        this.serviceDescription,
        this.serviceImage1,
        this.serviceImage2,
        this.serviceImage3,
        this.serviceSubCategory,
        this.createdBy,
        this.admin});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceContactNumber = json['service_contact_number'];
    serviceDescription = json['service_description'];
    serviceImage1 = json['service_image1'];
    serviceImage2 = json['service_image2'];
    serviceImage3 = json['service_image3'];
    serviceSubCategory = json['service_sub_category'] != null
        ? new ServiceSubCategory.fromJson(json['service_sub_category'])
        : null;
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_contact_number'] = this.serviceContactNumber;
    data['service_description'] = this.serviceDescription;
    data['service_image1'] = this.serviceImage1;
    data['service_image2'] = this.serviceImage2;
    data['service_image3'] = this.serviceImage3;
    if (this.serviceSubCategory != null) {
      data['service_sub_category'] = this.serviceSubCategory!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class ServiceSubCategory {
  int? id;
  String? serviceSubCategoryName;
  String? serviceSubCatDescription;
  String? serviceSubImage;
  ServiceCategoryModels? serviceCategory;
  int? createdBy;
  int? admin;

  ServiceSubCategory(
      {this.id,
        this.serviceSubCategoryName,
        this.serviceSubCatDescription,
        this.serviceSubImage,
        this.serviceCategory,
        this.createdBy,
        this.admin});

  ServiceSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceSubCategoryName = json['service_sub_category_name'];
    serviceSubCatDescription = json['service_sub_cat_description'];
    serviceSubImage = json['service_sub_image'];
    serviceCategory = json['service_category'] != null
        ? new ServiceCategoryModels.fromJson(json['service_category'])
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

class ServiceCategoryModels {
  int? id;
  String? serviceCategoryName;
  String? serviceCatDescriptions;
  String? serviceCatImage;
  int? createdBy;
  int? admin;

  ServiceCategoryModels(
      {this.id,
        this.serviceCategoryName,
        this.serviceCatDescriptions,
        this.serviceCatImage,
        this.createdBy,
        this.admin});

  ServiceCategoryModels.fromJson(Map<String, dynamic> json) {
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
