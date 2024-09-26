class HolidaysCalenderResponseModel {
  int? id;
  String? start;
  String? end;
  String? title;
  String? color;

  HolidaysCalenderResponseModel(
      {this.id, this.start, this.end, this.title, this.color});

  HolidaysCalenderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}