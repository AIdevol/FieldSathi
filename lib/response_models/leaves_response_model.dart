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
      results: (json['results'] as List<dynamic>?)
          ?.map((result) => LeaveResult.fromJson(result))
          .toList() ?? [],
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
  final UserDetails userId;
  final String? createdBy;

  LeaveResult({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.leaveType,
    required this.createdAt,
    required this.userId,
    this.createdBy,
  });

  factory LeaveResult.fromJson(Map<String, dynamic> json) {
    return LeaveResult(
      id: json['id'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
      leaveType: json['leave_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      userId: UserDetails.fromJson(json['userId'] ?? {}),
      createdBy: json['created_by'],
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
      'created_by': createdBy,
    };
  }
}

class UserDetails {
  final int id;
  final TodayAttendance? todayAttendance;
  final List<dynamic> brandNames;
  final String? lastLogin;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? companyName;
  final String? employees;
  final String? dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final String? customerName;
  final String? customerTag;
  final String? modelNo;
  final String? socialId;
  final bool deactivate;
  final String role;
  final String? customerType;
  final String batteryStatus;
  final bool gpsStatus;
  final String longitude;
  final String latitude;
  // Multiple company-related fields omitted for brevity
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final String dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final String empId;
  final bool isDisabled;
  final String createdAt;
  final String createdBy;
  final int admin;
  final String? customerId;
  final dynamic subscription;

  UserDetails({
    required this.id,
    this.todayAttendance,
    this.brandNames = const [],
    this.lastLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.companyName,
    this.employees,
    this.dob,
    this.otp = '',
    this.otpVerified = false,
    this.isStaff = false,
    this.isSuperuser = false,
    this.isActive = false,
    this.profileImage,
    this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    this.deactivate = false,
    required this.role,
    this.customerType,
    this.batteryStatus = '',
    this.gpsStatus = false,
    this.longitude = '',
    this.latitude = '',
    this.allocatedSickLeave = 0,
    this.allocatedCasualLeave = 0,
    required this.dateJoined,
    this.maxEmployeesAllowed = 0,
    this.employeesCreated = 0,
    this.isLeaveAllocated = false,
    required this.empId,
    this.isDisabled = false,
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    this.customerId,
    this.subscription,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? 0,
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'])
          : null,
      brandNames: json['brand_names'] ?? [],
      lastLogin: json['last_login'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'],
      employees: json['employees'],
      dob: json['dob'],
      otp: json['otp'] ?? '',
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'],
      customerTag: json['customer_tag'],
      modelNo: json['model_no'],
      socialId: json['social_id'],
      deactivate: json['deactivate'] ?? false,
      role: json['role'] ?? '',
      customerType: json['customer_type'],
      batteryStatus: json['battery_status'] ?? '',
      gpsStatus: json['gps_status'] ?? false,
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      allocatedSickLeave: json['allocated_sick_leave'] ?? 0,
      allocatedCasualLeave: json['allocated_casual_leave'] ?? 0,
      dateJoined: json['date_joined'] ?? '',
      maxEmployeesAllowed: json['max_employees_allowed'] ?? 0,
      employeesCreated: json['employees_created'] ?? 0,
      isLeaveAllocated: json['is_leave_allocated'] ?? false,
      empId: json['emp_id'] ?? '',
      isDisabled: json['is_disabled'] ?? false,
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? '',
      admin: json['admin'] ?? 0,
      customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'today_attendance': todayAttendance?.toJson(),
      'brand_names': brandNames,
      'last_login': lastLogin,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'company_name': companyName,
      'employees': employees,
      'dob': dob,
      'otp': otp,
      'otp_verified': otpVerified,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'is_active': isActive,
      'profile_image': profileImage,
      'customer_name': customerName,
      'customer_tag': customerTag,
      'model_no': modelNo,
      'social_id': socialId,
      'deactivate': deactivate,
      'role': role,
      'customer_type': customerType,
      'battery_status': batteryStatus,
      'gps_status': gpsStatus,
      'longitude': longitude,
      'latitude': latitude,
      'allocated_sick_leave': allocatedSickLeave,
      'allocated_casual_leave': allocatedCasualLeave,
      'date_joined': dateJoined,
      'max_employees_allowed': maxEmployeesAllowed,
      'employees_created': employeesCreated,
      'is_leave_allocated': isLeaveAllocated,
      'emp_id': empId,
      'is_disabled': isDisabled,
      'created_at': createdAt,
      'created_by': createdBy,
      'admin': admin,
      'customer_id': customerId,
      'subscription': subscription,
    };
  }
}

class TodayAttendance {
  final int id;
  final int user;
  final String? punchIn;
  final String? punchOut;
  final String status;
  final String date;

  TodayAttendance({
    required this.id,
    required this.user,
    this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
      status: json['status'] ?? '',
      date: json['date'] ?? '',
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