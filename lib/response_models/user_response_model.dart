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