class CustomerListResponseModel {
  int count;
  int totalPages;
  int currentPage;
  List<CustomerData> results;

  CustomerListResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory CustomerListResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerListResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<CustomerData>.from(
          json['results'].map((x) => CustomerData.fromJson(x))),
    );
  }
}

class CustomerData {
  int id;
  TodayAttendance? todayAttendance;
  List<dynamic> brandNames;
  String? lastLogin;
  String? firstName;
  String? lastName;
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
  String? profileImage;
  String customerName;
  String? customerTag;
  String? modelNo;
  String? socialId;
  bool deactivate;
  String role;
  String? customerType;
  String? batteryStatus;
  bool gpsStatus;
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
  String state;
  String country;
  String city;
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
  String createdBy;
  int admin;
  String? customerId;
  String? subscription;

  CustomerData({
    required this.id,
    this.todayAttendance,
    required this.brandNames,
    this.lastLogin,
    this.firstName,
    this.lastName,
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
    this.primaryAddress,
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
      id: json['id'],
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'])
          : null,
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
}

class TodayAttendance {
  int id;
  int user;
  String? punchIn;
  String? punchOut;
  String status;
  String date;

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
      id: json['id'],
      user: json['user'],
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
      status: json['status'],
      date: json['date'],
    );
  }
}
