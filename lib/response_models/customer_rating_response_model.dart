class CustomerRatingResponseModel {
  int? ratedCustomersCount;
  double? averageRating;

  CustomerRatingResponseModel({this.ratedCustomersCount, this.averageRating});

  CustomerRatingResponseModel.fromJson(Map<String, dynamic> json) {
    ratedCustomersCount = json['rated_customers_count'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rated_customers_count'] = this.ratedCustomersCount;
    data['average_rating'] = this.averageRating;
    return data;
  }
}