class UserResponseModel {
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
  int? createdBy;
  int? admin;
  String? customerId;

  UserResponseModel({
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
    this.createdBy,
    this.admin,
    this.customerId,
  });

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todayAttendance = json['today_attendance'] != null
        ? TodayAttendance.fromJson(json['today_attendance'])
        : null;
    brandNames = json['brand_names'];
    lastLogin = json['last_login'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    companyName = json['company_name'];
    employees = json['employees'];
    dob = json['dob'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    profileImage = json['profile_image'];
    customerName = json['customer_name'];
    customerTag = json['customer_tag'];
    modelNo = json['model_no'];
    socialId = json['social_id'];
    deactivate = json['deactivate'];
    role = json['role'];
    customerType = json['customer_type'];
    batteryStatus = json['battery_status'];
    gpsStatus = json['gps_status'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    companyAddress = json['companyAddress'];
    companyCity = json['companyCity'];
    companyState = json['companyState'];
    companyPincode = json['companyPincode'];
    companyCountry = json['companyCountry'];
    companyRegion = json['companyRegion'];
    companyLandlineNo = json['companyLandlineNo'];
    gstNo = json['gstNo'];
    cinNo = json['cinNo'];
    panNo = json['panNo'];
    companyContactNo = json['companyContactNo'];
    companyWebsite = json['companyWebsite'];
    bankName = json['bankName'];
    ifscSwift = json['ifscSwift'];
    accountNumber = json['accountNumber'];
    branchAddress = json['branchAddress'];
    upiId = json['upiId'];
    paymentLink = json['paymentLink'];
    fileUpload = json['fileUpload'];
    primaryAddress = json['primary_address'];
    landmarkPaci = json['landmark_paci'];
    notes = json['notes'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    zipcode = json['zipcode'];
    region = json['region'];
    allocatedSickLeave = json['allocated_sick_leave'];
    allocatedCasualLeave = json['allocated_casual_leave'];
    dateJoined = json['date_joined'];
    createdBy = json['created_by'];
    admin = json['admin'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (todayAttendance != null) {
      data['today_attendance'] = todayAttendance!.toJson();
    }
    data['brand_names'] = brandNames;
    data['last_login'] = lastLogin;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['company_name'] = companyName;
    data['employees'] = employees;
    data['dob'] = dob;
    data['otp'] = otp;
    data['otp_verified'] = otpVerified;
    data['is_staff'] = isStaff;
    data['is_superuser'] = isSuperuser;
    data['is_active'] = isActive;
    data['profile_image'] = profileImage;
    data['customer_name'] = customerName;
    data['customer_tag'] = customerTag;
    data['model_no'] = modelNo;
    data['social_id'] = socialId;
    data['deactivate'] = deactivate;
    data['role'] = role;
    data['customer_type'] = customerType;
    data['battery_status'] = batteryStatus;
    data['gps_status'] = gpsStatus;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['companyAddress'] = companyAddress;
    data['companyCity'] = companyCity;
    data['companyState'] = companyState;
    data['companyPincode'] = companyPincode;
    data['companyCountry'] = companyCountry;
    data['companyRegion'] = companyRegion;
    data['companyLandlineNo'] = companyLandlineNo;
    data['gstNo'] = gstNo;
    data['cinNo'] = cinNo;
    data['panNo'] = panNo;
    data['companyContactNo'] = companyContactNo;
    data['companyWebsite'] = companyWebsite;
    data['bankName'] = bankName;
    data['ifscSwift'] = ifscSwift;
    data['accountNumber'] = accountNumber;
    data['branchAddress'] = branchAddress;
    data['upiId'] = upiId;
    data['paymentLink'] = paymentLink;
    data['fileUpload'] = fileUpload;
    data['primary_address'] = primaryAddress;
    data['landmark_paci'] = landmarkPaci;
    data['notes'] = notes;
    data['state'] = state;
    data['country'] = country;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['region'] = region;
    data['allocated_sick_leave'] = allocatedSickLeave;
    data['allocated_casual_leave'] = allocatedCasualLeave;
    data['date_joined'] = dateJoined;
    data['created_by'] = createdBy;
    data['admin'] = admin;
    data['customer_id'] = customerId;
    return data;
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

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['status'] = status;
    data['date'] = date;
    return data;
  }
}
// ============================================================================tmsUserData============
class TMSResponseModel {
  int count;
  int totalPages;
  List<TMSResult> results;

  TMSResponseModel({
    required this.count,
    required this.totalPages,
    required this.results,
  });

  factory TMSResponseModel.fromJson(Map<String, dynamic> json) {
    return TMSResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      results: List<TMSResult>.from(json['results'].map((x) => TMSResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}

class TMSResult {
  int id;
  TodayAttendance todayAttendance;
  List<dynamic> brandNames;
  String? lastLogin;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String companyName;
  String employees;
  String? dob;
  String otp;
  bool otpVerified;
  bool isStaff;
  bool isSuperuser;
  bool isActive;
  String profileImage;
  String? customerName;
  String? customerTag;
  String? modelNo;
  String? socialId;
  bool deactivate;
  String role;
  String? customerType;
  String? batteryStatus;
  bool gpsStatus;
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
  String? fileUpload;
  String primaryAddress;
  String? landmarkPaci;
  String notes;
  String? state;
  String country;
  String? city;
  String? zipcode;
  String? region;
  int allocatedSickLeave;
  int allocatedCasualLeave;
  String? dateJoined;
  int maxEmployeesAllowed;
  int employeesCreated;
  bool isLeaveAllocated;
  String? empId;
  bool isDisabled;
  String createdAt;
  int createdBy;
  int admin;
  String? customerId;
  String? subscription;

  TMSResult({
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
    required this.profileImage,
    this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    required this.deactivate,
    required this.role,
    this.customerType,
    this.batteryStatus,
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

  factory TMSResult.fromJson(Map<String, dynamic> json) {
    return TMSResult(
      id: json['id'],
      todayAttendance: TodayAttendance.fromJson(json['today_attendance']),
      brandNames: List<dynamic>.from(json['brand_names']),
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
    'today_attendance': todayAttendance.toJson(),
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

class TodayAttendance1 {
  int id;
  int user;
  String punchIn;
  String punchOut;
  String status;
  String date;

  TodayAttendance1({
    required this.id,
    required this.user,
    required this.punchIn,
    required this.punchOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance1.fromJson(Map<String, dynamic> json) {
    return TodayAttendance1(
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

