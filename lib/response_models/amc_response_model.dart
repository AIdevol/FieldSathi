class AmcResponseModel {
  int? id;
  double? remainingAmount;
  int? serviceCompleted;
  String? amcName;
  String? activationTime;
  String? activationDate;
  String? remainder;
  String? productBrand;
  String? productName;
  String? serialModelNo;
  bool? underWarranty;
  String? serviceAmount;
  String? receivedAmount;
  String? status;
  String? selectServiceOccurrence;
  String? noOfService;
  String? note;
  String? expiry;
  Service? service;
  Customer? customer;
  int? createdBy;
  int? admin;

  AmcResponseModel({
    this.id,
    this.remainingAmount,
    this.serviceCompleted,
    this.amcName,
    this.activationTime,
    this.activationDate,
    this.remainder,
    this.productBrand,
    this.productName,
    this.serialModelNo,
    this.underWarranty,
    this.serviceAmount,
    this.receivedAmount,
    this.status,
    this.selectServiceOccurrence,
    this.noOfService,
    this.note,
    this.expiry,
    this.service,
    this.customer,
    this.createdBy,
    this.admin,
  });

  factory AmcResponseModel.fromJson(Map<String, dynamic> json) {
    return AmcResponseModel(
      id: json['id'],
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble(),
      serviceCompleted: json['serviceCompleted'],
      amcName: json['amcName'],
      activationTime: json['activationTime'],
      activationDate: json['activationDate'],
      remainder: json['remainder'],
      productBrand: json['productBrand'],
      productName: json['productName'],
      serialModelNo: json['serialModelNo'],
      underWarranty: json['underWarranty'],
      serviceAmount: json['serviceAmount'],
      receivedAmount: json['receivedAmount'],
      status: json['status'],
      selectServiceOccurrence: json['select_service_occurence'],
      noOfService: json['no_of_service'],
      note: json['note'],
      expiry: json['expiry'],
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      createdBy: json['created_by'],
      admin: json['admin'],
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
      'select_service_occurence': selectServiceOccurrence,
      'no_of_service': noOfService,
      'note': note,
      'expiry': expiry,
      'service': service?.toJson(),
      'customer': customer?.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class Service {
  String? serviceName;
  String? servicePrice;
  String? serviceContactNumber;
  String? serviceDescription;
  String? serviceImage1;
  String? serviceImage2;
  String? serviceImage3;
  String? serviceSubCategory;
  int? createdBy;
  int? admin;

  Service({
    this.serviceName,
    this.servicePrice,
    this.serviceContactNumber,
    this.serviceDescription,
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    this.serviceSubCategory,
    this.createdBy,
    this.admin,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'],
      servicePrice: json['service_price'],
      serviceContactNumber: json['service_contact_number'],
      serviceDescription: json['service_description'],
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

class Customer {
  int? id;
  TodayAttendance? todayAttendance;
  List<String>? brandNames;
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
  int? createdBy;
  int? admin;
  String? customerId;
  String? subscription;

  Customer({
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
    this.createdBy,
    this.admin,
    this.customerId,
    this.subscription,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'])
          : null,
      brandNames: List<String>.from(json['brand_names'] ?? []),
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
  String? checkIn;
  String? checkOut;
  String? status;
  String? date;

  TodayAttendance({
    this.id,
    this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'],
      user: json['user'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'check_in': checkIn,
      'check_out': checkOut,
      'status': status,
      'date': date,
    };
  }
}
