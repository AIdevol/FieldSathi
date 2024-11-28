class LeadGetResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<LeadResult> results;

  LeadGetResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory LeadGetResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadGetResponseModel(
      count: json['count'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
          ?.map((result) => LeadResult.fromJson(result))
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

class LeadResult {
  final int id;
  final String companyName;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String address;
  final String country;
  final String state;
  final String city;
  final String source;
  final String notes;
  final String status;
  final String createdAt;
  final String? nextInteraction;
  final String? nextInteractionNotes;
  final CreatedBy createdBy;
  final int admin;
  final NextInteractionUser nextInteractionUser;

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
    this.nextInteraction,
    this.nextInteractionNotes,
    required this.createdBy,
    required this.admin,
    required this.nextInteractionUser,
  });

  factory LeadResult.fromJson(Map<String, dynamic> json) {
    return LeadResult(
      id: json['id'] ?? 0,
      companyName: json['companyName'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      source: json['source'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      nextInteraction: json['next_interaction'],
      nextInteractionNotes: json['next_interaction_notes'],
      createdBy: CreatedBy.fromJson(json['created_by'] ?? {}),
      admin: json['admin'] ?? 0,
      nextInteractionUser: NextInteractionUser.fromJson(json['next_interaction_user'] ?? {}),
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
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
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
  final int? id;
  final TodayAttendance? todayAttendance;
  final List<dynamic> brandNames;
  final String? lastLogin;
  final String firstName;
  final String lastName;
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
  final String? customerName;
  final String? customerTag;
  final String? modelNo;
  final String? socialId;
  final bool deactivate;
  final String role;
  final String? customerType;
  final String batteryStatus;
  final bool? gpsStatus;
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
  final String? landmarkPaci;
  final String notes;
  final String? state;
  final String country;
  final String? city;
  final String? zipcode;
  final String? region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final String? dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final String? empId;
  final bool isDisabled;
  final String createdAt;
  final String createdBy;
  final int admin;
  final String? customerId;
  final dynamic subscription;

  NextInteractionUser({
    this.id,
    this.todayAttendance,
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
    this.gpsStatus,
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
    this.fileUpload,
    required this.primaryAddress,
    this.landmarkPaci,
    required this.notes,
    this.state,
    required this.country,
    this.city,
    this.zipcode,
    this.region,
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

  factory NextInteractionUser.fromJson(Map<String, dynamic> json) {
    return NextInteractionUser(
      id: json['id'],
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'])
          : null,
      brandNames: json['brand_names'] ?? [],
      lastLogin: json['last_login'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
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
      customerName: json['customer_name'],
      customerTag: json['customer_tag'],
      modelNo: json['model_no'],
      socialId: json['social_id'],
      deactivate: json['deactivate'] ?? false,
      role: json['role'] ?? '',
      customerType: json['customer_type'],
      batteryStatus: json['battery_status'] ?? '',
      gpsStatus: json['gps_status'],
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      companyAddress: json['companyAddress'] ?? '',
      companyCity: json['companyCity'] ?? '',
      companyState: json['companyState'] ?? '',
      companyPincode: json['companyPincode'] ?? '',
      companyCountry: json['companyCountry'] ?? '',
      companyRegion: json['companyRegion'] ?? '',
      companyLandlineNo: json['companyLandlineNo'] ?? '',
      gstNo: json['gstNo'] ?? '',
      cinNo: json['cinNo'] ?? '',
      panNo: json['panNo'] ?? '',
      companyContactNo: json['companyContactNo'] ?? '',
      companyWebsite: json['companyWebsite'] ?? '',
      bankName: json['bankName'] ?? '',
      ifscSwift: json['ifscSwift'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      branchAddress: json['branchAddress'] ?? '',
      upiId: json['upiId'] ?? '',
      paymentLink: json['paymentLink'] ?? '',
      fileUpload: json['fileUpload'],
      primaryAddress: json['primary_address'] ?? '',
      landmarkPaci: json['landmark_paci'],
      notes: json['notes'] ?? '',
      state: json['state'],
      country: json['country'] ?? '',
      city: json['city'],
      zipcode: json['zipcode'],
      region: json['region'],
      allocatedSickLeave: json['allocated_sick_leave'] ?? 0,
      allocatedCasualLeave: json['allocated_casual_leave'] ?? 0,
      dateJoined: json['date_joined'],
      maxEmployeesAllowed: json['max_employees_allowed'] ?? 0,
      employeesCreated: json['employees_created'] ?? 0,
      isLeaveAllocated: json['is_leave_allocated'] ?? false,
      empId: json['emp_id'],
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
  final int? id;
  final int? user;
  final String? punchIn;
  final String? punchOut;
  final String status;
  final String date;

  TodayAttendance({
    this.id,
    this.user,
    this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'],
      user: json['user'],
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