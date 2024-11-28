// class TechnicianResponseModel {
//   final int count;
//   final int totalPages;
//   final List<TechnicianResults> results;
//
//   TechnicianResponseModel({
//     required this.count,
//     required this.totalPages,
//     required this.results,
//   });
//
//   factory TechnicianResponseModel.fromJson(Map<String, dynamic> json) {
//     return TechnicianResponseModel(
//       count: json['count'] ?? 0,
//       totalPages: json['total_pages'] ?? 0,
//       results: (json['results'] as List<dynamic>?)
//           ?.map((e) => TechnicianResults.fromJson(e as Map<String, dynamic>))
//           .toList() ??
//           [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'count': count,
//       'total_pages': totalPages,
//       'results': results.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class TechnicianResults {
//   final int id;
//   final dynamic todayAttendance;
//   final List<String> brandNames;
//   final dynamic lastLogin;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final String companyName;
//   final String employees;
//   final dynamic dob;
//   final String otp;
//   final bool otpVerified;
//   final bool isStaff;
//   final bool isSuperuser;
//   final bool isActive;
//   final dynamic profileImage;
//   final dynamic customerName;
//   final dynamic customerTag;
//   final dynamic modelNo;
//   final dynamic socialId;
//   final bool deactivate;
//   final String role;
//   final dynamic customerType;
//   final String? batteryStatus;
//   final bool gpsStatus;
//   final String? longitude;
//   final String? latitude;
//   final dynamic companyAddress;
//   final dynamic companyCity;
//   final dynamic companyState;
//   final dynamic companyPincode;
//   final dynamic companyCountry;
//   final dynamic companyRegion;
//   final dynamic companyLandlineNo;
//   final dynamic gstNo;
//   final dynamic cinNo;
//   final dynamic panNo;
//   final dynamic companyContactNo;
//   final dynamic companyWebsite;
//   final dynamic bankName;
//   final dynamic ifscSwift;
//   final dynamic accountNumber;
//   final dynamic branchAddress;
//   final dynamic upiId;
//   final dynamic paymentLink;
//   final dynamic fileUpload;
//   final dynamic primaryAddress;
//   final dynamic landmarkPaci;
//   final dynamic notes;
//   final dynamic state;
//   final dynamic country;
//   final dynamic city;
//   final dynamic zipcode;
//   final dynamic region;
//   final int allocatedSickLeave;
//   final int allocatedCasualLeave;
//   final String dateJoined;
//   final int maxEmployeesAllowed;
//   final int employeesCreated;
//   final bool isLeaveAllocated;
//   final String empId;
//   final bool isDisabled;
//   final String createdAt;
//   final int createdBy;
//   final int admin;
//   final dynamic customerId;
//   final dynamic subscription;
//
//   TechnicianResults({
//     required this.id,
//     this.todayAttendance,
//     required this.brandNames,
//     this.lastLogin,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.companyName,
//     required this.employees,
//     this.dob,
//     required this.otp,
//     required this.otpVerified,
//     required this.isStaff,
//     required this.isSuperuser,
//     required this.isActive,
//     this.profileImage,
//     this.customerName,
//     this.customerTag,
//     this.modelNo,
//     this.socialId,
//     required this.deactivate,
//     required this.role,
//     this.customerType,
//     this.batteryStatus,
//     required this.gpsStatus,
//     this.longitude,
//     this.latitude,
//     this.companyAddress,
//     this.companyCity,
//     this.companyState,
//     this.companyPincode,
//     this.companyCountry,
//     this.companyRegion,
//     this.companyLandlineNo,
//     this.gstNo,
//     this.cinNo,
//     this.panNo,
//     this.companyContactNo,
//     this.companyWebsite,
//     this.bankName,
//     this.ifscSwift,
//     this.accountNumber,
//     this.branchAddress,
//     this.upiId,
//     this.paymentLink,
//     this.fileUpload,
//     this.primaryAddress,
//     this.landmarkPaci,
//     this.notes,
//     this.state,
//     this.country,
//     this.city,
//     this.zipcode,
//     this.region,
//     required this.allocatedSickLeave,
//     required this.allocatedCasualLeave,
//     required this.dateJoined,
//     required this.maxEmployeesAllowed,
//     required this.employeesCreated,
//     required this.isLeaveAllocated,
//     required this.empId,
//     required this.isDisabled,
//     required this.createdAt,
//     required this.createdBy,
//     required this.admin,
//     this.customerId,
//     this.subscription,
//   });
//
//   factory TechnicianResults.fromJson(Map<String, dynamic> json) {
//     return TechnicianResults(
//       id: json['id'] ?? 0,
//       todayAttendance: json['today_attendance'],
//       brandNames: List<String>.from(json['brand_names'] ?? []),
//       lastLogin: json['last_login'],
//       firstName: json['first_name'] ?? '',
//       lastName: json['last_name'] ?? '',
//       email: json['email'] ?? '',
//       phoneNumber: json['phone_number'] ?? '',
//       companyName: json['company_name'] ?? '',
//       employees: json['employees'] ?? '',
//       dob: json['dob'],
//       otp: json['otp'] ?? '',
//       otpVerified: json['otp_verified'] ?? false,
//       isStaff: json['is_staff'] ?? false,
//       isSuperuser: json['is_superuser'] ?? false,
//       isActive: json['is_active'] ?? false,
//       profileImage: json['profile_image'],
//       customerName: json['customer_name'],
//       customerTag: json['customer_tag'],
//       modelNo: json['model_no'],
//       socialId: json['social_id'],
//       deactivate: json['deactivate'] ?? false,
//       role: json['role'] ?? '',
//       customerType: json['customer_type'],
//       batteryStatus: json['battery_status'],
//       gpsStatus: json['gps_status'] ?? false,
//       longitude: json['longitude'],
//       latitude: json['latitude'],
//       companyAddress: json['companyAddress'],
//       companyCity: json['companyCity'],
//       companyState: json['companyState'],
//       companyPincode: json['companyPincode'],
//       companyCountry: json['companyCountry'],
//       companyRegion: json['companyRegion'],
//       companyLandlineNo: json['companyLandlineNo'],
//       gstNo: json['gstNo'],
//       cinNo: json['cinNo'],
//       panNo: json['panNo'],
//       companyContactNo: json['companyContactNo'],
//       companyWebsite: json['companyWebsite'],
//       bankName: json['bankName'],
//       ifscSwift: json['ifscSwift'],
//       accountNumber: json['accountNumber'],
//       branchAddress: json['branchAddress'],
//       upiId: json['upiId'],
//       paymentLink: json['paymentLink'],
//       fileUpload: json['fileUpload'],
//       primaryAddress: json['primary_address'],
//       landmarkPaci: json['landmark_paci'],
//       notes: json['notes'],
//       state: json['state'],
//       country: json['country'],
//       city: json['city'],
//       zipcode: json['zipcode'],
//       region: json['region'],
//       allocatedSickLeave: json['allocated_sick_leave'] ?? 0,
//       allocatedCasualLeave: json['allocated_casual_leave'] ?? 0,
//       dateJoined: json['date_joined'] ?? '',
//       maxEmployeesAllowed: json['max_employees_allowed'] ?? 0,
//       employeesCreated: json['employees_created'] ?? 0,
//       isLeaveAllocated: json['is_leave_allocated'] ?? false,
//       empId: json['emp_id'] ?? '',
//       isDisabled: json['is_disabled'] ?? false,
//       createdAt: json['created_at'] ?? '',
//       createdBy: json['created_by'] ?? 0,
//       admin: json['admin'] ?? 0,
//       customerId: json['customer_id'],
//       subscription: json['subscription'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'today_attendance': todayAttendance,
//       'brand_names': brandNames,
//       'last_login': lastLogin,
//       'first_name': firstName,
//       'last_name': lastName,
//       'email': email,
//       'phone_number': phoneNumber,
//       'company_name': companyName,
//       'employees': employees,
//       'dob': dob,
//       'otp': otp,
//       'otp_verified': otpVerified,
//       'is_staff': isStaff,
//       'is_superuser': isSuperuser,
//       'is_active': isActive,
//       'profile_image': profileImage,
//       'customer_name': customerName,
//       'customer_tag': customerTag,
//       'model_no': modelNo,
//       'social_id': socialId,
//       'deactivate': deactivate,
//       'role': role,
//       'customer_type': customerType,
//       'battery_status': batteryStatus,
//       'gps_status': gpsStatus,
//       'longitude': longitude,
//       'latitude': latitude,
//       'companyAddress': companyAddress,
//       'companyCity': companyCity,
//       'companyState': companyState,
//       'companyPincode': companyPincode,
//       'companyCountry': companyCountry,
//       'companyRegion': companyRegion,
//       'companyLandlineNo': companyLandlineNo,
//       'gstNo': gstNo,
//       'cinNo': cinNo,
//       'panNo': panNo,
//       'companyContactNo': companyContactNo,
//       'companyWebsite': companyWebsite,
//       'bankName': bankName,
//       'ifscSwift': ifscSwift,
//       'accountNumber': accountNumber,
//       'branchAddress': branchAddress,
//       'upiId': upiId,
//       'paymentLink': paymentLink,
//       'fileUpload': fileUpload,
//       'primary_address': primaryAddress,
//       'landmark_paci': landmarkPaci,
//       'notes': notes,
//       'state': state,
//       'country': country,
//       'city': city,
//       'zipcode': zipcode,
//       'region': region,
//       'allocated_sick_leave': allocatedSickLeave,
//       'allocated_casual_leave': allocatedCasualLeave,
//       'date_joined': dateJoined,
//       'max_employees_allowed': maxEmployeesAllowed,
//       'employees_created': employeesCreated,
//       'is_leave_allocated': isLeaveAllocated,
//       'emp_id': empId,
//       'is_disabled': isDisabled,
//       'created_at': createdAt,
//       'created_by': createdBy,
//       'admin': admin,
//       'customer_id': customerId,
//       'subscription': subscription,
//     };
//   }
// }
import 'dart:convert';

class TechnicianResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<TechnicianData>? results;

  TechnicianResponseModel({
    this.count,
    this.totalPages,
    this.currentPage,
    this.results,
  });

  factory TechnicianResponseModel.fromJson(Map<String, dynamic> json) =>
      TechnicianResponseModel(
        count: json["count"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        results: json["results"] == null
            ? []
            : List<TechnicianData>.from(
            json["results"]!.map((x) => TechnicianData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "total_pages": totalPages,
    "current_page": currentPage,
    "results": results == null
        ? []
        : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class TechnicianData {
  int? id;
  TodayAttendance? todayAttendance;
  List<dynamic>? brandNames;
  dynamic lastLogin;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? companyName;
  String? employees;
  dynamic dob;
  String? otp;
  bool? otpVerified;
  bool? isStaff;
  bool? isSuperuser;
  bool? isActive;
  dynamic profileImage;
  dynamic customerName;
  dynamic customerTag;
  dynamic modelNo;
  dynamic socialId;
  bool? deactivate;
  String? role;
  dynamic customerType;
  String? batteryStatus;
  dynamic gpsStatus;
  String? longitude;
  String? latitude;
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
  dynamic customerId;
  dynamic subscription;

  TechnicianData({
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

  factory TechnicianData.fromJson(Map<String, dynamic> json) => TechnicianData(
    id: json["id"],
    todayAttendance: json["today_attendance"] == null
        ? null
        : TodayAttendance.fromJson(json["today_attendance"]),
    brandNames: json["brand_names"] == null
        ? []
        : List<dynamic>.from(json["brand_names"]!.map((x) => x)),
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
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    admin: json["admin"],
    customerId: json["customer_id"],
    subscription: json["subscription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "today_attendance": todayAttendance?.toJson(),
    "brand_names": brandNames == null
        ? []
        : List<dynamic>.from(brandNames!.map((x) => x)),
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
    "max_employees_allowed": maxEmployeesAllowed,
    "employees_created": employeesCreated,
    "is_leave_allocated": isLeaveAllocated,
    "emp_id": empId,
    "is_disabled": isDisabled,
    "created_at": createdAt,
    "created_by": createdBy,
    "admin": admin,
    "customer_id": customerId,
    "subscription": subscription,
  };
}

class TodayAttendance {
  int? id;
  int? user;
  dynamic punchIn;
  dynamic punchOut;
  String? status;
  String? date;

  TodayAttendance({
    this.id,
    this.user,
    this.punchIn,
    this.punchOut,
    this.status,
    this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) =>
      TodayAttendance(
        id: json["id"],
        user: json["user"],
        punchIn: json["punch_in"],
        punchOut: json["punch_out"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "punch_in": punchIn,
    "punch_out": punchOut,
    "status": status,
    "date": date,
  };
}
