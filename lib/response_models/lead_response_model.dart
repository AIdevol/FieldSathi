class LeadGetResponseModel {
  LeadGetResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  final int? count;
  final int? totalPages;
  final int? currentPage;
  final List<LeadResult> results;

  factory LeadGetResponseModel.fromJson(Map<String, dynamic> json){
    return LeadGetResponseModel(
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      results: json["results"] == null ? [] : List<LeadResult>.from(json["results"]!.map((x) => LeadResult.fromJson(x))),
    );
  }

}

class LeadResult {
  LeadResult({
    required this.id,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.source,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.nextInteraction,
    required this.nextInteractionNotes,
    required this.createdBy,
    required this.admin,
    required this.nextInteractionUser,
  });

  final int? id;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? source;
  final String? notes;
  final String? status;
  final DateTime? createdAt;
  final DateTime? nextInteraction;
  final String? nextInteractionNotes;
  final CreatedBy? createdBy;
  final int? admin;
  final NextInteractionUser? nextInteractionUser;

  factory LeadResult.fromJson(Map<String, dynamic> json){
    return LeadResult(
      id: json["id"],
      companyName: json["companyName"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      mobile: json["mobile"],
      address: json["address"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      source: json["source"],
      notes: json["notes"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      nextInteraction: DateTime.tryParse(json["next_interaction"] ?? ""),
      nextInteractionNotes: json["next_interaction_notes"],
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      admin: json["admin"],
      nextInteractionUser: json["next_interaction_user"] == null ? null : NextInteractionUser.fromJson(json["next_interaction_user"]),
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
    );
  }

}

class NextInteractionUser {
  NextInteractionUser({
    required this.password,
    required this.lastLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.employees,
    required this.dob,
    required this.otp,
    required this.otpVerified,
    required this.isStaff,
    required this.isSuperuser,
    required this.isActive,
    required this.profileImage,
    required this.customerName,
    required this.customerTag,
    required this.modelNo,
    required this.socialId,
    required this.deactivate,
    required this.role,
    required this.customerType,
    required this.batteryStatus,
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
    required this.fileUpload,
    required this.primaryAddress,
    required this.landmarkPaci,
    required this.notes,
    required this.state,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.region,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    required this.dateJoined,
    required this.maxEmployeesAllowed,
    required this.employeesCreated,
    required this.isLeaveAllocated,
    required this.empId,
    required this.isDisabled,
    required this.createdBy,
    required this.customerId,
    required this.subscription,
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
    required this.createdAt,
    required this.admin,
  });

  final String? password;
  final dynamic lastLogin;
  final String? firstName;
  final String? lastName;
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
  final dynamic fileUpload;
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
  final dynamic dateJoined;
  final int? maxEmployeesAllowed;
  final int? employeesCreated;
  final bool? isLeaveAllocated;
  final String? empId;
  final bool? isDisabled;
  final String? createdBy;
  final dynamic customerId;
  final dynamic subscription;
  final int? id;
  final List<TodayAttendance> todayAttendance;
  final List<dynamic> brandNames;
  final DateTime? createdAt;
  final int? admin;

  factory NextInteractionUser.fromJson(Map<String, dynamic> json){
    return NextInteractionUser(
      password: json["password"],
      lastLogin: json["last_login"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      companyName: json["company_name"],
      employees: json["employees"],
      dob: json["dob"],
      otp: json["otp"],
      otpVerified: json["otp_verified"],
      isStaff: json["is_staff"],
      isSuperuser: json["is_superuser"],
      isActive: json["is_active"],
      profileImage: json["profile_image"],
      customerName: json["customer_name"],
      customerTag: json["customer_tag"],
      modelNo: json["model_no"],
      socialId: json["social_id"],
      deactivate: json["deactivate"],
      role: json["role"],
      customerType: json["customer_type"],
      batteryStatus: json["battery_status"],
      gpsStatus: json["gps_status"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      companyAddress: json["companyAddress"],
      companyCity: json["companyCity"],
      companyState: json["companyState"],
      companyPincode: json["companyPincode"],
      companyCountry: json["companyCountry"],
      companyRegion: json["companyRegion"],
      companyLandlineNo: json["companyLandlineNo"],
      gstNo: json["gstNo"],
      cinNo: json["cinNo"],
      panNo: json["panNo"],
      companyContactNo: json["companyContactNo"],
      companyWebsite: json["companyWebsite"],
      bankName: json["bankName"],
      ifscSwift: json["ifscSwift"],
      accountNumber: json["accountNumber"],
      branchAddress: json["branchAddress"],
      upiId: json["upiId"],
      paymentLink: json["paymentLink"],
      fileUpload: json["fileUpload"],
      primaryAddress: json["primary_address"],
      landmarkPaci: json["landmark_paci"],
      notes: json["notes"],
      state: json["state"],
      country: json["country"],
      city: json["city"],
      zipcode: json["zipcode"],
      region: json["region"],
      allocatedSickLeave: json["allocated_sick_leave"],
      allocatedCasualLeave: json["allocated_casual_leave"],
      dateJoined: json["date_joined"],
      maxEmployeesAllowed: json["max_employees_allowed"],
      employeesCreated: json["employees_created"],
      isLeaveAllocated: json["is_leave_allocated"],
      empId: json["emp_id"],
      isDisabled: json["is_disabled"],
      createdBy: json["created_by"],
      customerId: json["customer_id"],
      subscription: json["subscription"],
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? [] : List<TodayAttendance>.from(json["today_attendance"]!.map((x) => TodayAttendance.fromJson(x))),
      brandNames: json["brand_names"] == null ? [] : List<dynamic>.from(json["brand_names"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      admin: json["admin"],
    );
  }

}

class TodayAttendance {
  TodayAttendance({
    required this.id,
    required this.user,
    required this.punchIn,
    required this.punchOut,
    required this.status,
    required this.date,
  });

  final int? id;
  final int? user;
  final dynamic punchIn;
  final dynamic punchOut;
  final String? status;
  final DateTime? date;

  factory TodayAttendance.fromJson(Map<String, dynamic> json){
    return TodayAttendance(
      id: json["id"],
      user: json["user"],
      punchIn: json["punch_in"],
      punchOut: json["punch_out"],
      status: json["status"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

}
