class TicketResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<TicketResult> results;

  TicketResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory TicketResponseModel.fromJson(Map<String, dynamic> json) {
    return TicketResponseModel(
      count: json['count'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      results: (json['results'] as List?)?.map((x) => TicketResult.fromJson(x)).toList() ?? [],
    );
  }
}

class TicketResult {
  final int id;
  final String taskName;
  final String date;
  final String time;
  final bool israte;
  final bool isamc;
  final UserModel assignTo;
  final UserModel customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String totalTime;
  final String startDateTime;
  final String endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int admin;
  final String createdBy;
  final dynamic rate;
  final dynamic instructions;
  final String status;
  final String rejectedNote;
  final String onholdNote;
  final String beforeNote;
  final String afterNote;
  final String? beforeTaskImages1;
  final String? beforeTaskImages2;
  final String? beforeTaskImages3;
  final String? afterTaskImages1;
  final String? afterTaskImages2;
  final String? afterTaskImages3;
  final String custName;
  final String custNumber;
  final String custRating;
  final String technicalNote;
  final String workmode;
  final String? custSignature;
  final String? technicianSignature;
  final String technicianName;
  final String technicianNumber;
  final dynamic brand;
  final String model;
  final String purpose;
  final String acceptedNote;
  final TicketAddress ticketAddress;
  final String createdAt;
  final FsrDetails fsrDetails;
  final dynamic serviceDetails;
  final SubCustomerDetails subCustomerDetails;
  final List<dynamic> checkpoints;
  final int aging;

  TicketResult({
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
    required this.startDateTime,
    required this.endDateTime,
    required this.ticketCheckpoints,
    required this.admin,
    required this.createdBy,
    this.rate,
    this.instructions,
    required this.status,
    required this.rejectedNote,
    required this.onholdNote,
    required this.beforeNote,
    required this.afterNote,
    this.beforeTaskImages1,
    this.beforeTaskImages2,
    this.beforeTaskImages3,
    this.afterTaskImages1,
    this.afterTaskImages2,
    this.afterTaskImages3,
    required this.custName,
    required this.custNumber,
    required this.custRating,
    required this.technicalNote,
    required this.workmode,
    this.custSignature,
    this.technicianSignature,
    required this.technicianName,
    required this.technicianNumber,
    this.brand,
    required this.model,
    required this.purpose,
    required this.acceptedNote,
    required this.ticketAddress,
    required this.createdAt,
    required this.fsrDetails,
    this.serviceDetails,
    required this.subCustomerDetails,
    required this.checkpoints,
    required this.aging,
  });

