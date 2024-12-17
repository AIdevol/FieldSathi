class AmcDataCustomerWiseResponseModel {
  int? count;
  int? totalPages;
  int? currentPage;
  List<AmcDataCustomerWiseResult>? results;

  AmcDataCustomerWiseResponseModel(
      {this.count, this.totalPages, this.currentPage, this.results});

  AmcDataCustomerWiseResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    if (json['results'] != null) {
      results = <AmcDataCustomerWiseResult>[];
      json['results'].forEach((v) {
        results!.add(new AmcDataCustomerWiseResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AmcDataCustomerWiseResult {
  int? id;
  int? remainingAmount;
  Null? serviceCompleted;
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
  String? selectServiceOccurence;
  String? noOfService;
  String? note;
  String? expiry;
  String? createdAt;
  Service1? service;
  Customer? customer;
  String? createdBy;
  int? admin;

  AmcDataCustomerWiseResult(
      {this.id,
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
        this.selectServiceOccurence,
        this.noOfService,
        this.note,
        this.expiry,
        this.createdAt,
        this.service,
        this.customer,
        this.createdBy,
        this.admin});

  AmcDataCustomerWiseResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remainingAmount = json['remainingAmount'];
    serviceCompleted = json['serviceCompleted'];
    amcName = json['amcName'];
    activationTime = json['activationTime'];
    activationDate = json['activationDate'];
    remainder = json['remainder'];
    productBrand = json['productBrand'];
    productName = json['productName'];
    serialModelNo = json['serialModelNo'];
    underWarranty = json['underWarranty'];
    serviceAmount = json['serviceAmount'];
    receivedAmount = json['receivedAmount'];
    status = json['status'];
    selectServiceOccurence = json['select_service_occurence'];
    noOfService = json['no_of_service'];
    note = json['note'];
    expiry = json['expiry'];
    createdAt = json['created_at'];
    service =
    json['service'] != null ? new Service1.fromJson(json['service']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['remainingAmount'] = this.remainingAmount;
    data['serviceCompleted'] = this.serviceCompleted;
    data['amcName'] = this.amcName;
    data['activationTime'] = this.activationTime;
    data['activationDate'] = this.activationDate;
    data['remainder'] = this.remainder;
    data['productBrand'] = this.productBrand;
    data['productName'] = this.productName;
    data['serialModelNo'] = this.serialModelNo;
    data['underWarranty'] = this.underWarranty;
    data['serviceAmount'] = this.serviceAmount;
    data['receivedAmount'] = this.receivedAmount;
    data['status'] = this.status;
    data['select_service_occurence'] = this.selectServiceOccurence;
    data['no_of_service'] = this.noOfService;
    data['note'] = this.note;
    data['expiry'] = this.expiry;
    data['created_at'] = this.createdAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class Service1 {
  String? serviceName;
  Null? servicePrice;
  String? serviceContactNumber;
  String? serviceDescription;
  Null? serviceImage1;
  Null? serviceImage2;
  Null? serviceImage3;
  Null? serviceSubCategory;
  Null? createdBy;
  Null? admin;

  Service1(
      {this.serviceName,
        this.servicePrice,
        this.serviceContactNumber,
        this.serviceDescription,
        this.serviceImage1,
        this.serviceImage2,
        this.serviceImage3,
        this.serviceSubCategory,
        this.createdBy,
        this.admin});

  Service1.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceContactNumber = json['service_contact_number'];
    serviceDescription = json['service_description'];
    serviceImage1 = json['service_image1'];
    serviceImage2 = json['service_image2'];
    serviceImage3 = json['service_image3'];
    serviceSubCategory = json['service_sub_category'];
    createdBy = json['created_by'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_contact_number'] = this.serviceContactNumber;
    data['service_description'] = this.serviceDescription;
    data['service_image1'] = this.serviceImage1;
    data['service_image2'] = this.serviceImage2;
    data['service_image3'] = this.serviceImage3;
    data['service_sub_category'] = this.serviceSubCategory;
    data['created_by'] = this.createdBy;
    data['admin'] = this.admin;
    return data;
  }
}

class Customer {
  int? id;
  List<TodayAttendance>? todayAttendance;
  List<String>? brandNames;
  Null? lastLogin;
  Null? firstName;
  Null? lastName;
  String? email;
  String? phoneNumber;
  String? companyName;
  String? employees;
  Null? dob;
  String? otp;
  bool? otpVerified;
  bool? isStaff;
  bool? isSuperuser;
  bool? isActive;
  Null? profileImage;
  String? customerName;
  Null? customerTag;
  String? modelNo;
  Null? socialId;
  bool? deactivate;
  String? role;
  String? customerType;
  Null? batteryStatus;
  bool? gpsStatus;
  Null? longitude;
  Null? latitude;
  Null? companyAddress;
  Null? companyCity;
  Null? companyState;
  Null? companyPincode;
  Null? companyCountry;
  Null? companyRegion;
  Null? companyLandlineNo;
  Null? gstNo;
  Null? cinNo;
  Null? panNo;
  Null? companyContactNo;
  Null? companyWebsite;
  Null? bankName;
  Null? ifscSwift;
  Null? accountNumber;
  Null? branchAddress;
  Null? upiId;
  Null? paymentLink;
  Null? fileUpload;
  String? primaryAddress;
  String? landmarkPaci;
  Null? notes;
  String? state;
  String? country;
  String? city;
  String? zipcode;
  String? region;
  int? allocatedSickLeave;
  int? allocatedCasualLeave;
  Null? dateJoined;
  int? maxEmployeesAllowed;
  int? employeesCreated;
  bool? isLeaveAllocated;
  Null? empId;
  bool? isDisabled;
  String? createdAt;
  String? createdBy;
  int? admin;
  Null? customerId;
  Null? subscription;

  Customer(
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
        this.isLeaveAllocated,
        this.empId,
        this.isDisabled,
        this.createdAt,
        this.createdBy,
        this.admin,
        this.customerId,
        this.subscription});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['today_attendance'] != null) {
      todayAttendance = <TodayAttendance>[];
      json['today_attendance'].forEach((v) {
        todayAttendance!.add(new TodayAttendance.fromJson(v));
      });
    }
    brandNames = json['brand_names'].cast<String>();
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
    isLeaveAllocated = json['is_leave_allocated'];
    empId = json['emp_id'];
    isDisabled = json['is_disabled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    admin = json['admin'];
    customerId = json['customer_id'];
    subscription = json['subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.todayAttendance != null) {
      data['today_attendance'] =
          this.todayAttendance!.map((v) => v.toJson()).toList();
    }
    data['brand_names'] = this.brandNames;
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
    data['is_leave_allocated'] = this.isLeaveAllocated;
    data['emp_id'] = this.empId;
    data['is_disabled'] = this.isDisabled;
    data['created_at'] = this.createdAt;
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
  Null? punchIn;
  Null? punchOut;
  String? status;
  String? date;

  TodayAttendance({this.id,
    this.user,
    this.punchIn,
    this.punchOut,
    this.status,
    this.date});

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    punchIn = json['punch_in'];
    punchOut = json['punch_out'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['punch_in'] = this.punchIn;
    data['punch_out'] = this.punchOut;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}