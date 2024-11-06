class HolidaysCalendarResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<Result> results;

  HolidaysCalendarResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory HolidaysCalendarResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidaysCalendarResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
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

class Result {
  final int? id;
  final String? start;
  final String? end;
  final String? title;
  final String? color;
  final String? createdBy;
  final String? admin;

  Result( {
    this.id,
    this.start,
    this.end,
    this.title,
    this.color,
    this.createdBy,
    this.admin,
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
