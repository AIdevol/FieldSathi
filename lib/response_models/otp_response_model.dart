// class OtpResponseModel {
//   String? message;
//   int? userId;
//   String? accessToken;
//   String? refreshToken;
//   UserDetails? userDetails;
//
//   OtpResponseModel({
//     this.message,
//     this.userId,
//     this.accessToken,
//     this.refreshToken,
//     this.userDetails,
//   });
//
//   OtpResponseModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     userId = json['user_id'];
//     accessToken = json['access_token'];
//     refreshToken = json['refresh_token'];
//     userDetails = json['user_details'] != null
//         ? UserDetails.fromJson(json['user_details'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = this.message;
//     data['user_id'] = this.userId;
//     data['access_token'] = this.accessToken;
//     data['refresh_token'] = this.refreshToken;
//     if (this.userDetails != null) {
//       data['user_details'] = this.userDetails!.toJson();
//     }
//     return data;
//   }
// }
//
// class UserDetails {
//   int? id;
//   String? todayAttendance;
//   List<String>? brandNames;
//   String? lastLogin;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phoneNumber;
//   String? companyName;
//   String? employees;
//   String? dob;
//   String? otp;
//   bool? otpVerified;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isActive;
//   String? profileImage;
//   String? customerName;
//   String? customerTag;
//   String? modelNo;
//   String? socialId;
//   bool? deactivate;
//   String? role;
//   String? customerType;
//   String? batteryStatus;
//   bool? gpsStatus;
//   String? longitude;
//   String? latitude;
//   String? companyAddress;
//   String? companyCity;
//   String? companyState;
//   String? companyPincode;
//   String? companyCountry;
//   String? companyRegion;
//   String? companyLandlineNo;
//   String? gstNo;
//   String? cinNo;
//   String? panNo;
//   String? companyContactNo;
//   String? companyWebsite;
//   String? bankName;
//   String? ifscSwift;
//   String? accountNumber;
//   String? branchAddress;
//   String? upiId;
//   String? paymentLink;
//   String? fileUpload;
//   String? primaryAddress;
//   String? landmarkPaci;
//   String? notes;
//   String? state;
//   String? country;
//   String? city;
//   String? zipcode;
//   String? region;
//   String? createdBy;
//   String? admin;
//
//   UserDetails({
//     this.id,
//     this.todayAttendance,
//     this.brandNames,
//     this.lastLogin,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phoneNumber,
//     this.companyName,
//     this.employees,
//     this.dob,
//     this.otp,
//     this.otpVerified,
//     this.isStaff,
//     this.isSuperuser,
//     this.isActive,
//     this.profileImage,
//     this.customerName,
//     this.customerTag,
//     this.modelNo,
//     this.socialId,
//     this.deactivate,
//     this.role,
//     this.customerType,
//     this.batteryStatus,
//     this.gpsStatus,
//     this.longitude,
//     this.latitude,
//     this.companyAddress,
//     this.companyCity,
//     this.companyState,
//     this.companyPincode,
//     this.companyCountry,
//     this.companyRegion,
//     this.companyLandlineNo,
//     this.gstNo,
//     this.cinNo,
//     this.panNo,
//     this.companyContactNo,
//     this.companyWebsite,
//     this.bankName,
//     this.ifscSwift,
//     this.accountNumber,
//     this.branchAddress,
//     this.upiId,
//     this.paymentLink,
//     this.fileUpload,
//     this.primaryAddress,
//     this.landmarkPaci,
//     this.notes,
//     this.state,
//     this.country,
//     this.city,
//     this.zipcode,
//     this.region,
//     this.createdBy,
//     this.admin,
//   });
//
//   UserDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     todayAttendance = json['today_attendance'];
//     if (json['brand_names'] != null) {
//       brandNames = List<String>.from(json['brand_names']);
//     }
//     lastLogin = json['last_login'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     phoneNumber = json['phone_number'];
//     companyName = json['company_name'];
//     employees = json['employees'];
//     dob = json['dob'];
//     otp = json['otp'];
//     otpVerified = json['otp_verified'];
//     isStaff = json['is_staff'];
//     isSuperuser = json['is_superuser'];
//     isActive = json['is_active'];
//     profileImage = json['profile_image'];
//     customerName = json['customer_name'];
//     customerTag = json['customer_tag'];
//     modelNo = json['model_no'];
//     socialId = json['social_id'];
//     deactivate = json['deactivate'];
//     role = json['role'];
//     customerType = json['customer_type'];
//     batteryStatus = json['battery_status'];
//     gpsStatus = json['gps_status'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//     companyAddress = json['company_address'];
//     companyCity = json['company_city'];
//     companyState = json['company_state'];
//     companyPincode = json['company_pincode'];
//     companyCountry = json['company_country'];
//     companyRegion = json['company_region'];
//     companyLandlineNo = json['company_landline_no'];
//     gstNo = json['gst_no'];
//     cinNo = json['cin_no'];
//     panNo = json['pan_no'];
//     companyContactNo = json['company_contact_no'];
//     companyWebsite = json['company_website'];
//     bankName = json['bank_name'];
//     ifscSwift = json['ifsc_swift'];
//     accountNumber = json['account_number'];
//     branchAddress = json['branch_address'];
//     upiId = json['upi_id'];
//     paymentLink = json['payment_link'];
//     fileUpload = json['file_upload'];
//     primaryAddress = json['primary_address'];
//     landmarkPaci = json['landmark_paci'];
//     notes = json['notes'];
//     state = json['state'];
//     country = json['country'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     region = json['region'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = this.id;
//     data['today_attendance'] = this.todayAttendance;
//     if (this.brandNames != null) {
//       data['brand_names'] = this.brandNames!.map((v) => v).toList();
//     }
//     data['last_login'] = this.lastLogin;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['phone_number'] = this.phoneNumber;
//     data['company_name'] = this.companyName;
//     data['employees'] = this.employees;
//     data['dob'] = this.dob;
//     data['otp'] = this.otp;
//     data['otp_verified'] = this.otpVerified;
//     data['is_staff'] = this.isStaff;
//     data['is_superuser'] = this.isSuperuser;
//     data['is_active'] = this.isActive;
//     data['profile_image'] = this.profileImage;
//     data['customer_name'] = this.customerName;
//     data['customer_tag'] = this.customerTag;
//     data['model_no'] = this.modelNo;
//     data['social_id'] = this.socialId;
//     data['deactivate'] = this.deactivate;
//     data['role'] = this.role;
//     data['customer_type'] = this.customerType;
//     data['battery_status'] = this.batteryStatus;
//     data['gps_status'] = this.gpsStatus;
//     data['longitude'] = this.longitude;
//     data['latitude'] = this.latitude;
//     data['company_address'] = this.companyAddress;
//     data['company_city'] = this.companyCity;
//     data['company_state'] = this.companyState;
//     data['company_pincode'] = this.companyPincode;
//     data['company_country'] = this.companyCountry;
//     data['company_region'] = this.companyRegion;
//     data['company_landline_no'] = this.companyLandlineNo;
//     data['gst_no'] = this.gstNo;
//     data['cin_no'] = this.cinNo;
//     data['pan_no'] = this.panNo;
//     data['company_contact_no'] = this.companyContactNo;
//     data['company_website'] = this.companyWebsite;
//     data['bank_name'] = this.bankName;
//     data['ifsc_swift'] = this.ifscSwift;
//     data['account_number'] = this.accountNumber;
//     data['branch_address'] = this.branchAddress;
//     data['upi_id'] = this.upiId;
//     data['payment_link'] = this.paymentLink;
//     data['file_upload'] = this.fileUpload;
//     data['primary_address'] = this.primaryAddress;
//     data['landmark_paci'] = this.landmarkPaci;
//     data['notes'] = this.notes;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['region'] = this.region;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     return data;
//   }
// }
import 'package:intl/intl.dart';

