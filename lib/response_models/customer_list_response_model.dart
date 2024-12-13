class CustomerListResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<CustomerData> results;

  CustomerListResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory CustomerListResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerListResponseModel(
      count: json['count'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
          ?.map((result) => CustomerData.fromJson(result))
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

class CustomerData {
  final int id;
  final List<TodayAttendanceModel> todayAttendance;
  final List<String> brandNames;
  final String? lastLogin;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String phoneNumber;
  final String? companyName;
  final String? employees;
  final String? dob;
  final String? otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final String? profileImage;
  final String customerName;
  final String? customerTag;
  final String? modelNo;
  final String? socialId;
  final bool deactivate;
  final String role;
  final String? customerType;
  final String? batteryStatus;
  final bool gpsStatus;
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
  final String? fileUpload;
  final String primaryAddress;
  final String? landmarkPaci;
  final String? notes;
  final String state;
  final String country;
  final String city;
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
  final String? subscription;

  CustomerData({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    this.lastLogin,
    this.firstName,
    this.lastName,
    this.email,
    required this.phoneNumber,
    this.companyName,
    this.employees,
    this.dob,
    this.otp,
    required this.otpVerified,
    required this.isStaff,
    required this.isSuperuser,
    required this.isActive,
    this.profileImage,
    required this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    required this.deactivate,
    required this.role,
    this.customerType,
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
    this.landmarkPaci,
    this.notes,
    required this.state,
    required this.country,
    required this.city,
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

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] ?? 0,
      todayAttendance: (json['today_attendance'] as List<dynamic>?)
          ?.map((attendance) => TodayAttendanceModel.fromJson(attendance))
          .toList() ?? [],
      brandNames: (json['brand_names'] as List<dynamic>?)
          ?.map((brand) => brand.toString())
          .toList() ?? [],
      lastLogin: json['last_login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'],
      employees: json['employees'],
      dob: json['dob'],
      otp: json['otp'],
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'] ?? '',
      customerTag: json['customer_tag'],
      modelNo: json['model_no'],
      socialId: json['social_id'],
      deactivate: json['deactivate'] ?? false,
      role: json['role'] ?? '',
      customerType: json['customer_type'],
      batteryStatus: json['battery_status'],
      gpsStatus: json['gps_status'] ?? false,
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
      primaryAddress: json['primary_address'] ?? '',
      landmarkPaci: json['landmark_paci'],
      notes: json['notes'],
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
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
      'today_attendance': todayAttendance.map((attendance) => attendance.toJson()).toList(),
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

class TodayAttendanceModel {
  final int id;
  final int user;
  final String? punchIn;
  final String? punchOut;
  final String status;
  final String date;

  TodayAttendanceModel({
    required this.id,
    required this.user,
    this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TodayAttendanceModel(
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

//=============================================================================Customer List Response Model ========================================
class PostCustomerListResponseModel {
  final int? id;
  final dynamic todayAttendance;
  final List<String>? brandNames;
  final dynamic lastLogin;
  final dynamic firstName;
  final dynamic lastName;
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
  final dynamic profileImage;
  final String? customerName;
  final dynamic customerTag;
  final String? modelNo;
  final dynamic socialId;
  final bool? deactivate;
  final String? role;
  final String? customerType;
  final dynamic batteryStatus;
  final bool? gpsStatus;
  final dynamic longitude;
  final dynamic latitude;
  final dynamic companyAddress;
  final dynamic companyCity;
  final dynamic companyState;
  final dynamic companyPincode;
  final dynamic companyCountry;
  final dynamic companyRegion;
  final dynamic companyLandlineNo;
  final dynamic gstNo;
  final dynamic cinNo;
  final dynamic panNo;
  final dynamic companyContactNo;
  final dynamic companyWebsite;
  final dynamic bankName;
  final dynamic ifscSwift;
  final dynamic accountNumber;
  final dynamic branchAddress;
  final dynamic upiId;
  final dynamic paymentLink;
  final dynamic fileUpload;
  final String? primaryAddress;
  final String? landmarkPaci;
  final dynamic notes;
  final String? state;
  final String? country;
  final String? city;
  final String? zipcode;
  final String? region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final dynamic dateJoined;
  final int? maxEmployeesAllowed;
  final int? employeesCreated;
  final bool? isLeaveAllocated;
  final dynamic empId;
  final bool? isDisabled;
  final String? createdAt;
  final String? createdBy;
  final int? admin;
  final dynamic customerId;
  final dynamic subscription;

  PostCustomerListResponseModel({
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

  factory PostCustomerListResponseModel.fromJson(Map<String, dynamic> json) {
    return PostCustomerListResponseModel(
      id: json['id'],
      todayAttendance: json['today_attendance'],
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
      'today_attendance': todayAttendance,
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
