class UserResponseModel {
  UserResponseModel({
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
  final TodayAttendance? todayAttendance;
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
  final String? companyAddress;
  final String? companyCity;
  final String? companyState;
  final String? companyPincode;
  final String? companyCountry;
  final String? companyRegion;
  final String? companyLandlineNo;
  final String? gstNo;
  final String? cinNo;
  final String? panNo;
  final String? companyContactNo;
  final String? companyWebsite;
  final String? bankName;
  final String? ifscSwift;
  final String? accountNumber;
  final String? branchAddress;
  final String? upiId;
  final String? paymentLink;
  final dynamic fileUpload;
  final String? primaryAddress;
  final dynamic landmarkPaci;
  final String? notes;
  final dynamic state;
  final String? country;
  final dynamic city;
  final dynamic zipcode;
  final dynamic region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final dynamic dateJoined;
  final int? maxEmployeesAllowed;
  final int? employeesCreated;
  final bool? isLeaveAllocated;
  final dynamic empId;
  final bool? isDisabled;
  final DateTime? createdAt;
  final String? createdBy;
  final int? admin;
  final dynamic customerId;
  final dynamic subscription;

  factory UserResponseModel.fromJson(Map<String, dynamic> json){
    return UserResponseModel(
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? null : TodayAttendance.fromJson(json["today_attendance"]),
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
      dateJoined: json["date_joined"],
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

// class TodayAttendance {
//   TodayAttendance({
//     required this.id,
//     required this.user,
//     required this.punchIn,
//     required this.punchOut,
//     required this.status,
//     required this.date,
//   });
//
//   final int? id;
//   final int? user;
//   final dynamic punchIn;
//   final dynamic punchOut;
//   final String? status;
//   final DateTime? date;
//
//   factory TodayAttendance.fromJson(Map<String, dynamic> json){
//     return TodayAttendance(
//       id: json["id"],
//       user: json["user"],
//       punchIn: json["punch_in"],
//       punchOut: json["punch_out"],
//       status: json["status"],
//       date: DateTime.tryParse(json["date"] ?? ""),
//     );
//   }
//
// }
// ============================================================================tmsUserData============
class TMSResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<TMSResult>? results;

  TMSResponseModel({this.count, this.totalPages, this.currentPage, this.results});

  factory TMSResponseModel.fromJson(Map<String, dynamic> json) {
    return TMSResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => TMSResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results?.map((item) => item.toJson()).toList(),
    };
  }
}

class TMSResult {
  int? id;
  TodayAttendance? todayAttendance;
  List<dynamic>? brandNames;
  String? lastLogin;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? companyName;
  String? employees;
  String? dob;
  String? otp;
  bool? otpVerified;
  bool? isStaff;
  bool? isSuperuser;
  bool? isActive;
  String? profileImage;
  String? customerName;
  String? customerTag;
  String? modelNo;
  String? socialId;
  bool? deactivate;
  String? role;
  String? customerType;
  String? batteryStatus;
  bool? gpsStatus;
  String? longitude;
  String? latitude;
  String? companyAddress;
  String? companyCity;
  String? companyState;
  String? companyPincode;
  String? companyCountry;
  String? companyRegion;
  String? companyLandlineNo;
  String? gstNo;
  String? cinNo;
  String? panNo;
  String? companyContactNo;
  String? companyWebsite;
  String? bankName;
  String? ifscSwift;
  String? accountNumber;
  String? branchAddress;
  String? upiId;
  String? paymentLink;
  String? fileUpload;
  String? primaryAddress;
  String? landmarkPaci;
  String? notes;
  String? state;
  String? country;
  String? city;
  String? zipcode;
  String? region;
  int? allocatedSickLeave;
  int? allocatedCasualLeave;
  String? dateJoined;
  int? maxEmployeesAllowed;
  int? employeesCreated;
  bool? isLeaveAllocated;
  String? empId;
  bool? isDisabled;
  String? createdAt;
  String? createdBy;
  int? admin;
  String? customerId;
  String? subscription;

  TMSResult({
    this.id,
    this.todayAttendance,
    this.brandNames,
    this.lastLogin,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.companyName,
    this.employees,
    this.dob,
    this.otp,
    this.otpVerified,
    this.isStaff,
    this.isSuperuser,
    this.isActive,
    this.profileImage,
    this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    this.deactivate,
    this.role,
    this.customerType,
    this.batteryStatus,
    this.gpsStatus,
    this.longitude,
    this.latitude,
    this.companyAddress,
    this.companyCity,
    this.companyState,
    this.companyPincode,
    this.companyCountry,
    this.companyRegion,
    this.companyLandlineNo,
    this.gstNo,
    this.cinNo,
    this.panNo,
    this.companyContactNo,
    this.companyWebsite,
    this.bankName,
    this.ifscSwift,
    this.accountNumber,
    this.branchAddress,
    this.upiId,
    this.paymentLink,
    this.fileUpload,
    this.primaryAddress,
    this.landmarkPaci,
    this.notes,
    this.state,
    this.country,
    this.city,
    this.zipcode,
    this.region,
    this.allocatedSickLeave,
    this.allocatedCasualLeave,
    this.dateJoined,
    this.maxEmployeesAllowed,
    this.employeesCreated,
    this.isLeaveAllocated,
    this.empId,
    this.isDisabled,
    this.createdAt,
    this.createdBy,
    this.admin,
    this.customerId,
    this.subscription,
  });

  factory TMSResult.fromJson(Map<String, dynamic> json) {
    return TMSResult(
      id: json['id'],
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'])
          : null,
      brandNames: json['brand_names'] as List<dynamic>?,
      lastLogin: json['last_login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      employees: json['employees'],
      dob: json['dob'],
      otp: json['otp'],
      otpVerified: json['otp_verified'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      isActive: json['is_active'],
      profileImage: json['profile_image'],
      customerName: json['customer_name'],
      customerTag: json['customer_tag'],
      modelNo: json['model_no'],
      socialId: json['social_id'],
      deactivate: json['deactivate'],
      role: json['role'],
      customerType: json['customer_type'],
      batteryStatus: json['battery_status'],
      gpsStatus: json['gps_status'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      companyAddress: json['companyAddress'],
      companyCity: json['companyCity'],
      companyState: json['companyState'],
      companyPincode: json['companyPincode'],
      companyCountry: json['companyCountry'],
      companyRegion: json['companyRegion'],
      companyLandlineNo: json['companyLandlineNo'],
      gstNo: json['gstNo'],
      cinNo: json['cinNo'],
      panNo: json['panNo'],
      companyContactNo: json['companyContactNo'],
      companyWebsite: json['companyWebsite'],
      bankName: json['bankName'],
      ifscSwift: json['ifscSwift'],
      accountNumber: json['accountNumber'],
      branchAddress: json['branchAddress'],
      upiId: json['upiId'],
      paymentLink: json['paymentLink'],
      fileUpload: json['fileUpload'],
      primaryAddress: json['primary_address'],
      landmarkPaci: json['landmark_paci'],
      notes: json['notes'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
      zipcode: json['zipcode'],
      region: json['region'],
      allocatedSickLeave: json['allocated_sick_leave'],
      allocatedCasualLeave: json['allocated_casual_leave'],
      dateJoined: json['date_joined'],
      maxEmployeesAllowed: json['max_employees_allowed'],
      employeesCreated: json['employees_created'],
      isLeaveAllocated: json['is_leave_allocated'],
      empId: json['emp_id'],
      isDisabled: json['is_disabled'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      admin: json['admin'],
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
      'companyAddress': companyAddress,
      'companyCity': companyCity,
      'companyState': companyState,
      'companyPincode': companyPincode,
      'companyCountry': companyCountry,
      'companyRegion': companyRegion,
      'companyLandlineNo': companyLandlineNo,
      'gstNo': gstNo,
      'cinNo': cinNo,
      'panNo': panNo,
      'companyContactNo': companyContactNo,
      'companyWebsite': companyWebsite,
      'bankName': bankName,
      'ifscSwift': ifscSwift,
      'accountNumber': accountNumber,
      'branchAddress': branchAddress,
      'upiId': upiId,
      'paymentLink': paymentLink,
      'fileUpload': fileUpload,
      'primary_address': primaryAddress,
      'landmark_paci': landmarkPaci,
      'notes': notes,
      'state': state,
      'country': country,
      'city': city,
      'zipcode': zipcode,
      'region': region,
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
  int? id;
  int? user;
  String? punchIn;
  String? punchOut;
  String? status;
  String? date;

  TodayAttendance({this.id, this.user, this.punchIn, this.punchOut, this.status, this.date});

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
//================================================================delete response====================================
class DeleteUserResponseModel {
  String? message;

  DeleteUserResponseModel({this.message});

  DeleteUserResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}