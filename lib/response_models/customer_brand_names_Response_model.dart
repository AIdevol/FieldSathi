class CustomerBrandNameResponseModel {
  CustomerBrandNameResponseModel({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory CustomerBrandNameResponseModel.fromJson(Map<String, dynamic> json){
    return CustomerBrandNameResponseModel(
      id: json["id"],
      name: json["name"],
    );
  }

}