  factory TicketResult.fromJson(Map<String, dynamic> json) {
    return TicketResult(
      id: json['id'] ?? 0,
      taskName: json['taskName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      israte: json['israte'] ?? false,
      isamc: json['isamc'] ?? false,
      assignTo: UserModel.fromJson(json['assignTo'] ?? {}),
      customerDetails: UserModel.fromJson(json['customerDetails'] ?? {}),
      technicalNotes: json['technical_notes'] ?? [],
      devices: json['devices'] ?? [],
      totalTime: json['total_time'] ?? '',
      startDateTime: json['start_date_time'] ?? '',
      endDateTime: json['end_date_time'] ?? '',
      ticketCheckpoints: json['ticket_checkpoints'] ?? [],
      admin: json['admin'] ?? 0,
      createdBy: json['created_by'] ?? '',
      rate: json['rate'],
      instructions: json['instructions'],
      status: json['status'] ?? '',
      rejectedNote: json['rejected_note'] ?? '',
      onholdNote: json['onhold_note'] ?? '',
      beforeNote: json['before_note'] ?? '',
      afterNote: json['after_note'] ?? '',
      beforeTaskImages1: json['before_task_images_1'],
      beforeTaskImages2: json['before_task_images_2'],
      beforeTaskImages3: json['before_task_images_3'],
      afterTaskImages1: json['after_task_images_1'],
      afterTaskImages2: json['after_task_images_2'],
      afterTaskImages3: json['after_task_images_3'],
      custName: json['cust_name'] ?? '',
      custNumber: json['cust_number'] ?? '',
      custRating: json['cust_rating'] ?? '',
      technicalNote: json['technical_note'] ?? '',
      workmode: json['workmode'] ?? '',
      custSignature: json['cust_signature'],
      technicianSignature: json['technician_signature'],
      technicianName: json['technician_name'] ?? '',
      technicianNumber: json['technician_number'] ?? '',
      brand: json['brand'],
      model: json['model'] ?? '',
      purpose: json['purpose'] ?? '',
      acceptedNote: json['acceptedNote'] ?? '',
      ticketAddress: TicketAddress.fromJson(json['ticket_address'] ?? {}),
      createdAt: json['created_at'] ?? '',
      fsrDetails: FsrDetails.fromJson(json['fsrDetails'] ?? {}),
      serviceDetails: json['serviceDetails'],
      subCustomerDetails: SubCustomerDetails.fromJson(json['subCustomerDetails'] ?? {}),
      checkpoints: json['checkpoints'] ?? [],
      aging: json['aging'] ?? 0,
    );
  }
}

class UserModel {
  final int id;
  final Attendance? todayAttendance;
  final List<dynamic> brandNames;
  final dynamic lastLogin;
  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final dynamic dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final String? customerName;
  final dynamic customerTag;
  final dynamic modelNo;
  final dynamic socialId;
  final bool deactivate;
  final String role;
  final dynamic customerType;
  final String? batteryStatus;
  final bool gpsStatus;
  final String? longitude;
  final String? latitude;
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
  final String? state;
  final String? country;
  final String? city;
  final dynamic zipcode;
  final dynamic region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final String? dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final String? empId;
  final bool isDisabled;
  final String createdAt;
  final int createdBy;
  final int admin;
  final dynamic customerId;
  final dynamic subscription;

