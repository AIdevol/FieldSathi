// Task class
class TicketResponseModel {
  final int id;
  final String taskName;
  final String date;
  final String time;
  final bool israte;
  final bool isamc;
  final User assignTo;
  final User customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String totalTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int admin;
  final String createdBy;
  final double? rate;
  final String instructions;
  final String status;
  final String? rejectedNote;
  final String? onholdNote;
  final String? beforeNote;
  final String? afterNote;
  final String? beforeTaskImages1;
  final String? beforeTaskImages2;
  final String? beforeTaskImages3;
  final String? afterTaskImages1;
  final String? afterTaskImages2;
  final String? afterTaskImages3;
  final String? custName;
  final String? custNumber;
  final double? custRating;
  final String? technicalNote;
  final String? workmode;
  final String? custSignature;
  final String? technicianSignature;
  final String? technicianName;
  final String? technicianNumber;
  final String brand;
  final String model;
  final String? purpose;
  final String? acceptedNote;
  final Address ticketAddress;
  final FsrDetails fsrDetails;
  final ServiceDetails serviceDetails;
  final SubCustomerDetails subCustomerDetails;
  final List<dynamic> checkpoints;
  final int? aging;

  TicketResponseModel({
    required this.id,
    required this.taskName,
    required this.date,
    required this.time,
    required this.israte,
    required this.isamc,
    required this.assignTo,
    required this.customerDetails,
    required this.technicalNotes,
    required this.devices,
    required this.totalTime,
    this.startDateTime,
    this.endDateTime,
    required this.ticketCheckpoints,
    required this.admin,
    required this.createdBy,
    this.rate,
    required this.instructions,
    required this.status,
    this.rejectedNote,
    this.onholdNote,
    this.beforeNote,
    this.afterNote,
    this.beforeTaskImages1,
    this.beforeTaskImages2,
    this.beforeTaskImages3,
    this.afterTaskImages1,
    this.afterTaskImages2,
    this.afterTaskImages3,
    this.custName,
    this.custNumber,
    this.custRating,
    this.technicalNote,
    this.workmode,
    this.custSignature,
    this.technicianSignature,
    this.technicianName,
    this.technicianNumber,
    required this.brand,
    required this.model,
    this.purpose,
    this.acceptedNote,
    required this.ticketAddress,
    required this.fsrDetails,
    required this.serviceDetails,
    required this.subCustomerDetails,
    required this.checkpoints,
    required this.aging,
  });

  factory TicketResponseModel.fromJson(Map<String, dynamic> json) {
    return TicketResponseModel(
      id: json['id'],
      taskName: json['taskName'],
      date: json['date'],
      time: json['time'],
      israte: json['israte'],
      isamc: json['isamc'],
      assignTo: User.fromJson(json['assignTo']),
      customerDetails: User.fromJson(json['customerDetails']),
      technicalNotes: json['technical_notes'],
      devices: json['devices'],
      totalTime: json['total_time'],
      startDateTime: json['start_date_time'] != null
          ? DateTime.parse(json['start_date_time'])
          : null,
      endDateTime: json['end_date_time'] != null
          ? DateTime.parse(json['end_date_time'])
          : null,
      ticketCheckpoints: json['ticket_checkpoints'],
      admin: json['admin'],
      createdBy: json['created_by'],
      rate: json['rate'],
      instructions: json['instructions'],
      status: json['status'],
      rejectedNote: json['rejected_note'],
      onholdNote: json['onhold_note'],
      beforeNote: json['before_note'],
      afterNote: json['after_note'],
      beforeTaskImages1: json['before_task_images_1'],
      beforeTaskImages2: json['before_task_images_2'],
      beforeTaskImages3: json['before_task_images_3'],
      afterTaskImages1: json['after_task_images_1'],
      afterTaskImages2: json['after_task_images_2'],
      afterTaskImages3: json['after_task_images_3'],
      custName: json['cust_name'],
      custNumber: json['cust_number'],
      custRating: json['cust_rating'],
      technicalNote: json['technical_note'],
      workmode: json['workmode'],
      custSignature: json['cust_signature'],
      technicianSignature: json['technician_signature'],
      technicianName: json['technician_name'],
      technicianNumber: json['technician_number'],
      brand: json['brand'],
      model: json['model'],
      purpose: json['purpose'],
      acceptedNote: json['acceptedNote'],
      ticketAddress: Address.fromJson(json['ticket_address']),
      fsrDetails: FsrDetails.fromJson(json['fsrDetails']),
      serviceDetails: ServiceDetails.fromJson(json['serviceDetails']),
      subCustomerDetails: SubCustomerDetails.fromJson(json['subCustomerDetails']),
      checkpoints: json['checkpoints'],
      aging: json['aging'],
    );
  }
}

