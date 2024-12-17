// To parse this JSON data, do this:
//
//     final amcResponseModel = amcResponseModelFromJson(jsonString);

import 'dart:convert';

class AmcResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<AmcResult> results;

  AmcResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory AmcResponseModel.fromRawJson(String str) =>
      AmcResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AmcResponseModel.fromJson(Map<String, dynamic> json) => AmcResponseModel(
    count: json["count"] ?? 0,
    totalPages: json["total_pages"] ?? 0,
    currentPage: json["current_page"] ?? 0,
    results: json["results"] == null
        ? []
        : List<AmcResult>.from(json["results"].map((x) => AmcResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "total_pages": totalPages,
    "current_page": currentPage,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class AmcResult {
  final int id;
  final double remainingAmount;
  final dynamic serviceCompleted;
  final String? amcName;
  final String? activationTime;
  final String? activationDate;
  final String? remainder;
  final String? productBrand;
  final String? productName;
  final String? serialModelNo;
  final bool underWarranty;
  final String? serviceAmount;
  final String? receivedAmount;
  final String status;
  final String? selectServiceOccurence;
  final String? noOfService;
  final String? note;
  final String? expiry;
  final DateTime? createdAt;
  final Service service;
  final Customer customer;
  final String createdBy;
  final int admin;

  AmcResult({
    required this.id,
    required this.remainingAmount,
    this.serviceCompleted,
    this.amcName,
    this.activationTime,
    this.activationDate,
    this.remainder,
    this.productBrand,
    this.productName,
    this.serialModelNo,
    required this.underWarranty,
    this.serviceAmount,
    this.receivedAmount,
    required this.status,
    this.selectServiceOccurence,
    this.noOfService,
    this.note,
    this.expiry,
    this.createdAt,
    required this.service,
    required this.customer,
    required this.createdBy,
    required this.admin,
  });

  factory AmcResult.fromRawJson(String str) =>
      AmcResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AmcResult.fromJson(Map<String, dynamic> json) => AmcResult(
    id: json["id"] ?? 0,
    remainingAmount: json["remainingAmount"]?.toDouble() ?? 0.0,
    serviceCompleted: json["serviceCompleted"],
    amcName: json["amcName"],
    activationTime: json["activationTime"],
    activationDate: json["activationDate"],
    remainder: json["remainder"],
    productBrand: json["productBrand"],
    productName: json["productName"],
    serialModelNo: json["serialModelNo"],
    underWarranty: json["underWarranty"] ?? false,
    serviceAmount: json["serviceAmount"],
    receivedAmount: json["receivedAmount"],
    status: json["status"] ?? "",
    selectServiceOccurence: json["select_service_occurence"],
    noOfService: json["no_of_service"],
    note: json["note"],
    expiry: json["expiry"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    service: Service.fromJson(json["service"] ?? {}),
    customer: Customer.fromJson(json["customer"] ?? {}),
    createdBy: json["created_by"] ?? "",
    admin: json["admin"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "remainingAmount": remainingAmount,
    "serviceCompleted": serviceCompleted,
    "amcName": amcName,
    "activationTime": activationTime,
    "activationDate": activationDate,
    "remainder": remainder,
    "productBrand": productBrand,
    "productName": productName,
    "serialModelNo": serialModelNo,
    "underWarranty": underWarranty,
    "serviceAmount": serviceAmount,
    "receivedAmount": receivedAmount,
    "status": status,
    "select_service_occurence": selectServiceOccurence,
    "no_of_service": noOfService,
    "note": note,
    "expiry": expiry,
    "created_at": createdAt?.toIso8601String(),
    "service": service.toJson(),
    "customer": customer.toJson(),
    "created_by": createdBy,
    "admin": admin,
  };
}

class Service {
  final String serviceName;
  final dynamic servicePrice;
  final String serviceContactNumber;
  final String serviceDescription;
  final dynamic serviceImage1;
  final dynamic serviceImage2;
  final dynamic serviceImage3;
  final dynamic serviceSubCategory;
  final dynamic createdBy;
  final dynamic admin;

  Service({
    this.serviceName = "",
    this.servicePrice,
    this.serviceContactNumber = "",
    this.serviceDescription = "",
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    this.serviceSubCategory,
    this.createdBy,
    this.admin,
  });

  factory Service.fromRawJson(String str) =>
      Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceName: json["service_name"] ?? "",
    servicePrice: json["service_price"],
    serviceContactNumber: json["service_contact_number"] ?? "",
    serviceDescription: json["service_description"] ?? "",
    serviceImage1: json["service_image1"],
    serviceImage2: json["service_image2"],
    serviceImage3: json["service_image3"],
    serviceSubCategory: json["service_sub_category"],
    createdBy: json["created_by"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "service_price": servicePrice,
    "service_contact_number": serviceContactNumber,
    "service_description": serviceDescription,
    "service_image1": serviceImage1,
    "service_image2": serviceImage2,
    "service_image3": serviceImage3,
    "service_sub_category": serviceSubCategory,
    "created_by": createdBy,
    "admin": admin,
  };
}

class Customer {
  final String password;
  final DateTime? lastLogin;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final DateTime? dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final String customerName;
  final String customerTag;
  final String modelNo;
  final String socialId;
  final dynamic deactivate;
  final dynamic role;
  final String customerType;
  final String batteryStatus;
  final dynamic gpsStatus;
  final String longitude;
  final String latitude;
  final String companyAddress;
  final String companyCity;
  final String companyState;
  final String companyPincode;
  final String companyCountry;
  final String companyRegion;
  final String companyLandlineNo;
  final String gstNo;
  final String cinNo;
  final String panNo;
  final String companyContactNo;
  final String companyWebsite;
  final String bankName;
  final String ifscSwift;
  final String accountNumber;
  final String branchAddress;
  final String upiId;
  final String paymentLink;
  final dynamic fileUpload;
  final String primaryAddress;
  final String landmarkPaci;
  final String notes;
  final String state;
  final String country;
  final String city;
  final String zipcode;
  final String region;
  final dynamic allocatedSickLeave;
  final dynamic allocatedCasualLeave;
  final DateTime? dateJoined;
  final dynamic maxEmployeesAllowed;
  final dynamic employeesCreated;
  final bool isLeaveAllocated;
  final String empId;
  final bool isDisabled;
  final dynamic createdBy;
  final dynamic customerId;
  final dynamic subscription;

  Customer({
    this.password = "",
    this.lastLogin,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.phoneNumber = "",
    this.companyName = "",
    this.employees = "",
    this.dob,
    this.otp = "",
    this.otpVerified = false,
    this.isStaff = false,
    this.isSuperuser = false,
    this.isActive = false,
    this.profileImage,
    this.customerName = "",
    this.customerTag = "",
    this.modelNo = "",
    this.socialId = "",
    this.deactivate,
    this.role,
    this.customerType = "",
    this.batteryStatus = "",
    this.gpsStatus,
    this.longitude = "",
    this.latitude = "",
    this.companyAddress = "",
    this.companyCity = "",
    this.companyState = "",
    this.companyPincode = "",
    this.companyCountry = "",
    this.companyRegion = "",
    this.companyLandlineNo = "",
    this.gstNo = "",
    this.cinNo = "",
    this.panNo = "",
    this.companyContactNo = "",
    this.companyWebsite = "",
    this.bankName = "",
    this.ifscSwift = "",
    this.accountNumber = "",
    this.branchAddress = "",
    this.upiId = "",
    this.paymentLink = "",
    this.fileUpload,
    this.primaryAddress = "",
    this.landmarkPaci = "",
    this.notes = "",
    this.state = "",
    this.country = "",
    this.city = "",
    this.zipcode = "",
    this.region = "",
    this.allocatedSickLeave,
    this.allocatedCasualLeave,
    this.dateJoined,
    this.maxEmployeesAllowed,
    this.employeesCreated,
    this.isLeaveAllocated = false,
    this.empId = "",
    this.isDisabled = false,
    this.createdBy,
    this.customerId,
    this.subscription,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    password: json["password"] ?? "",
    lastLogin: json["last_login"] == null
        ? null
        : DateTime.parse(json["last_login"]),
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    phoneNumber: json["phone_number"] ?? "",
    companyName: json["company_name"] ?? "",
    employees: json["employees"] ?? "",
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    otp: json["otp"] ?? "",
    otpVerified: json["otp_verified"] ?? false,
    isStaff: json["is_staff"] ?? false,
    isSuperuser: json["is_superuser"] ?? false,
    isActive: json["is_active"] ?? false,
    profileImage: json["profile_image"],
    customerName: json["customer_name"] ?? "",
    customerTag: json["customer_tag"] ?? "",
    modelNo: json["model_no"] ?? "",
    socialId: json["social_id"] ?? "",
    deactivate: json["deactivate"],
    role: json["role"],
    customerType: json["customer_type"] ?? "",
    batteryStatus: json["battery_status"] ?? "",
    gpsStatus: json["gps_status"],
    longitude: json["longitude"] ?? "",
    latitude: json["latitude"] ?? "",
    companyAddress: json["companyAddress"] ?? "",
    companyCity: json["companyCity"] ?? "",
    companyState: json["companyState"] ?? "",
    companyPincode: json["companyPincode"] ?? "",
    companyCountry: json["companyCountry"] ?? "",
    companyRegion: json["companyRegion"] ?? "",
    companyLandlineNo: json["companyLandlineNo"] ?? "",
    gstNo: json["gstNo"] ?? "",
    cinNo: json["cinNo"] ?? "",
    panNo: json["panNo"] ?? "",
    companyContactNo: json["companyContactNo"] ?? "",
    companyWebsite: json["companyWebsite"] ?? "",
    bankName: json["bankName"] ?? "",
    ifscSwift: json["ifscSwift"] ?? "",
    accountNumber: json["accountNumber"] ?? "",
    branchAddress: json["branchAddress"] ?? "",
    upiId: json["upiId"] ?? "",
    paymentLink: json["paymentLink"] ?? "",
    fileUpload: json["fileUpload"],
    primaryAddress: json["primary_address"] ?? "",
    landmarkPaci: json["landmark_paci"] ?? "",
    notes: json["notes"] ?? "",
    state: json["state"] ?? "",
    country: json["country"] ?? "",
    city: json["city"] ?? "",
    zipcode: json["zipcode"] ?? "",
    region: json["region"] ?? "",
    allocatedSickLeave: json["allocated_sick_leave"],
    allocatedCasualLeave: json["allocated_casual_leave"],
    dateJoined: json["date_joined"] == null
        ? null
        : DateTime.parse(json["date_joined"]),
    maxEmployeesAllowed: json["max_employees_allowed"],
    employeesCreated: json["employees_created"],
    isLeaveAllocated: json["is_leave_allocated"] ?? false,
    empId: json["emp_id"] ?? "",
    isDisabled: json["is_disabled"] ?? false,
    createdBy: json["created_by"],
    customerId: json["customer_id"],
    subscription: json["subscription"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "last_login": lastLogin?.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "company_name": companyName,
    "employees": employees,
    "dob": dob?.toIso8601String(),
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
    "deactivate": deactivate?.toIso8601String(),
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
    "date_joined": dateJoined?.toIso8601String(),
    "max_employees_allowed": maxEmployeesAllowed,
    "employees_created": employeesCreated,
    "is_leave_allocated": isLeaveAllocated,
    "emp_id": empId,
    "is_disabled": isDisabled,
    "created_by": createdBy,
    "customer_id": customerId,
    "subscription": subscription,
  };
}
//========================================================================================================================
class AmcCountResponseModel {
  final int total;
  final int upcoming;
  final int renewal;
  final int completed;

  AmcCountResponseModel({
    required this.total,
    required this.upcoming,
    required this.renewal,
    required this.completed,
  });

  // Factory method to create an instance from JSON
  factory AmcCountResponseModel.fromJson(Map<String, dynamic> json) {
    return AmcCountResponseModel(
      total: json['total'] ?? 0,
      upcoming: json['upcoming'] ?? 0,
      renewal: json['renewal'] ?? 0,
      completed: json['completed'] ?? 0,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'upcoming': upcoming,
      'renewal': renewal,
      'completed': completed,
    };
  }
}
//===========================================================================delete response model =========================
class AmcDeleteResponseModel {
  String? message;

  AmcDeleteResponseModel({this.message});

  AmcDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
// ======================================history ResPonse model =====================================
class AmcHistoryViewResponseModel {
  AmcHistoryViewResponseModel({
    required this.actionBy,
    required this.changeTimestamp,
    required this.actionMessage,
    required this.fieldChanges,
  });

  final String? actionBy;
  final String? changeTimestamp;
  final String? actionMessage;
  final List<String> fieldChanges;

  factory AmcHistoryViewResponseModel.fromJson(Map<String, dynamic> json){
    return AmcHistoryViewResponseModel(
      actionBy: json["action_by"],
      changeTimestamp: json["change_timestamp"],
      actionMessage: json["action_message"],
      fieldChanges: json["field_changes"] == null ? [] : List<String>.from(json["field_changes"]!.map((x) => x)),
    );
  }
}