  UserModel({
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
    this.country,
    this.city,
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      todayAttendance: json['today_attendance'] != null
          ? Attendance.fromJson(json['today_attendance'])
          : null,
      brandNames: json['brand_names'] ?? [],
      lastLogin: json['last_login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'] ?? '',
      employees: json['employees'] ?? '',
      dob: json['dob'],
      otp: json['otp'] ?? '',
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'],
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
      primaryAddress: json['primary_address'],
      landmarkPaci: json['landmark_paci'],
      notes: json['notes'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
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
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
      customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }
}

class Attendance {
  final int id;
  final int user;
  final String? punchIn;
  final String? punchOut;
  final String status;
  final String date;

  Attendance({
    required this.id,
    required this.user,
    this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

class TicketAddress {
  final String? city;
  final String? state;
  final dynamic region;
  final String? country;
  final dynamic zipcode;
  final dynamic primaryAddress;

  TicketAddress({
    this.city,
    this.state,
    this.region,
    this.country,
    this.zipcode,
    this.primaryAddress,
  });

  factory TicketAddress.fromJson(Map<String, dynamic> json) {
    return TicketAddress(
      city: json['city'],
      state: json['state'],
      region: json['region'],
      country: json['country'],
      zipcode: json['zipcode'],
      primaryAddress: json['primary_address'],
    );
  }
}

class FsrDetails {
  final String fsrName;
  final List<dynamic> categories;

  FsrDetails({
    required this.fsrName,
    required this.categories,
  });

  factory FsrDetails.fromJson(Map<String, dynamic> json) {
    return FsrDetails(
      fsrName: json['fsrName'] ?? '',
      categories: json['categories'] ?? [],
    );
  }
}
class CustomerDetails {
  final int id;
  final Attendance? todayAttendance;
  final List<dynamic> brandNames;
  final dynamic lastLogin;
  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final dynamic dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final String? customerName;
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
  final String? state;
  final String? country;
  final String? city;
  final dynamic zipcode;
  final dynamic region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final dynamic dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final dynamic empId;
  final bool isDisabled;
  final String createdAt;
  final int createdBy;
  final int admin;
  final dynamic customerId;
  final dynamic subscription;

  CustomerDetails({
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
    this.country,
    this.city,
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

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      id: json['id'] ?? 0,
      todayAttendance: json['today_attendance'] != null
          ? Attendance.fromJson(json['today_attendance'])
          : null,
      brandNames: json['brand_names'] ?? [],
      lastLogin: json['last_login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'] ?? '',
      employees: json['employees'] ?? '',
      dob: json['dob'],
      otp: json['otp'] ?? '',
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'],
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
      primaryAddress: json['primary_address'],
      landmarkPaci: json['landmark_paci'],
      notes: json['notes'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
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
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
      customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }
}
class SubCustomerDetails {
  final String password;
  final dynamic lastLogin;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String employees;
  final dynamic dob;
  final String otp;
  final bool otpVerified;
  final bool isStaff;
  final bool isSuperuser;
  final bool isActive;
  final dynamic profileImage;
  final String customerName;
  final String customerTag;
  final String modelNo;
  final String socialId;
  final dynamic deactivate;
  final dynamic role;
  final String customerType;
  final String batteryStatus;
  final dynamic gpsStatus;
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
  final dynamic fileUpload;
  final String primaryAddress;
  final String landmarkPaci;
  final String notes;
  final String state;
  final String country;
  final String city;
  final String zipcode;
  final String region;
  final dynamic allocatedSickLeave;
  final dynamic allocatedCasualLeave;
  final dynamic dateJoined;
  final dynamic maxEmployeesAllowed;
  final dynamic employeesCreated;
  final bool isLeaveAllocated;
  final String empId;
  final bool isDisabled;
  final dynamic createdBy;
  final dynamic customerId;
  final dynamic subscription;

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
    this.maxEmployeesAllowed,
    this.employeesCreated,
    required this.isLeaveAllocated,
    required this.empId,
    required this.isDisabled,
    this.createdBy,
    this.customerId,
    this.subscription,
  });

  factory SubCustomerDetails.fromJson(Map<String, dynamic> json) {
    return SubCustomerDetails(
      password: json['password'] ?? '',
      lastLogin: json['last_login'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'] ?? '',
      employees: json['employees'] ?? '',
      dob: json['dob'],
      otp: json['otp'] ?? '',
      otpVerified: json['otp_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? false,
      profileImage: json['profile_image'],
      customerName: json['customer_name'] ?? '',
      customerTag: json['customer_tag'] ?? '',
      modelNo: json['model_no'] ?? '',
      socialId: json['social_id'] ?? '',
      deactivate: json['deactivate'],
      role: json['role'],
      customerType: json['customer_type'] ?? '',
      batteryStatus: json['battery_status'] ?? '',
      gpsStatus: json['gps_status'],
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      companyAddress: json['companyAddress'] ?? '',
      companyCity: json['companyCity'] ?? '',
      companyState: json['companyState'] ?? '',
      companyPincode: json['companyPincode'] ?? '',
      companyCountry: json['companyCountry'] ?? '',
      companyRegion: json['companyRegion'] ?? '',
      companyLandlineNo: json['companyLandlineNo'] ?? '',
      gstNo: json['gstNo'] ?? '',
      cinNo: json['cinNo'] ?? '',
      panNo: json['panNo'] ?? '',
      companyContactNo: json['companyContactNo'] ?? '',
      companyWebsite: json['companyWebsite'] ?? '',
      bankName: json['bankName'] ?? '',
      ifscSwift: json['ifscSwift'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      branchAddress: json['branchAddress'] ?? '',
      upiId: json['upiId'] ?? '',
      paymentLink: json['paymentLink'] ?? '',
      fileUpload: json['fileUpload'],
      primaryAddress: json['primary_address'] ?? '',
      landmarkPaci: json['landmark_paci'] ?? '',
      notes: json['notes'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      region: json['region'] ?? '',
      allocatedSickLeave: json['allocated_sick_leave'],
      allocatedCasualLeave: json['allocated_casual_leave'],
      dateJoined: json['date_joined'],
      maxEmployeesAllowed: json['max_employees_allowed'],
      employeesCreated: json['employees_created'],
      isLeaveAllocated: json['is_leave_allocated'] ?? false,
      empId: json['emp_id'] ?? '',
      isDisabled: json['is_disabled'] ?? false,
      createdBy: json['created_by'],
      customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }
}