class LeaveAllocationResponseModel {
  int? id;
  int? months;
  int? allocatedSickLeave;
  int? allocatedCasualLeave;

  LeaveAllocationResponseModel({this.id,
    this.months,
    this.allocatedSickLeave,
    this.allocatedCasualLeave});

  LeaveAllocationResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    months = json['months'];
    allocatedSickLeave = json['allocated_sick_leave'];
    allocatedCasualLeave = json['allocated_casual_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['months'] = this.months;
    data['allocated_sick_leave'] = this.allocatedSickLeave;
    data['allocated_casual_leave'] = this.allocatedCasualLeave;
    return data;
  }
}