// User class
class User {
  final int id;
  final Attendance todayAttendance;
  final List<dynamic> brandNames;
  final DateTime? lastLogin;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String employees;
  final DateTime? dob;
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
  final String? batteryStatus;
  final bool gpsStatus;
  final double? longitude;
  final double? latitude;
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
  final String? primaryAddress;
  final String? landmarkPaci;
  final String? notes;
  final String? state;
  final String country;
  final String? city;
  final String? zipcode;
  final String? region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final DateTime? dateJoined;
  final String? createdBy;
  final String? admin;
  final String? customerId;

  User({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    this.lastLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
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
    this.state,
    required this.country,
    this.city,
    this.zipcode,
    this.region,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    this.dateJoined,
    this.createdBy,
    this.admin,
    this.customerId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      todayAttendance: Attendance.fromJson(json['today_attendance']),
      brandNames: json['brand_names'],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      employees: json['employees'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
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
      dateJoined: json['date_joined'] != null ? DateTime.parse(json['date_joined']) : null,
      createdBy: json['created_by'],
      admin: json['admin'],
      customerId: json['customer_id'],
    );
  }
}

// Attendance class
class Attendance {
  final int id;
  final int user;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;
  final String date;

  Attendance({
    required this.id,
    required this.user,
    this.checkIn,
    this.checkOut,
    required this.status,
    required this.date,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      user: json['user'],
      checkIn: json['check_in'] != null ? DateTime.parse(json['check_in']) : null,
      checkOut: json['check_out'] != null ? DateTime.parse(json['check_out']) : null,
      status: json['status'],
      date: json['date'],
    );
  }
}

// Address class
class Address {
  final String? primaryAddress;
  final String? state;
  final String country;
  final String? city;
  final String? zipcode;
  final String? region;

  Address({
    this.primaryAddress,
    this.state,
    required this.country,
    this.city,
    this.zipcode,
    this.region,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      primaryAddress: json['primary_address'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
      zipcode: json['zipcode'],
      region: json['region'],
    );
  }
}

// FsrDetails class
class FsrDetails {
  final List<dynamic> categories;
  final String fsrName;
  final String? createdBy;
  final String? admin;

  FsrDetails({
    required this.categories,
    required this.fsrName,
    this.createdBy,
    this.admin,
  });

  factory FsrDetails.fromJson(Map<String, dynamic> json) {
    return FsrDetails(
      categories: json['categories'],
      fsrName: json['fsrName'],
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }
}

/// ServiceDetails class (continued)
class ServiceDetails {
  final String serviceName;
  final double? servicePrice;
  final String serviceContactNumber;
  final String serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final String? serviceImage3;
  final String? serviceSubCategory;
  final String? createdBy;
  final String? admin;

  ServiceDetails({
    required this.serviceName,
    this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    this.serviceSubCategory,
    this.createdBy,
    this.admin,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
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
}

// SubCustomerDetails class
class SubCustomerDetails {
  final String password;
  final DateTime? lastLogin;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final DateTime? dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final String? profileImage;
  final String? customerName;
  final String customerTag;
  final String modelNo;
  final String socialId;
  final bool? deactivate;
  final String? role;
  final String customerType;
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
  final String? fileUpload;
  final String primaryAddress;
  final String landmarkPaci;
  final String notes;
  final String state;
  final String country;
  final String city;
  final String zipcode;
  final String region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final DateTime? dateJoined;
  final String? createdBy;
  final String? customerId;

  SubCustomerDetails({
    required this.password,
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
    required this.customerName,
    required this.customerTag,
    required this.modelNo,
    required this.socialId,
    this.deactivate,
    this.role,
    required this.customerType,
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
    required this.landmarkPaci,
    required this.notes,
    required this.state,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.region,
    this.allocatedSickLeave,
    this.allocatedCasualLeave,
    this.dateJoined,
    this.createdBy,
    this.customerId,
  });

  factory SubCustomerDetails.fromJson(Map<String, dynamic> json) {
    return SubCustomerDetails(
      password: json['password'],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      employees: json['employees'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
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
      dateJoined: json['date_joined'] != null ? DateTime.parse(json['date_joined']) : null,
      createdBy: json['created_by'],
      customerId: json['customer_id'],
    );
  }
}