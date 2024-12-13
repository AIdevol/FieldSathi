class LeaveAllocationResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<LeaveAllocationResult> results;

  LeaveAllocationResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory LeaveAllocationResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveAllocationResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: (json['results'] as List)
          .map((item) => LeaveAllocationResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

class LeaveAllocationResult {
  final int id;
  final int adminUser;
  final int months;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;

  LeaveAllocationResult({
    required this.id,
    required this.adminUser,
    required this.months,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
  });

  factory LeaveAllocationResult.fromJson(Map<String, dynamic> json) {
    return LeaveAllocationResult(
      id: json['id'],
      adminUser: json['admin_user'],
      months: json['months'],
      allocatedSickLeave: json['allocated_sick_leave'],
      allocatedCasualLeave: json['allocated_casual_leave'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_user': adminUser,
      'months': months,
      'allocated_sick_leave': allocatedSickLeave,
      'allocated_casual_leave': allocatedCasualLeave,
    };
  }
}
//=========================================================================leave post===============================
class LeavePostResponseModel {
  LeavePostResponseModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final Data? data;

  factory LeavePostResponseModel.fromJson(Map<String, dynamic> json){
    return LeavePostResponseModel(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.leaveType,
    required this.createdAt,
    required this.userId,
    required this.createdBy,
  });

  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? reason;
  final String? status;
  final String? leaveType;
  final DateTime? createdAt;
  final UserId? userId;
  final String? createdBy;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      reason: json["reason"],
      status: json["status"],
      leaveType: json["leave_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      createdBy: json["created_by"],
    );
  }

}

class UserId {
  UserId({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    required this.lastLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.employees,
    required this.dob,
    required this.otp,
    required this.otpVerified,
    required this.isStaff,
    required this.isSuperuser,
    required this.isActive,
    required this.profileImage,
    required this.customerName,
    required this.customerTag,
    required this.modelNo,
    required this.socialId,
    required this.deactivate,
    required this.role,
    required this.customerType,
    required this.batteryStatus,
    required this.gpsStatus,
    required this.longitude,
    required this.latitude,
    required this.companyAddress,
    required this.companyCity,
    required this.companyState,
    required this.companyPincode,
    required this.companyCountry,
    required this.companyRegion,
    required this.companyLandlineNo,
    required this.gstNo,
    required this.cinNo,
    required this.panNo,
    required this.companyContactNo,
    required this.companyWebsite,
    required this.bankName,
    required this.ifscSwift,
    required this.accountNumber,
    required this.branchAddress,
    required this.upiId,
    required this.paymentLink,
    required this.fileUpload,
    required this.primaryAddress,
    required this.landmarkPaci,
    required this.notes,
    required this.state,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.region,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    required this.dateJoined,
    required this.maxEmployeesAllowed,
    required this.employeesCreated,
    required this.isLeaveAllocated,
    required this.empId,
    required this.isDisabled,
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    required this.customerId,
    required this.subscription,
  });

  final int? id;
  final List<TodayAttendance> todayAttendance;
  final List<dynamic> brandNames;
  final dynamic lastLogin;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? employees;
  final dynamic dob;
  final String? otp;
  final bool? otpVerified;
  final bool? isStaff;
  final bool? isSuperuser;
  final bool? isActive;
  final String? profileImage;
  final dynamic customerName;
  final dynamic customerTag;
  final dynamic modelNo;
  final dynamic socialId;
  final bool? deactivate;
  final String? role;
  final dynamic customerType;
  final String? batteryStatus;
  final bool? gpsStatus;
  final String? longitude;
  final String? latitude;
  final dynamic companyAddress;
  final dynamic companyCity;
  final dynamic companyState;
  final dynamic companyPincode;
  final dynamic companyCountry;
  final dynamic companyRegion;
  final dynamic companyLandlineNo;
  final dynamic gstNo;
  final dynamic cinNo;
  final dynamic panNo;
  final dynamic companyContactNo;
  final dynamic companyWebsite;
  final dynamic bankName;
  final dynamic ifscSwift;
  final dynamic accountNumber;
  final dynamic branchAddress;
  final dynamic upiId;
  final dynamic paymentLink;
  final dynamic fileUpload;
  final dynamic primaryAddress;
  final dynamic landmarkPaci;
  final dynamic notes;
  final dynamic state;
  final dynamic country;
  final dynamic city;
  final dynamic zipcode;
  final dynamic region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final DateTime? dateJoined;
  final int? maxEmployeesAllowed;
  final int? employeesCreated;
  final bool? isLeaveAllocated;
  final String? empId;
  final bool? isDisabled;
  final DateTime? createdAt;
  final String? createdBy;
  final int? admin;
  final dynamic customerId;
  final dynamic subscription;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? [] : List<TodayAttendance>.from(json["today_attendance"]!.map((x) => TodayAttendance.fromJson(x))),
      brandNames: json["brand_names"] == null ? [] : List<dynamic>.from(json["brand_names"]!.map((x) => x)),
      lastLogin: json["last_login"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      companyName: json["company_name"],
      employees: json["employees"],
      dob: json["dob"],
      otp: json["otp"],
      otpVerified: json["otp_verified"],
      isStaff: json["is_staff"],
      isSuperuser: json["is_superuser"],
      isActive: json["is_active"],
      profileImage: json["profile_image"],
      customerName: json["customer_name"],
      customerTag: json["customer_tag"],
      modelNo: json["model_no"],
      socialId: json["social_id"],
      deactivate: json["deactivate"],
      role: json["role"],
      customerType: json["customer_type"],
      batteryStatus: json["battery_status"],
      gpsStatus: json["gps_status"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      companyAddress: json["companyAddress"],
      companyCity: json["companyCity"],
      companyState: json["companyState"],
      companyPincode: json["companyPincode"],
      companyCountry: json["companyCountry"],
      companyRegion: json["companyRegion"],
      companyLandlineNo: json["companyLandlineNo"],
      gstNo: json["gstNo"],
      cinNo: json["cinNo"],
      panNo: json["panNo"],
      companyContactNo: json["companyContactNo"],
      companyWebsite: json["companyWebsite"],
      bankName: json["bankName"],
      ifscSwift: json["ifscSwift"],
      accountNumber: json["accountNumber"],
      branchAddress: json["branchAddress"],
      upiId: json["upiId"],
      paymentLink: json["paymentLink"],
      fileUpload: json["fileUpload"],
      primaryAddress: json["primary_address"],
      landmarkPaci: json["landmark_paci"],
      notes: json["notes"],
      state: json["state"],
      country: json["country"],
      city: json["city"],
      zipcode: json["zipcode"],
      region: json["region"],
      allocatedSickLeave: json["allocated_sick_leave"],
      allocatedCasualLeave: json["allocated_casual_leave"],
      dateJoined: DateTime.tryParse(json["date_joined"] ?? ""),
      maxEmployeesAllowed: json["max_employees_allowed"],
      employeesCreated: json["employees_created"],
      isLeaveAllocated: json["is_leave_allocated"],
      empId: json["emp_id"],
      isDisabled: json["is_disabled"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      createdBy: json["created_by"],
      admin: json["admin"],
      customerId: json["customer_id"],
      subscription: json["subscription"],
    );
  }

}

class TodayAttendance {
  TodayAttendance({
    required this.id,
    required this.user,
    required this.punchIn,
    required this.punchOut,
    required this.status,
    required this.date,
  });

  final int? id;
  final int? user;
  final dynamic punchIn;
  final dynamic punchOut;
  final String? status;
  final DateTime? date;

  factory TodayAttendance.fromJson(Map<String, dynamic> json){
    return TodayAttendance(
      id: json["id"],
      user: json["user"],
      punchIn: json["punch_in"],
      punchOut: json["punch_out"],
      status: json["status"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

}
