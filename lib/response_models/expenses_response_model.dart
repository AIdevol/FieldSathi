class ExpensesResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<ExpenseResult> results;

  ExpensesResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory ExpensesResponseModel.fromJson(Map<String, dynamic> json) {
    return ExpensesResponseModel(
      count: json['count'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ExpenseResult.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class ExpenseResult {
  final int id;
  final String fromField;
  final String to;
  final String amount;
  final String description;
  final String date;
  final String status;
  final String image;
  final String? approvedRemark;
  final String? paidRemark;
  final String? rejectedRemark;
  final String? approvedAmount;
  final String expenseType;
  final String createdAt;
  final Ticket ticket;
  final Technician technician;
  final dynamic createdBy;
  final dynamic admin;

  ExpenseResult({
    required this.id,
    required this.fromField,
    required this.to,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.image,
    this.approvedRemark,
    this.paidRemark,
    this.rejectedRemark,
    this.approvedAmount,
    required this.expenseType,
    required this.createdAt,
    required this.ticket,
    required this.technician,
    this.createdBy,
    this.admin,
  });

  factory ExpenseResult.fromJson(Map<String, dynamic> json) {
    return ExpenseResult(
      id: json['id'] ?? 0,
      fromField: json['from_field'] ?? '',
      to: json['to'] ?? '',
      amount: json['amount'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      image: json['image'] ?? '',
      approvedRemark: json['approvedRemark'],
      paidRemark: json['paidRemark'],
      rejectedRemark: json['rejectedRemark'],
      approvedAmount: json['approvedAmount'],
      expenseType: json['expense_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      ticket: Ticket.fromJson(json['ticket'] ?? {}),
      technician: Technician.fromJson(json['technician'] ?? {}),
      createdBy: json['created_by'],
      admin: json['admin'],
    );
  }
}

class Ticket {
  final String taskName;
  final dynamic date;
  final dynamic time;
  final bool israte;
  final bool isamc;
  final String address;
  final dynamic assignTo;
  final dynamic customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final List<dynamic> ticketCheckpoints;
  final String rate;
  final String instructions;
  final dynamic status;
  final String rejectedNote;
  final String onholdNote;
  final String beforeNote;
  final String afterNote;
  final dynamic beforeTaskImages1;
  final dynamic beforeTaskImages2;
  final dynamic beforeTaskImages3;
  final dynamic afterTaskImages1;
  final dynamic afterTaskImages2;
  final dynamic afterTaskImages3;
  final String custName;
  final String custNumber;
  final String custRating;
  final String technicalNote;
  final dynamic workmode;
  final dynamic custSignature;
  final dynamic technicianSignature;
  final String technicianName;
  final String technicianNumber;
  final String brand;
  final String model;
  final String purpose;
  final String acceptedNote;
  final dynamic ticketAddress;
  final dynamic fsrDetails;
  final dynamic serviceDetails;
  final dynamic subCustomerDetails;

  Ticket({
    required this.taskName,
    this.date,
    this.time,
    required this.israte,
    required this.isamc,
    required this.address,
    this.assignTo,
    this.customerDetails,
    required this.technicalNotes,
    required this.devices,
    required this.ticketCheckpoints,
    required this.rate,
    required this.instructions,
    this.status,
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
    this.workmode,
    this.custSignature,
    this.technicianSignature,
    required this.technicianName,
    required this.technicianNumber,
    required this.brand,
    required this.model,
    required this.purpose,
    required this.acceptedNote,
    this.ticketAddress,
    this.fsrDetails,
    this.serviceDetails,
    this.subCustomerDetails,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      taskName: json['taskName'] ?? '',
      date: json['date'],
      time: json['time'],
      israte: json['israte'] ?? false,
      isamc: json['isamc'] ?? false,
      address: json['address'] ?? '',
      assignTo: json['assignTo'],
      customerDetails: json['customerDetails'],
      technicalNotes: List<dynamic>.from(json['technical_notes'] ?? []),
      devices: List<dynamic>.from(json['devices'] ?? []),
      ticketCheckpoints: List<dynamic>.from(json['ticket_checkpoints'] ?? []),
      rate: json['rate'] ?? '',
      instructions: json['instructions'] ?? '',
      status: json['status'],
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
      workmode: json['workmode'],
      custSignature: json['cust_signature'],
      technicianSignature: json['technician_signature'],
      technicianName: json['technician_name'] ?? '',
      technicianNumber: json['technician_number'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      purpose: json['purpose'] ?? '',
      acceptedNote: json['acceptedNote'] ?? '',
      ticketAddress: json['ticket_address'],
      fsrDetails: json['fsrDetails'],
      serviceDetails: json['serviceDetails'],
      subCustomerDetails: json['subCustomerDetails'],
    );
  }
}

class Technician {
  final int id;
  final dynamic todayAttendance;
  final List<dynamic> brandNames;
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
  final dynamic customerName;
  final dynamic customerTag;
  final dynamic modelNo;
  final dynamic socialId;
  final bool deactivate;
  final String role;
  final dynamic customerType;
  final String batteryStatus;
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
  final dynamic country;
  final dynamic city;
  final dynamic zipcode;
  final dynamic region;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final String dateJoined;
  final int maxEmployeesAllowed;
  final int employeesCreated;
  final bool isLeaveAllocated;
  final String empId;
  final bool isDisabled;
  final String createdAt;
  final int createdBy;
  final int admin;
  final dynamic customerId;
  final dynamic subscription;

  Technician({
    required this.id,
    this.todayAttendance,
    required this.brandNames,
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
    this.customerName,
    this.customerTag,
    this.modelNo,
    this.socialId,
    required this.deactivate,
    required this.role,
    this.customerType,
    required this.batteryStatus,
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
    required this.dateJoined,
    required this.maxEmployeesAllowed,
    required this.employeesCreated,
    required this.isLeaveAllocated,
    required this.empId,
    required this.isDisabled,
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    this.customerId,
    this.subscription,
  });

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
        id: json['id'] ?? 0,
        todayAttendance: json['today_attendance'],
        brandNames: List<dynamic>.from(json['brand_names'] ?? []),
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
    customerName: json['customer_name'],
    customerTag: json['customer_tag'],
    modelNo: json['model_no'],
    socialId: json['social_id'],
    deactivate: json['deactivate'] ?? false,
    role: json['role'] ?? '',
    customerType: json['customer_type'],
    batteryStatus: json['battery_status'] ?? '',
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
    dateJoined: json['date_joined'] ?? '',
    maxEmployeesAllowed: json['max_employees_allowed'] ?? 0,
    employeesCreated: json['employees_created'] ?? 0,
    isLeaveAllocated: json['is_leave_allocated'] ?? false,
    empId: json['emp_id'] ?? '',
    isDisabled: json['is_disabled'] ?? false,
    createdAt: json['created_at'] ?? '',
    createdBy: json['created_by'] ?? 0,
    admin: json['admin'] ?? 0,
    customerId: json['customer_id'],
      subscription: json['subscription'],
    );
  }
}