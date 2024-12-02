class LeadStatusResponseModel {
  final int inDiscussion;
  final int serviceTaken;
  final int interact;
  final int inactive;
  final int quoteSent;
  final int notInterested;

  LeadStatusResponseModel({
    required this.inDiscussion,
    required this.serviceTaken,
    required this.interact,
    required this.inactive,
    required this.quoteSent,
    required this.notInterested,
  });

  factory LeadStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadStatusResponseModel(
      inDiscussion: json['In-Discussion'] ?? 0,
      serviceTaken: json['Service Taken'] ?? 0,
      interact: json['Interact'] ?? 0,
      inactive: json['Inactive'] ?? 0,
      quoteSent: json['Quote Sent'] ?? 0,
      notInterested: json['Not Interested'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'In-Discussion': inDiscussion,
      'Service Taken': serviceTaken,
      'Interact': interact,
      'Inactive': inactive,
      'Quote Sent': quoteSent,
      'Not Interested': notInterested,
    };
  }
}
//================================================================================================
class PostLeadListResponeModel {
  int? id;
  String? companyName;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? country;
  String? state;
  String? city;
  String? source;
  String? notes;
  String? status;
  String? createdAt;
  Null? nextInteraction;
  Null? nextInteractionNotes;
  CreatedBy? createdBy;
  int? admin;
  NextInteractionUser? nextInteractionUser;

  PostLeadListResponeModel(
      {this.id,
        this.companyName,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.address,
        this.country,
        this.state,
        this.city,
        this.source,
        this.notes,
        this.status,
        this.createdAt,
        this.nextInteraction,
        this.nextInteractionNotes,
        this.createdBy,
        this.admin,
        this.nextInteractionUser});

  PostLeadListResponeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    source = json['source'];
    notes = json['notes'];
    status = json['status'];
    createdAt = json['created_at'];
    nextInteraction = json['next_interaction'];
    nextInteractionNotes = json['next_interaction_notes'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    admin = json['admin'];
    nextInteractionUser = json['next_interaction_user'] != null
        ? new NextInteractionUser.fromJson(json['next_interaction_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['source'] = this.source;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['next_interaction'] = this.nextInteraction;
    data['next_interaction_notes'] = this.nextInteractionNotes;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    data['admin'] = this.admin;
    if (this.nextInteractionUser != null) {
      data['next_interaction_user'] = this.nextInteractionUser!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? email;

  CreatedBy({this.id, this.firstName, this.lastName, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}

class NextInteractionUser {
  String? password;
  Null? lastLogin;
  String? firstName;
  String? lastName;
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
  String? customerTag;
  String? modelNo;
  String? socialId;
  Null? deactivate;
  Null? role;
  String? customerType;
  String? batteryStatus;
  Null? gpsStatus;
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
  Null? fileUpload;
  String? primaryAddress;
  String? landmarkPaci;
  String? notes;
  String? state;
  String? country;
  String? city;
  String? zipcode;
  String? region;
  Null? allocatedSickLeave;
  Null? allocatedCasualLeave;
  Null? dateJoined;
  Null? maxEmployeesAllowed;
  Null? employeesCreated;
  bool? isLeaveAllocated;
  String? empId;
  bool? isDisabled;
  Null? createdBy;
  Null? customerId;
  Null? subscription;

  NextInteractionUser(
      {this.password,
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
        this.createdBy,
        this.customerId,
        this.subscription});

  NextInteractionUser.fromJson(Map<String, dynamic> json) {
    password = json['password'];
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
    createdBy = json['created_by'];
    customerId = json['customer_id'];
    subscription = json['subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
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
    data['created_by'] = this.createdBy;
    data['customer_id'] = this.customerId;
    data['subscription'] = this.subscription;
    return data;
  }
}
