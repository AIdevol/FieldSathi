import 'package:meta/meta.dart';

class LeaveResponseModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Results>? results;

  LeaveResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveResponseModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((e) => e.toJson()).toList(),
    };
  }
}

class Results {
  final int? id;
  final UserId? userId;
  final String? startDate;
  final String? endDate;
  final String? reason;
  final String? status;
  final String? leaveType;

  Results({
    this.id,
    this.userId,
    this.startDate,
    this.endDate,
    this.reason,
    this.status,
    this.leaveType,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] as int?,
      userId: json['userId'] != null ? UserId.fromJson(json['userId'] as Map<String, dynamic>) : null,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      leaveType: json['leave_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId?.toJson(),
      'start_date': startDate,
      'end_date': endDate,
      'reason': reason,
      'status': status,
      'leave_type': leaveType,
    };
  }
}

class UserId {
  final int? id;
  final TodayAttendance? todayAttendance;
  final List<String>? brandNames;
  final String? lastLogin;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? employees;
  final String? dob;
  final String? otp;
  final bool? otpVerified;
  final bool? isStaff;
  final bool? isSuperuser;
  final bool? isActive;
  final String? profileImage;
  final String? customerName;
  final String? customerTag;
  final String? modelNo;
  final String? socialId;
  final bool? deactivate;
  final String? role;
  final String? customerType;
  final String? batteryStatus;
  final bool? gpsStatus;
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
  final String? primaryAddress;
  final String? landmarkPaci;
  final String? notes;
  final String? state;
  final String? country;
  final String? city;
  final String? zipcode;
  final String? region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final String? dateJoined;
  final int? createdBy;
  final int? admin;
  final String? customerId;

  UserId({
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

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['id'] as int?,
      todayAttendance: json['today_attendance'] != null
          ? TodayAttendance.fromJson(json['today_attendance'] as Map<String, dynamic>)
          : null,
      brandNames: (json['brand_names'] as List<dynamic>?)?.cast<String>(),
      lastLogin: json['last_login'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      companyName: json['company_name'] as String?,
      employees: json['employees'] as String?,
      dob: json['dob'] as String?,
      otp: json['otp'] as String?,
      otpVerified: json['otp_verified'] as bool?,
      isStaff: json['is_staff'] as bool?,
      isSuperuser: json['is_superuser'] as bool?,
      isActive: json['is_active'] as bool?,
      profileImage: json['profile_image'] as String?,
      customerName: json['customer_name'] as String?,
      customerTag: json['customer_tag'] as String?,
      modelNo: json['model_no'] as String?,
      socialId: json['social_id'] as String?,
      deactivate: json['deactivate'] as bool?,
      role: json['role'] as String?,
      customerType: json['customer_type'] as String?,
      batteryStatus: json['battery_status'] as String?,
      gpsStatus: json['gps_status'] as bool?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      companyAddress: json['companyAddress'] as String?,
      companyCity: json['companyCity'] as String?,
      companyState: json['companyState'] as String?,
      companyPincode: json['companyPincode'] as String?,
      companyCountry: json['companyCountry'] as String?,
      companyRegion: json['companyRegion'] as String?,
      companyLandlineNo: json['companyLandlineNo'] as String?,
      gstNo: json['gstNo'] as String?,
      cinNo: json['cinNo'] as String?,
      panNo: json['panNo'] as String?,
      companyContactNo: json['companyContactNo'] as String?,
      companyWebsite: json['companyWebsite'] as String?,
      bankName: json['bankName'] as String?,
      ifscSwift: json['ifscSwift'] as String?,
      accountNumber: json['accountNumber'] as String?,
      branchAddress: json['branchAddress'] as String?,
      upiId: json['upiId'] as String?,
      paymentLink: json['paymentLink'] as String?,
      fileUpload: json['fileUpload'] as String?,
      primaryAddress: json['primary_address'] as String?,
      landmarkPaci: json['landmark_paci'] as String?,
      notes: json['notes'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      region: json['region'] as String?,
      allocatedSickLeave: json['allocated_sick_leave'] as int?,
      allocatedCasualLeave: json['allocated_casual_leave'] as int?,
      dateJoined: json['date_joined'] as String?,
      createdBy: json['created_by'] as int?,
      admin: json['admin'] as int?,
      customerId: json['customer_id'] as String?,
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
      'created_by': createdBy,
      'admin': admin,
      'customer_id': customerId,
    };
  }
}

class TodayAttendance {
  final int? id;
  final int? user;
  final String? checkIn;
  final String? checkOut;
  final String? status;
  final String? date;

  TodayAttendance({
    this.id,
    this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'] as int?,
      user: json['user'] as int?,
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      status: json['status'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'check_in': checkIn,
      'check_out': checkOut,
      'status': status,
      'date': date,
    };
  }
}