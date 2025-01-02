class CustomerBrandResponseModel {
  int? id;
  String? name;

  CustomerBrandResponseModel({this.id, this.name});

  CustomerBrandResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

//==================================================Brand AMC Name ==============================
class BrandAmcNameResponseModel {
  BrandAmcNameResponseModel({
    required this.amcid,
    required this.amcName,
  });

  final int? amcid;
  final String? amcName;

  factory BrandAmcNameResponseModel.fromJson(Map<String, dynamic> json){
    return BrandAmcNameResponseModel(
      amcid: json["amcid"],
      amcName: json["amcName"],
    );
  }

}


//=================================================================class FsrCategoriesNameResponseModel {

class FsrCategoriesNameResponseModel {
  FsrCategoriesNameResponseModel({
    required this.categoryId,
    required this.categoryName,
  });

  final int? categoryId;
  final String? categoryName;

  factory FsrCategoriesNameResponseModel.fromJson(Map<String, dynamic> json){
    return FsrCategoriesNameResponseModel(
      categoryId: json["category_id"],
      categoryName: json["category_name"],
    );
  }
}

