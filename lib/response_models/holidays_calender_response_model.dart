class HolidayResponseModel {
  int count;
  int totalPages;
  int currentPage;
  List<Result> results;

  HolidayResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory HolidayResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidayResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<Result>.from(json['results'].map((result) => Result.fromJson(result))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class Result {
  int id;
  String start;
  String end;
  String title;
  String color;
  int createdBy;
  int admin;

  Result({
    required this.id,
    required this.start,
    required this.end,
    required this.title,
    required this.color,
    required this.createdBy,
    required this.admin,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      start: json['start'],
      end: json['end'],
      title: json['title'],
      color: json['color'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'title': title,
      'color': color,
      'created_by': createdBy,
      'admin': admin,
    };
  }
}
//======================================================================Put method=============================================
class PutHolidayResponseModel {
  int? id;
  String? start;
  String? end;
  String? title;
  String? color;
  int? createdBy;
  int? admin;

  PutHolidayResponseModel(
      {this.id,
        this.start,
        this.end,
        this.title,
        this.color,
        this.createdBy,
        this.admin});

  PutHolidayResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    title = json['title'];
    color = json['color'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['title'] = this.title;
    data['color'] = this.color;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}