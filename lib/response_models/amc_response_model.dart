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
// class AmcResponseModel {
//   AmcResponseModel({
//     required this.count,
//     required this.totalPages,
//     required this.currentPage,
//     required this.results,
//   });
//
//   final int? count;
//   final int? totalPages;
//   final int? currentPage;
//   final List<AmcResult> results;
//
//   factory AmcResponseModel.fromJson(Map<String, dynamic> json){
//     return AmcResponseModel(
//       count: json["count"],
//       totalPages: json["total_pages"],
//       currentPage: json["current_page"],
//       results: json["results"] == null ? [] : List<AmcResult>.from(json["results"]!.map((x) => AmcResult.fromJson(x))),
//     );
//   }
//
// }
//
// class AmcResult {
//   AmcResult({
//     required this.id,
//     required this.remainingAmount,
//     required this.serviceCompleted,
//     required this.amcName,
//     required this.activationTime,
//     required this.activationDate,
//     required this.remainder,
//     required this.productBrand,
//     required this.serialModelNo,
//     required this.underWarranty,
//     required this.serviceAmount,
//     required this.receivedAmount,
//     required this.status,
//     required this.selectServiceOccurence,
//     required this.noOfService,
//     required this.note,
//     required this.expiry,
//     required this.createdAt,
//     required this.service,
//     required this.brand,
//     required this.customer,
//     required this.createdBy,
//     required this.admin,
//   });
//
//   final int? id;
//   final int? remainingAmount;
//   final int? serviceCompleted;
//   final String? amcName;
//   final String? activationTime;
//   final DateTime? activationDate;
//   final String? remainder;
//   final String? productBrand;
//   final String? serialModelNo;
//   final bool? underWarranty;
//   final String? serviceAmount;
//   final String? receivedAmount;
//   final String? status;
//   final String? selectServiceOccurence;
//   final String? noOfService;
//   final String? note;
//   final DateTime? expiry;
//   final DateTime? createdAt;
//   final Service? service;
//   final Brand? brand;
//   final Customer? customer;
//   final String? createdBy;
//   final int? admin;
//
//   factory AmcResult.fromJson(Map<String, dynamic> json){
//     return AmcResult(
//       id: json["id"],
//       remainingAmount: json["remainingAmount"],
//       serviceCompleted: json["serviceCompleted"],
//       amcName: json["amcName"],
//       activationTime: json["activationTime"],
//       activationDate: DateTime.tryParse(json["activationDate"] ?? ""),
//       remainder: json["remainder"],
//       productBrand: json["productBrand"],
//       serialModelNo: json["serialModelNo"],
//       underWarranty: json["underWarranty"],
//       serviceAmount: json["serviceAmount"],
//       receivedAmount: json["receivedAmount"],
//       status: json["status"],
//       selectServiceOccurence: json["select_service_occurence"],
//       noOfService: json["no_of_service"],
//       note: json["note"],
//       expiry: DateTime.tryParse(json["expiry"] ?? ""),
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       service: json["service"] == null ? null : Service.fromJson(json["service"]),
//       brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
//       customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
//       createdBy: json["created_by"],
//       admin: json["admin"],
//     );
//   }
//
// }
//
// class Brand {
//   Brand({
//     required this.brand,
//   });
//
//   final BrandClass? brand;
//
//   factory Brand.fromJson(Map<String, dynamic> json){
//     return Brand(
//       brand: json["brand"] == null ? null : BrandClass.fromJson(json["brand"]),
//     );
//   }
//
// }
//
// class BrandClass {
//   BrandClass({
//     required this.id,
//     required this.name,
//   });
//
//   final int? id;
//   final String? name;
//
//   factory BrandClass.fromJson(Map<String, dynamic> json){
//     return BrandClass(
//       id: json["id"],
//       name: json["name"],
//     );
//   }
//
// }
//
// class BrandName {
//   BrandName({
//     required this.brandNames,
//   });
//
//   final List<BrandNameElement> brandNames;
//
//   factory BrandName.fromJson(Map<String, dynamic> json){
//     return BrandName(
//       brandNames: json["brand_names"] == null ? [] : List<BrandNameElement>.from(json["brand_names"]!.map((x) => BrandNameElement.fromJson(x))),
//     );
//   }
//
// }
//
// class BrandNameElement {
//   BrandNameElement({
//     required this.id,
//     required this.name,
//   });
//
//   final int? id;
//   final String? name;
//
//   factory BrandNameElement.fromJson(Map<String, dynamic> json){
//     return BrandNameElement(
//       id: json["id"],
//       name: json["name"],
//     );
//   }
//
// }
//
//
// class Customer {
//   Customer({
//     required this.id,
//     required this.todayAttendance,
//     required this.brandNames,
//     required this.lastLogin,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.companyName,
//     required this.employees,
//     required this.dob,
//     required this.otp,
//     required this.otpVerified,
//     required this.isStaff,
//     required this.isSuperuser,
//     required this.isActive,
//     required this.profileImage,
//     required this.customerName,
//     required this.customerTag,
//     required this.modelNo,
//     required this.socialId,
//     required this.deactivate,
//     required this.role,
//     required this.customerType,
//     required this.batteryStatus,
//     required this.gpsStatus,
//     required this.longitude,
//     required this.latitude,
//     required this.companyAddress,
//     required this.companyCity,
//     required this.companyState,
//     required this.companyPincode,
//     required this.companyCountry,
//     required this.companyRegion,
//     required this.companyLandlineNo,
//     required this.gstNo,
//     required this.cinNo,
//     required this.panNo,
//     required this.companyContactNo,
//     required this.companyWebsite,
//     required this.bankName,
//     required this.ifscSwift,
//     required this.accountNumber,
//     required this.branchAddress,
//     required this.upiId,
//     required this.paymentLink,
//     required this.fileUpload,
//     required this.primaryAddress,
//     required this.landmarkPaci,
//     required this.notes,
//     required this.state,
//     required this.country,
//     required this.city,
//     required this.zipcode,
//     required this.region,
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
//     required this.customerId,
//     required this.subscription,
//     required this.password,
//   });
//
//   final int? id;
//   final List<TodayAttendance> todayAttendance;
//   final List<BrandName> brandNames;
//   final dynamic lastLogin;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phoneNumber;
//   final String? companyName;
//   final String? employees;
//   final dynamic dob;
//   final String? otp;
//   final bool? otpVerified;
//   final bool? isStaff;
//   final bool? isSuperuser;
//   final bool? isActive;
//   final dynamic profileImage;
//   final String? customerName;
//   final String? customerTag;
//   final String? modelNo;
//   final String? socialId;
//   final bool? deactivate;
//   final String? role;
//   final String? customerType;
//   final String? batteryStatus;
//   final bool? gpsStatus;
//   final String? longitude;
//   final String? latitude;
//   final String? companyAddress;
//   final String? companyCity;
//   final String? companyState;
//   final String? companyPincode;
//   final String? companyCountry;
//   final String? companyRegion;
//   final String? companyLandlineNo;
//   final String? gstNo;
//   final String? cinNo;
//   final String? panNo;
//   final String? companyContactNo;
//   final String? companyWebsite;
//   final String? bankName;
//   final String? ifscSwift;
//   final String? accountNumber;
//   final String? branchAddress;
//   final String? upiId;
//   final String? paymentLink;
//   final dynamic fileUpload;
//   final String? primaryAddress;
//   final String? landmarkPaci;
//   final String? notes;
//   final String? state;
//   final String? country;
//   final String? city;
//   final String? zipcode;
//   final String? region;
//   final int? allocatedSickLeave;
//   final int? allocatedCasualLeave;
//   final dynamic dateJoined;
//   final int? maxEmployeesAllowed;
//   final int? employeesCreated;
//   final bool? isLeaveAllocated;
//   final String? empId;
//   final bool? isDisabled;
//   final DateTime? createdAt;
//   final String? createdBy;
//   final int? admin;
//   final dynamic customerId;
//   final dynamic subscription;
//   final String? password;
//
//   factory Customer.fromJson(Map<String, dynamic> json){
//     return Customer(
//       id: json["id"],
//       todayAttendance: json["today_attendance"] == null ? [] : List<TodayAttendance>.from(json["today_attendance"]!.map((x) => TodayAttendance.fromJson(x))),
//       brandNames: json["brand_names"] == null ? [] : List<BrandName>.from(json["brand_names"]!.map((x) => BrandName.fromJson(x))),
//       lastLogin: json["last_login"],
//       firstName: json["first_name"],
//       lastName: json["last_name"],
//       email: json["email"],
//       phoneNumber: json["phone_number"],
//       companyName: json["company_name"],
//       employees: json["employees"],
//       dob: json["dob"],
//       otp: json["otp"],
//       otpVerified: json["otp_verified"],
//       isStaff: json["is_staff"],
//       isSuperuser: json["is_superuser"],
//       isActive: json["is_active"],
//       profileImage: json["profile_image"],
//       customerName: json["customer_name"],
//       customerTag: json["customer_tag"],
//       modelNo: json["model_no"],
//       socialId: json["social_id"],
//       deactivate: json["deactivate"],
//       role: json["role"],
//       customerType: json["customer_type"],
//       batteryStatus: json["battery_status"],
//       gpsStatus: json["gps_status"],
//       longitude: json["longitude"],
//       latitude: json["latitude"],
//       companyAddress: json["companyAddress"],
//       companyCity: json["companyCity"],
//       companyState: json["companyState"],
//       companyPincode: json["companyPincode"],
//       companyCountry: json["companyCountry"],
//       companyRegion: json["companyRegion"],
//       companyLandlineNo: json["companyLandlineNo"],
//       gstNo: json["gstNo"],
//       cinNo: json["cinNo"],
//       panNo: json["panNo"],
//       companyContactNo: json["companyContactNo"],
//       companyWebsite: json["companyWebsite"],
//       bankName: json["bankName"],
//       ifscSwift: json["ifscSwift"],
//       accountNumber: json["accountNumber"],
//       branchAddress: json["branchAddress"],
//       upiId: json["upiId"],
//       paymentLink: json["paymentLink"],
//       fileUpload: json["fileUpload"],
//       primaryAddress: json["primary_address"],
//       landmarkPaci: json["landmark_paci"],
//       notes: json["notes"],
//       state: json["state"],
//       country: json["country"],
//       city: json["city"],
//       zipcode: json["zipcode"],
//       region: json["region"],
//       allocatedSickLeave: json["allocated_sick_leave"],
//       allocatedCasualLeave: json["allocated_casual_leave"],
//       dateJoined: json["date_joined"],
//       maxEmployeesAllowed: json["max_employees_allowed"],
//       employeesCreated: json["employees_created"],
//       isLeaveAllocated: json["is_leave_allocated"],
//       empId: json["emp_id"],
//       isDisabled: json["is_disabled"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       createdBy: json["created_by"],
//       admin: json["admin"],
//       customerId: json["customer_id"],
//       subscription: json["subscription"],
//       password: json["password"],
//     );
//   }
//
// }
//
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
//
// class Service {
//   Service({
//     required this.serviceName,
//     required this.servicePrice,
//     required this.serviceContactNumber,
//     required this.serviceDescription,
//     required this.serviceImage1,
//     required this.serviceImage2,
//     required this.serviceImage3,
//     required this.serviceSubCategory,
//     required this.createdBy,
//     required this.admin,
//     required this.id,
//   });
//
//   final String? serviceName;
//   final String? servicePrice;
//   final String? serviceContactNumber;
//   final String? serviceDescription;
//   final dynamic serviceImage1;
//   final dynamic serviceImage2;
//   final dynamic serviceImage3;
//   final ServiceSubCategory? serviceSubCategory;
//   final int? createdBy;
//   final int? admin;
//   final int? id;
//
//   factory Service.fromJson(Map<String, dynamic> json){
//     return Service(
//       serviceName: json["service_name"],
//       servicePrice: json["service_price"],
//       serviceContactNumber: json["service_contact_number"],
//       serviceDescription: json["service_description"],
//       serviceImage1: json["service_image1"],
//       serviceImage2: json["service_image2"],
//       serviceImage3: json["service_image3"],
//       serviceSubCategory: json["service_sub_category"] == null ? null : ServiceSubCategory.fromJson(json["service_sub_category"]),
//       createdBy: json["created_by"],
//       admin: json["admin"],
//       id: json["id"],
//     );
//   }
//
// }
//
// class ServiceSubCategory {
//   ServiceSubCategory({
//     required this.id,
//     required this.serviceSubCategoryName,
//     required this.serviceSubCatDescription,
//     required this.serviceSubImage,
//     required this.serviceCategory,
//     required this.createdBy,
//     required this.admin,
//   });
//
//   final int? id;
//   final String? serviceSubCategoryName;
//   final String? serviceSubCatDescription;
//   final dynamic serviceSubImage;
//   final ServiceCategory? serviceCategory;
//   final int? createdBy;
//   final int? admin;
//
//   factory ServiceSubCategory.fromJson(Map<String, dynamic> json){
//     return ServiceSubCategory(
//       id: json["id"],
//       serviceSubCategoryName: json["service_sub_category_name"],
//       serviceSubCatDescription: json["service_sub_cat_description"],
//       serviceSubImage: json["service_sub_image"],
//       serviceCategory: json["service_category"] == null ? null : ServiceCategory.fromJson(json["service_category"]),
//       createdBy: json["created_by"],
//       admin: json["admin"],
//     );
//   }
//
// }
//
// class ServiceCategory {
//   ServiceCategory({
//     required this.id,
//     required this.serviceCategoryName,
//     required this.serviceCatDescriptions,
//     required this.serviceCatImage,
//     required this.createdBy,
//     required this.admin,
//   });
//
//   final int? id;
//   final String? serviceCategoryName;
//   final String? serviceCatDescriptions;
//   final dynamic serviceCatImage;
//   final int? createdBy;
//   final int? admin;
//
//   factory ServiceCategory.fromJson(Map<String, dynamic> json){
//     return ServiceCategory(
//       id: json["id"],
//       serviceCategoryName: json["service_category_name"],
//       serviceCatDescriptions: json["service_cat_descriptions"],
//       serviceCatImage: json["service_cat_image"],
//       createdBy: json["created_by"],
//       admin: json["admin"],
//     );
//   }
//
// }
//

//========================================================================================================================

class AmcCountResponseModel {
  AmcCountResponseModel({
    required this.total,
    required this.upcoming,
    required this.renewal,
    required this.completed,
    required this.expired,
  });

  final int? total;
  final int? upcoming;
  final int? renewal;
  final int? completed;
  final int? expired;

  factory AmcCountResponseModel.fromJson(Map<String, dynamic> json){
    return AmcCountResponseModel(
      total: json["total"],
      upcoming: json["upcoming"],
      renewal: json["renewal"],
      completed: json["completed"],
      expired: json["expired"],
    );
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
