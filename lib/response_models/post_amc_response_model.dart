class PostAmcResponseModel {
  final int id;
  final double remainingAmount;
  final int serviceCompleted;
  final String amcName;
  final String activationTime;
  final String activationDate;
  final String remainder;
  final String productBrand;
  final String productName;
  final String serialModelNo;
  final bool underWarranty;
  final String serviceAmount;
  final String receivedAmount;
  final String status;
  final String selectServiceOccurence;
  final String noOfService;
  final String note;
  final String expiry;
  final String createdAt;
  final Service service;
  final Customer customer;
  final int createdBy;
  final int admin;

  PostAmcResponseModel({
    required this.id,
    required this.remainingAmount,
    required this.serviceCompleted,
    required this.amcName,
    required this.activationTime,
    required this.activationDate,
    required this.remainder,
    required this.productBrand,
    required this.productName,
    required this.serialModelNo,
    required this.underWarranty,
    required this.serviceAmount,
    required this.receivedAmount,
    required this.status,
    required this.selectServiceOccurence,
    required this.noOfService,
    required this.note,
    required this.expiry,
    required this.createdAt,
    required this.service,
    required this.customer,
    required this.createdBy,
    required this.admin,
  });

  factory PostAmcResponseModel.fromJson(Map<String, dynamic> json) {
    return PostAmcResponseModel(
      id: json['id'] ?? 0,
      remainingAmount: json['remainingAmount']?.toDouble() ?? 0.0,
      serviceCompleted: json['serviceCompleted'] ?? 0,
      amcName: json['amcName'] ?? '',
      activationTime: json['activationTime'] ?? '',
      activationDate: json['activationDate'] ?? '',
      remainder: json['remainder'] ?? '',
      productBrand: json['productBrand'] ?? '',
      productName: json['productName'] ?? '',
      serialModelNo: json['serialModelNo'] ?? '',
      underWarranty: json['underWarranty'] ?? false,
      serviceAmount: json['serviceAmount'] ?? '',
      receivedAmount: json['receivedAmount'] ?? '',
      status: json['status'] ?? '',
      selectServiceOccurence: json['select_service_occurence'] ?? '',
      noOfService: json['no_of_service'] ?? '',
      note: json['note'] ?? '',
      expiry: json['expiry'] ?? '',
      createdAt: json['created_at'] ?? '',
      service: Service.fromJson(json['service'] ?? {}),
      customer: Customer.fromJson(json['customer'] ?? {}),
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'remainingAmount': remainingAmount,
      'serviceCompleted': serviceCompleted,
      'amcName': amcName,
      'activationTime': activationTime,
      'activationDate': activationDate,
      'remainder': remainder,
      'productBrand': productBrand,
      'productName': productName,
      'serialModelNo': serialModelNo,
      'underWarranty': underWarranty,
      'serviceAmount': serviceAmount,
      'receivedAmount': receivedAmount,
      'status': status,
      'select_service_occurence': selectServiceOccurence,
      'no_of_service': noOfService,
      'note': note,
      'expiry': expiry,
      'created_at': createdAt,
      'service': service.toJson(),
      'customer': customer.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class Service {
  final String serviceName;
  final double? servicePrice;
  final String serviceContactNumber;
  final String serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final String? serviceImage3;
  final String? serviceSubCategory;
  final int? createdBy;
  final int? admin;

  Service({
    required this.serviceName,
    this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    this.serviceSubCategory,
    this.createdBy,
    this.admin,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'] ?? '',
      servicePrice: json['service_price']?.toDouble(),
      serviceContactNumber: json['service_contact_number'] ?? '',
      serviceDescription: json['service_description'] ?? '',
      serviceImage1: json['service_image1'],
      serviceImage2: json['service_image2'],
      serviceImage3: json['service_image3'],
      serviceSubCategory: json['service_sub_category'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_name': serviceName,
      'service_price': servicePrice,
      'service_contact_number': serviceContactNumber,
      'service_description': serviceDescription,
      'service_image1': serviceImage1,
      'service_image2': serviceImage2,
      'service_image3': serviceImage3,
      'service_sub_category': serviceSubCategory,
      'created_by': createdBy,
      'admin': admin,
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

class Customer {
  final int id;
  final TodayAttendance todayAttendance;
  final List<String> brandNames;
  final String? lastName;
  final String? firstName;
  final String? lastLogin;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final String? dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final String? profileImage;
  final String customerName;
  final String? customerTag;
  final String modelNo;
  final String? socialId;
  final bool deactivate;
  final String role;
  final String customerType;
  final String? batteryStatus;
  final bool gpsStatus;
  final double? longitude;
  final double? latitude;
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
  final String? fileUpload;
  final String primaryAddress;
  final String landmarkPaci;
  final String? notes;
  final String state;
  final String country;
  final String city;
  final String zipcode;
  final String region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final String? dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final String? empId;
  final bool isDisabled;
  final String createdAt;
  final int createdBy;
  final int admin;
  final String? customerId;
  final String? subscription;

  Customer({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    this.lastName,
    this.firstName,
    this.lastLogin,
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
    required this.customerName,
    this.customerTag,
    required this.modelNo,
    this.socialId,
    required this.deactivate,
    required this.role,
    required this.customerType,
    this.batteryStatus,
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
    required this.primaryAddress,
    required this.landmarkPaci,
    this.notes,
    required this.state,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.region,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    this.dateJoined,
    required this.maxEmployeesAllowed,
    required this.employeesCreated,
    required this.isLeaveAllocated,
    this.empId,
    required this.isDisabled,
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    this.customerId,
    this.subscription,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      todayAttendance: TodayAttendance.fromJson(json['today_attendance'] ?? {}),
      brandNames: List<String>.from(json['brand_names'] ?? []),
      lastName: json['last_name'],
      firstName: json['first_name'],
      lastLogin: json['last_login'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'] ?? '',
      employees: json['employees'] ?? '',
      dob: json['dob'],
      otp: json['otp'] ?? '',
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'] ?? '',
      customerTag: json['customer_tag'],
      modelNo: json['model_no'] ?? '',
      socialId: json['social_id'],
      deactivate: json['deactivate'] ?? false,
      role: json['role'] ?? '',
      customerType: json['customer_type'] ?? '',
      batteryStatus: json['battery_status'],
      gpsStatus: json['gps_status'] ?? false,
      longitude: json['longitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
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
      primaryAddress: json['primary_address'] ?? '',
      landmarkPaci: json['landmark_paci'] ?? '',
      notes: json['notes'],
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      region: json['region'] ?? '',
      allocatedSickLeave: json['allocated_sick_leave'] ?? 0,
      allocatedCasualLeave: json['allocated_casual_leave'] ?? 0,
      dateJoined: json['date_joined'],
      maxEmployeesAllowed: json['max_employees_allowed'] ?? 0,
      employeesCreated: json['employees_created'] ?? 0,
      isLeaveAllocated: json['is_leave_allocated'] ?? false,
      empId: json['emp_id'],
      isDisabled: json['is_disabled'] ?? false,
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
      customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'today_attendance': todayAttendance.toJson(),
    'brand_names': brandNames,
    'last_name': lastName,
    'first_name': firstName,
    'last_login': lastLogin,
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