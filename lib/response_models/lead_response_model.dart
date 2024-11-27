import 'dart:convert';

class LeadGetResponseModel {
  int count;
  int totalPages;
  int currentPage;
  List<LeadResult> results;

  LeadGetResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory LeadGetResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadGetResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: (json['results'] as List)
          .map((result) => LeadResult.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((lead) => lead.toJson()).toList(),
    };
  }
}

class LeadResult {
  int id;
  String companyName;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String address;
  String country;
  String state;
  String city;
  String source;
  String notes;
  String status;
  String createdAt;
  dynamic nextInteraction;
  dynamic nextInteractionNotes;
  CreatedBy createdBy;
  int admin;
  NextInteractionUser nextInteractionUser;

  LeadResult({
    required this.id,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.source,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.nextInteraction,
    required this.nextInteractionNotes,
    required this.createdBy,
    required this.admin,
    required this.nextInteractionUser,
  });

  factory LeadResult.fromJson(Map<String, dynamic> json) {
    return LeadResult(
      id: json['id'],
      companyName: json['companyName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      source: json['source'],
      notes: json['notes'],
      status: json['status'],
      createdAt: json['created_at'],
      nextInteraction: json['next_interaction'],
      nextInteractionNotes: json['next_interaction_notes'],
      createdBy: CreatedBy.fromJson(json['created_by']),
      admin: json['admin'],
      nextInteractionUser: NextInteractionUser.fromJson(json['next_interaction_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'source': source,
      'notes': notes,
      'status': status,
      'created_at': createdAt,
      'next_interaction': nextInteraction,
      'next_interaction_notes': nextInteractionNotes,
      'created_by': createdBy.toJson(),
      'admin': admin,
      'next_interaction_user': nextInteractionUser.toJson(),
    };
  }
}

class CreatedBy {
  int id;
  String firstName;
  String lastName;
  String email;

  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

class NextInteractionUser {
  String password;
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
  String customerName;
  String customerTag;
  String modelNo;
  String socialId;
  dynamic deactivate;
  String role;
  String customerType;
  String batteryStatus;
  dynamic gpsStatus;
  String longitude;
  String latitude;
  String companyAddress;
  String companyCity;
  String companyState;
  String companyPincode;
  String companyCountry;
  String companyRegion;
  String companyLandlineNo;
  String gstNo;
  String cinNo;
  String panNo;
  String companyContactNo;
  String companyWebsite;
  String bankName;
  String ifscSwift;
  String accountNumber;
  String branchAddress;
  String upiId;
  String paymentLink;
  dynamic fileUpload;
  String primaryAddress;
  String landmarkPaci;
  String notes;
  String state;
  String country;
  String city;
  String zipcode;
  String region;
  dynamic allocatedSickLeave;
  dynamic allocatedCasualLeave;
  dynamic dateJoined;
  dynamic maxEmployeesAllowed;
  dynamic employeesCreated;
  bool isLeaveAllocated;
  String empId;
  bool isDisabled;
  dynamic createdBy;
  dynamic customerId;
  dynamic subscription;

  NextInteractionUser({
    required this.password,
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
    required this.createdBy,
    required this.customerId,
    required this.subscription,
  });

  factory NextInteractionUser.fromJson(Map<String, dynamic> json) {
    return NextInteractionUser(
      password: json['password'],
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
      primaryAddress: json['primaryAddress'],
      landmarkPaci: json['landmarkPaci'],
      notes: json['notes'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
      zipcode: json['zipcode'],
      region: json['region'],
      allocatedSickLeave: json['allocatedSickLeave'],
      allocatedCasualLeave: json['allocatedCasualLeave'],
      dateJoined: json['dateJoined'],
      maxEmployeesAllowed: json['maxEmployeesAllowed'],
      employeesCreated: json['employeesCreated'],
      isLeaveAllocated: json['isLeaveAllocated'],
      empId: json['empId'],
      isDisabled: json['isDisabled'],
      createdBy: json['createdBy'],
      customerId: json['customerId'],
      subscription: json['subscription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
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
      'primaryAddress': primaryAddress,
      'landmarkPaci': landmarkPaci,
      'notes': notes,
      'state': state,
      'country': country,
      'city': city,
      'zipcode': zipcode,
      'region': region,
      'allocatedSickLeave': allocatedSickLeave,
      'allocatedCasualLeave': allocatedCasualLeave,
      'dateJoined': dateJoined,
      'maxEmployeesAllowed': maxEmployeesAllowed,
      'employeesCreated': employeesCreated,
      'isLeaveAllocated': isLeaveAllocated,
      'empId': empId,
      'isDisabled': isDisabled,
      'createdBy': createdBy,
      'customerId': customerId,
      'subscription': subscription,
    };
  }
}