class OtpResponseModel {
  final String? message;
  final int? userId;
  final String? accessToken;
  final String? refreshToken;
  final UserDetails? userDetails;

  OtpResponseModel({
     this.message,
     this.userId,
     this.accessToken,
     this.refreshToken,
     this.userDetails,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json['message'],
      userId: json['user_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      userDetails: UserDetails.fromJson(json['user_details']),
    );
  }
}

class UserDetails {
  final int id;
  final TodayAttendance todayAttendance;
  final List<String> brandNames;
  final dynamic lastLogin;
  final String firstName;
  final String lastName;
  final String email;
  final dynamic phoneNumber;
  final String companyName;
  final String employees;
  final dynamic dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final dynamic customerName;
  final dynamic customerTag;
  final dynamic modelNo;
  final dynamic socialId;
  final bool deactivate;
  final String role;
  final dynamic customerType;
  final dynamic batteryStatus;
  final bool gpsStatus;
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
  final dynamic primaryAddress;
  final dynamic landmarkPaci;
  final dynamic notes;
  final dynamic state;
  final String country;
  final dynamic city;
  final dynamic zipcode;
  final dynamic region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final dynamic dateJoined;
  final dynamic createdBy;
  final dynamic admin;
  final dynamic customerId;

  UserDetails({
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

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      todayAttendance: TodayAttendance.fromJson(json['today_attendance']),
      brandNames: List<String>.from(json['brand_names']),
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
      createdBy: json['created_by'],
      admin: json['admin'],
      customerId: json['customer_id'],
    );
  }
}

class TodayAttendance {
  final int id;
  final int user;
  final dynamic checkIn;
  final dynamic checkOut;
  final String status;
  final String date;

  TodayAttendance({
    required this.id,
    required this.user,
    this.checkIn,
    this.checkOut,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'],
      user: json['user'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      status: json['status'],
      date: json['date'],
    );
  }
}