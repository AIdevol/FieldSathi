class LeaveResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<LeaveResult> results;

  LeaveResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveResponseModel(
      count: json['count'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      results: (json['results'] as List)
          .map((item) => LeaveResult.fromJson(item))
          .toList(),
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

class LeaveResult {
  final int id;
  final String startDate;
  final String endDate;
  final String reason;
  final String status;
  final String leaveType;
  final String createdAt;
  final User userId;

  LeaveResult({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.leaveType,
    required this.createdAt,
    required this.userId,
  });

  factory LeaveResult.fromJson(Map<String, dynamic> json) {
    return LeaveResult(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      reason: json['reason'],
      status: json['status'],
      leaveType: json['leave_type'],
      createdAt: json['created_at'],
      userId: User.fromJson(json['userId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate,
      'end_date': endDate,
      'reason': reason,
      'status': status,
      'leave_type': leaveType,
      'created_at': createdAt,
      'userId': userId.toJson(),
    };
  }
}

class User {
  final int id;
  final TodayAttendance todayAttendance;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final bool isActive;
  final String role;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;

  User({
    required this.id,
    required this.todayAttendance,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.role,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      todayAttendance: TodayAttendance.fromJson(json['today_attendance']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      isActive: json['is_active'],
      role: json['role'],
      allocatedSickLeave: json['allocated_sick_leave'] ?? 0,
      allocatedCasualLeave: json['allocated_casual_leave'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'today_attendance': todayAttendance.toJson(),
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'is_active': isActive,
      'role': role,
      'allocated_sick_leave': allocatedSickLeave,
      'allocated_casual_leave': allocatedCasualLeave,
    };
  }
}

class TodayAttendance {
  final int id;
  final int user;
  final String punchIn;
  final String? punchOut;
  final String status;
  final String date;

  TodayAttendance({
    required this.id,
    required this.user,
    required this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'],
      user: json['user'],
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'punch_in': punchIn,
      'punch_out': punchOut,
      'status': status,
      'date': date,
    };
  }
}

