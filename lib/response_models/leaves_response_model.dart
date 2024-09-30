// To parse this JSON data, do
//
//     final leaveManagement = leaveManagementFromJson(jsonString);

import 'dart:convert';

LeaveManagementResponseModel leaveManagementFromJson(String str) => LeaveManagementResponseModel.fromJson(json.decode(str));

String leaveManagementToJson(LeaveManagementResponseModel data) => json.encode(data.toJson());

class LeaveManagementResponseModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  LeaveManagementResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory LeaveManagementResponseModel.fromJson(Map<String, dynamic> json) => LeaveManagementResponseModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  UserId userId;
  DateTime startDate;
  DateTime endDate;
  String reason;
  String status;
  String leaveType;

  Result({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.leaveType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    userId: UserId.fromJson(json["userId"]),
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    reason: json["reason"],
    status: json["status"],
    leaveType: json["leave_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId.toJson(),
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "reason": reason,
    "status": status,
    "leave_type": leaveType,
  };
}

class UserId {
  int id;
  TodayAttendance todayAttendance;
  List<dynamic> brandNames;
  dynamic lastLogin;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String companyName;
  String employees;
  dynamic dob;
  String otp;
  bool otpVerified;
  bool isStaff;
  bool isSuperuser;
  bool isActive;
  dynamic profileImage;
  dynamic customerName;
  dynamic customerTag;
  dynamic modelNo;
  dynamic socialId;
  bool deactivate;
  String role;
  dynamic customerType;
  String batteryStatus;
  bool gpsStatus;
  dynamic longitude;
  dynamic latitude;
  dynamic companyAddress;
  dynamic companyCity;
  dynamic companyState;
  dynamic companyPincode;
  dynamic companyCountry;
  dynamic companyRegion;
  dynamic companyLandlineNo;
  dynamic gstNo;
  dynamic cinNo;
  dynamic panNo;
  dynamic companyContactNo;
  dynamic companyWebsite;
  dynamic bankName;
  dynamic ifscSwift;
  dynamic accountNumber;
  dynamic branchAddress;
  dynamic upiId;
  dynamic paymentLink;
  dynamic fileUpload;
  dynamic primaryAddress;
  dynamic landmarkPaci;
  dynamic notes;
  dynamic state;
  dynamic country;
  dynamic city;
  dynamic zipcode;
  dynamic region;
  int allocatedSickLeave;
  int allocatedCasualLeave;
  dynamic dateJoined;
  int createdBy;
  int admin;
  dynamic customerId;

  UserId({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    this.lastLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.employees,
    this.dob,
    required this.otp,
    required this.otpVerified,
    required this.isStaff,
    required this.isSuperuser,
    required this.isActive,
    this.profileImage,
    this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    required this.deactivate,
    required this.role,
    this.customerType,
    required this.batteryStatus,
    required this.gpsStatus,
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
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    this.dateJoined,
    required this.createdBy,
    required this.admin,
    this.customerId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["id"],
    todayAttendance: TodayAttendance.fromJson(json["today_attendance"]),
    brandNames: List<dynamic>.from(json["brand_names"].map((x) => x)),
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
    createdBy: json["created_by"],
    admin: json["admin"],
    customerId: json["customer_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "today_attendance": todayAttendance.toJson(),
    "brand_names": List<dynamic>.from(brandNames.map((x) => x)),
    "last_login": lastLogin,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "company_name": companyName,
    "employees": employees,
    "dob": dob,
    "otp": otp,
    "otp_verified": otpVerified,
    "is_staff": isStaff,
    "is_superuser": isSuperuser,
    "is_active": isActive,
    "profile_image": profileImage,
    "customer_name": customerName,
    "customer_tag": customerTag,
    "model_no": modelNo,
    "social_id": socialId,
    "deactivate": deactivate,
    "role": role,
    "customer_type": customerType,
    "battery_status": batteryStatus,
    "gps_status": gpsStatus,
    "longitude": longitude,
    "latitude": latitude,
    "companyAddress": companyAddress,
    "companyCity": companyCity,
    "companyState": companyState,
    "companyPincode": companyPincode,
    "companyCountry": companyCountry,
    "companyRegion": companyRegion,
    "companyLandlineNo": companyLandlineNo,
    "gstNo": gstNo,
    "cinNo": cinNo,
    "panNo": panNo,
    "companyContactNo": companyContactNo,
    "companyWebsite": companyWebsite,
    "bankName": bankName,
    "ifscSwift": ifscSwift,
    "accountNumber": accountNumber,
    "branchAddress": branchAddress,
    "upiId": upiId,
    "paymentLink": paymentLink,
    "fileUpload": fileUpload,
    "primary_address": primaryAddress,
    "landmark_paci": landmarkPaci,
    "notes": notes,
    "state": state,
    "country": country,
    "city": city,
    "zipcode": zipcode,
    "region": region,
    "allocated_sick_leave": allocatedSickLeave,
    "allocated_casual_leave": allocatedCasualLeave,
    "date_joined": dateJoined,
    "created_by": createdBy,
    "admin": admin,
    "customer_id": customerId,
  };
}

class TodayAttendance {
  int id;
  int user;
  dynamic checkIn;
  dynamic checkOut;
  String status;
  DateTime date;

  TodayAttendance({
    required this.id,
    required this.user,
    this.checkIn,
    this.checkOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) => TodayAttendance(
    id: json["id"],
    user: json["user"],
    checkIn: json["check_in"],
    checkOut: json["check_out"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "check_in": checkIn,
    "check_out": checkOut,
    "status": status,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}