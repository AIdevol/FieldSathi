class UserLeavesDataResponseModel {
  UserLeavesDataResponseModel({
    required this.userLeaveData,
  });

  final List<UserLeaveDatum> userLeaveData;

  factory UserLeavesDataResponseModel.fromJson(Map<String, dynamic> json){
    return UserLeavesDataResponseModel(
      userLeaveData: json["user_leave_data"] == null ? [] : List<UserLeaveDatum>.from(json["user_leave_data"]!.map((x) => UserLeaveDatum.fromJson(x))),
    );
  }

}

class UserLeaveDatum {
  UserLeaveDatum({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
  });

  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? role;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;

  factory UserLeaveDatum.fromJson(Map<String, dynamic> json){
    return UserLeaveDatum(
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      role: json["role"],
      allocatedSickLeave: json["allocated_sick_leave"],
      allocatedCasualLeave: json["allocated_casual_leave"],
    );
  }

}
//============================================================================================
class TechnicianAttendanceDataResponseModel {
  TechnicianAttendanceDataResponseModel({
    required this.totalTechnicianCount,
    required this.totalTechnicianPresent,
    required this.totalTechnicianAbsent,
    required this.totalTechnicianIdle,
  });

  final int? totalTechnicianCount;
  final int? totalTechnicianPresent;
  final int? totalTechnicianAbsent;
  final int? totalTechnicianIdle;

  factory TechnicianAttendanceDataResponseModel.fromJson(Map<String, dynamic> json){
    return TechnicianAttendanceDataResponseModel(
      totalTechnicianCount: json["total_technician_count"],
      totalTechnicianPresent: json["total_technician_present"],
      totalTechnicianAbsent: json["total_technician_absent"],
      totalTechnicianIdle: json["total_technician_idle"],
    );
  }

}
