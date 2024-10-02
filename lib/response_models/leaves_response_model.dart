class LeaveResponseModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  LeaveResponseModel({this.count, this.next, this.previous, this.results});

  LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  UserId? userId;
  String? startDate;
  String? endDate;
  String? reason;
  String? status;
  String? leaveType;

  Results(
      {this.id,
        this.userId,
        this.startDate,
        this.endDate,
        this.reason,
        this.status,
        this.leaveType});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    status = json['status'];
    leaveType = json['leave_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['leave_type'] = this.leaveType;
    return data;
  }
}

class UserId {
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
  int? createdBy;
  int? admin;
  String? customerId;
  String? subscription;

  UserId(
      {this.id,
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
        this.createdBy,
        this.admin,
        this.customerId,
        this.subscription});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todayAttendance = json['today_attendance'] != null
        ? new TodayAttendance.fromJson(json['today_attendance'])
        : null;
    brandNames = json['brand_names'] != null
        ? List<String>.from(json['brand_names'])
        : null;
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
    maxEmployeesAllowed = json['max_employees_allowed'];
    employeesCreated = json['employees_created'];
    createdBy = json['created_by'];
    admin = json['admin'];
    customerId = json['customer_id'];
    subscription = json['subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.todayAttendance != null) {
      data['today_attendance'] = this.todayAttendance!.toJson();
    }
    if (this.brandNames != null) {
      data['brand_names'] = brandNames;
    }
    data['last_login'] = this.lastLogin;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['company_name'] = this.companyName;
    data['employees'] = this.employees;
    data['dob'] = this.dob;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['is_staff'] = this.isStaff;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['profile_image'] = this.profileImage;
    data['customer_name'] = this.customerName;
    data['customer_tag'] = this.customerTag;
    data['model_no'] = this.modelNo;
    data['social_id'] = this.socialId;
    data['deactivate'] = this.deactivate;
    data['role'] = this.role;
    data['customer_type'] = this.customerType;
    data['battery_status'] = this.batteryStatus;
    data['gps_status'] = this.gpsStatus;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['companyAddress'] = this.companyAddress;
    data['companyCity'] = this.companyCity;
    data['companyState'] = this.companyState;
    data['companyPincode'] = this.companyPincode;
    data['companyCountry'] = this.companyCountry;
    data['companyRegion'] = this.companyRegion;
    data['companyLandlineNo'] = this.companyLandlineNo;
    data['gstNo'] = this.gstNo;
    data['cinNo'] = this.cinNo;
    data['panNo'] = this.panNo;
    data['companyContactNo'] = this.companyContactNo;
    data['companyWebsite'] = this.companyWebsite;
    data['bankName'] = this.bankName;
    data['ifscSwift'] = this.ifscSwift;
    data['accountNumber'] = this.accountNumber;
    data['branchAddress'] = this.branchAddress;
    data['upiId'] = this.upiId;
    data['paymentLink'] = this.paymentLink;
    data['fileUpload'] = this.fileUpload;
    data['primary_address'] = this.primaryAddress;
    data['landmark_paci'] = this.landmarkPaci;
    data['notes'] = this.notes;
    data['state'] = this.state;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['region'] = this.region;
    data['allocated_sick_leave'] = this.allocatedSickLeave;
    data['allocated_casual_leave'] = this.allocatedCasualLeave;
    data['date_joined'] = this.dateJoined;
    data['max_employees_allowed'] = this.maxEmployeesAllowed;
    data['employees_created'] = this.employeesCreated;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    data['customer_id'] = this.customerId;
    data['subscription'] = this.subscription;
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

  TodayAttendance(
      {this.id,
        this.user,
        this.checkIn,
        this.checkOut,
        this.status,
        this.date});

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
