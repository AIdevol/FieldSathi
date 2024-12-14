class ExpensesResponseModel {
  ExpensesResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  final int? count;
  final int? totalPages;
  final int? currentPage;
  final List<ExpenseResult> results;

  factory ExpensesResponseModel.fromJson(Map<String, dynamic> json){
    return ExpensesResponseModel(
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      results: json["results"] == null ? [] : List<ExpenseResult>.from(json["results"]!.map((x) => ExpenseResult.fromJson(x))),
    );
  }

}

class ExpenseResult {
  ExpenseResult({
    required this.id,
    required this.fromField,
    required this.to,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.image,
    required this.approvedRemark,
    required this.paidRemark,
    required this.rejectedRemark,
    required this.approvedAmount,
    required this.expenseType,
    required this.createdAt,
    required this.expenseDate,
    required this.ticket,
    required this.technician,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? fromField;
  final String? to;
  final String? amount;
  final String? description;
  final DateTime? date;
  final String? status;
  final String? image;
  final String? approvedRemark;
  final String? paidRemark;
  final String? rejectedRemark;
  final String? approvedAmount;
  final String? expenseType;
  final DateTime? createdAt;
  final DateTime? expenseDate;
  final Ticket? ticket;
  final Technician? technician;
  final String? createdBy;
  final dynamic admin;

  factory ExpenseResult.fromJson(Map<String, dynamic> json){
    return ExpenseResult(
      id: json["id"],
      fromField: json["from_field"],
      to: json["to"],
      amount: json["amount"],
      description: json["description"],
      date: DateTime.tryParse(json["date"] ?? ""),
      status: json["status"],
      image: json["image"],
      approvedRemark: json["approvedRemark"],
      paidRemark: json["paidRemark"],
      rejectedRemark: json["rejectedRemark"],
      approvedAmount: json["approvedAmount"],
      expenseType: json["expense_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      expenseDate: DateTime.tryParse(json["expense_date"] ?? ""),
      ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
      technician: json["technician"] == null ? null : Technician.fromJson(json["technician"]),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class Technician {
  Technician({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
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
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    required this.customerId,
    required this.subscription,
  });

  final int? id;
  final List<TodayAttendance> todayAttendance;
  final List<dynamic> brandNames;
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
  final dynamic customerName;
  final dynamic customerTag;
  final dynamic modelNo;
  final dynamic socialId;
  final bool? deactivate;
  final String? role;
  final dynamic customerType;
  final String? batteryStatus;
  final bool? gpsStatus;
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
  final String? primaryAddress;
  final dynamic landmarkPaci;
  final dynamic notes;
  final dynamic state;
  final String? country;
  final dynamic city;
  final dynamic zipcode;
  final dynamic region;
  final int? allocatedSickLeave;
  final int? allocatedCasualLeave;
  final DateTime? dateJoined;
  final int? maxEmployeesAllowed;
  final int? employeesCreated;
  final bool? isLeaveAllocated;
  final String? empId;
  final bool? isDisabled;
  final DateTime? createdAt;
  final String? createdBy;
  final int? admin;
  final dynamic customerId;
  final dynamic subscription;

  factory Technician.fromJson(Map<String, dynamic> json){
    return Technician(
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? [] : List<TodayAttendance>.from(json["today_attendance"]!.map((x) => TodayAttendance.fromJson(x))),
      brandNames: json["brand_names"] == null ? [] : List<dynamic>.from(json["brand_names"]!.map((x) => x)),
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
      dateJoined: DateTime.tryParse(json["date_joined"] ?? ""),
      maxEmployeesAllowed: json["max_employees_allowed"],
      employeesCreated: json["employees_created"],
      isLeaveAllocated: json["is_leave_allocated"],
      empId: json["emp_id"],
      isDisabled: json["is_disabled"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      createdBy: json["created_by"],
      admin: json["admin"],
      customerId: json["customer_id"],
      subscription: json["subscription"],
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
  final DateTime? punchIn;
  final DateTime? punchOut;
  final String? status;
  final DateTime? date;

  factory TodayAttendance.fromJson(Map<String, dynamic> json){
    return TodayAttendance(
      id: json["id"],
      user: json["user"],
      punchIn: DateTime.tryParse(json["punch_in"] ?? ""),
      punchOut: DateTime.tryParse(json["punch_out"] ?? ""),
      status: json["status"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

}

class Ticket {
  Ticket({
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
    required this.rate,
    required this.instructions,
    required this.status,
    required this.rejectedNote,
    required this.onholdNote,
    required this.beforeNote,
    required this.afterNote,
    required this.beforeTaskImages1,
    required this.beforeTaskImages2,
    required this.beforeTaskImages3,
    required this.afterTaskImages1,
    required this.afterTaskImages2,
    required this.afterTaskImages3,
    required this.custName,
    required this.custNumber,
    required this.custRating,
    required this.technicalNote,
    required this.workmode,
    required this.custSignature,
    required this.technicianSignature,
    required this.technicianName,
    required this.technicianNumber,
    required this.brand,
    required this.model,
    required this.purpose,
    required this.acceptedNote,
    required this.ticketAddress,
    required this.region,
    required this.phoneNumber,
    required this.createdAt,
    required this.fsrDetails,
    required this.serviceDetails,
    required this.subCustomerDetails,
    required this.selectedAmc,
    required this.checkpoints,
  });

  final int? id;
  final String? taskName;
  final DateTime? date;
  final String? time;
  final bool? israte;
  final bool? isamc;
  final Technician? assignTo;
  final CustomerDetails? customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String? totalTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int? admin;
  final String? createdBy;
  final String? rate;
  final String? instructions;
  final String? status;
  final String? rejectedNote;
  final String? onholdNote;
  final String? beforeNote;
  final String? afterNote;
  final String? beforeTaskImages1;
  final dynamic beforeTaskImages2;
  final dynamic beforeTaskImages3;
  final String? afterTaskImages1;
  final dynamic afterTaskImages2;
  final dynamic afterTaskImages3;
  final String? custName;
  final String? custNumber;
  final String? custRating;
  final String? technicalNote;
  final String? workmode;
  final String? custSignature;
  final dynamic technicianSignature;
  final String? technicianName;
  final String? technicianNumber;
  final String? brand;
  final String? model;
  final String? purpose;
  final String? acceptedNote;
  final String? ticketAddress;
  final String? region;
  final String? phoneNumber;
  final DateTime? createdAt;
  final FsrDetails? fsrDetails;
  final ServiceDetails? serviceDetails;
  final CustomerDetails? subCustomerDetails;
  final dynamic selectedAmc;
  final List<dynamic> checkpoints;

  factory Ticket.fromJson(Map<String, dynamic> json){
    return Ticket(
      id: json["id"],
      taskName: json["taskName"],
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      israte: json["israte"],
      isamc: json["isamc"],
      assignTo: json["assignTo"] == null ? null : Technician.fromJson(json["assignTo"]),
      customerDetails: json["customerDetails"] == null ? null : CustomerDetails.fromJson(json["customerDetails"]),
      technicalNotes: json["technical_notes"] == null ? [] : List<dynamic>.from(json["technical_notes"]!.map((x) => x)),
      devices: json["devices"] == null ? [] : List<dynamic>.from(json["devices"]!.map((x) => x)),
      totalTime: json["total_time"],
      startDateTime: DateTime.tryParse(json["start_date_time"] ?? ""),
      endDateTime: DateTime.tryParse(json["end_date_time"] ?? ""),
      ticketCheckpoints: json["ticket_checkpoints"] == null ? [] : List<dynamic>.from(json["ticket_checkpoints"]!.map((x) => x)),
      admin: json["admin"],
      createdBy: json["created_by"],
      rate: json["rate"],
      instructions: json["instructions"],
      status: json["status"],
      rejectedNote: json["rejected_note"],
      onholdNote: json["onhold_note"],
      beforeNote: json["before_note"],
      afterNote: json["after_note"],
      beforeTaskImages1: json["before_task_images_1"],
      beforeTaskImages2: json["before_task_images_2"],
      beforeTaskImages3: json["before_task_images_3"],
      afterTaskImages1: json["after_task_images_1"],
      afterTaskImages2: json["after_task_images_2"],
      afterTaskImages3: json["after_task_images_3"],
      custName: json["cust_name"],
      custNumber: json["cust_number"],
      custRating: json["cust_rating"],
      technicalNote: json["technical_note"],
      workmode: json["workmode"],
      custSignature: json["cust_signature"],
      technicianSignature: json["technician_signature"],
      technicianName: json["technician_name"],
      technicianNumber: json["technician_number"],
      brand: json["brand"],
      model: json["model"],
      purpose: json["purpose"],
      acceptedNote: json["acceptedNote"],
      ticketAddress: json["ticket_address"],
      region: json["region"],
      phoneNumber: json["phone_number"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      fsrDetails: json["fsrDetails"] == null ? null : FsrDetails.fromJson(json["fsrDetails"]),
      serviceDetails: json["serviceDetails"] == null ? null : ServiceDetails.fromJson(json["serviceDetails"]),
      subCustomerDetails: json["subCustomerDetails"] == null ? null : CustomerDetails.fromJson(json["subCustomerDetails"]),
      selectedAmc: json["selected_amc"],
      checkpoints: json["checkpoints"] == null ? [] : List<dynamic>.from(json["checkpoints"]!.map((x) => x)),
    );
  }

}

class CustomerDetails {
  CustomerDetails({
    required this.id,
    required this.todayAttendance,
    required this.brandNames,
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
    required this.createdAt,
    required this.createdBy,
    required this.admin,
    required this.customerId,
    required this.subscription,
    required this.password,
  });

  final int? id;
  final List<TodayAttendance> todayAttendance;
  final List<String> brandNames;
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
  final dynamic profileImage;
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
  final DateTime? createdAt;
  final String? createdBy;
  final int? admin;
  final int? customerId;
  final dynamic subscription;
  final String? password;

  factory CustomerDetails.fromJson(Map<String, dynamic> json){
    return CustomerDetails(
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? [] : List<TodayAttendance>.from(json["today_attendance"]!.map((x) => TodayAttendance.fromJson(x))),
      brandNames: json["brand_names"] == null ? [] : List<String>.from(json["brand_names"]!.map((x) => x)),
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
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      createdBy: json["created_by"],
      admin: json["admin"],
      customerId: json["customer_id"],
      subscription: json["subscription"],
      password: json["password"],
    );
  }

}

class FsrDetails {
  FsrDetails({
    required this.id,
    required this.fsrName,
    required this.categories,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? fsrName;
  final List<Category> categories;
  final int? createdBy;
  final int? admin;

  factory FsrDetails.fromJson(Map<String, dynamic> json){
    return FsrDetails(
      id: json["id"],
      fsrName: json["fsrName"],
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.checkpoints,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? name;
  final List<Checkpoint> checkpoints;
  final int? createdBy;
  final int? admin;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      checkpoints: json["checkpoints"] == null ? [] : List<Checkpoint>.from(json["checkpoints"]!.map((x) => Checkpoint.fromJson(x))),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class Checkpoint {
  Checkpoint({
    required this.id,
    required this.checkpointName,
    required this.checkpointStatuses,
    required this.displayType,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? checkpointName;
  final List<dynamic> checkpointStatuses;
  final String? displayType;
  final int? createdBy;
  final int? admin;

  factory Checkpoint.fromJson(Map<String, dynamic> json){
    return Checkpoint(
      id: json["id"],
      checkpointName: json["checkpoint_name"],
      checkpointStatuses: json["checkpointStatuses"] == null ? [] : List<dynamic>.from(json["checkpointStatuses"]!.map((x) => x)),
      displayType: json["displayType"],
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class ServiceDetails {
  ServiceDetails({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    required this.serviceImage1,
    required this.serviceImage2,
    required this.serviceImage3,
    required this.serviceSubCategory,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceName;
  final String? servicePrice;
  final String? serviceContactNumber;
  final String? serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final dynamic serviceImage3;
  final ServiceSubCategory? serviceSubCategory;
  final int? createdBy;
  final int? admin;

  factory ServiceDetails.fromJson(Map<String, dynamic> json){
    return ServiceDetails(
      id: json["id"],
      serviceName: json["service_name"],
      servicePrice: json["service_price"],
      serviceContactNumber: json["service_contact_number"],
      serviceDescription: json["service_description"],
      serviceImage1: json["service_image1"],
      serviceImage2: json["service_image2"],
      serviceImage3: json["service_image3"],
      serviceSubCategory: json["service_sub_category"] == null ? null : ServiceSubCategory.fromJson(json["service_sub_category"]),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class ServiceSubCategory {
  ServiceSubCategory({
    required this.id,
    required this.serviceSubCategoryName,
    required this.serviceSubCatDescription,
    required this.serviceSubImage,
    required this.serviceCategory,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceSubCategoryName;
  final String? serviceSubCatDescription;
  final dynamic serviceSubImage;
  final ServiceCategory? serviceCategory;
  final int? createdBy;
  final int? admin;

  factory ServiceSubCategory.fromJson(Map<String, dynamic> json){
    return ServiceSubCategory(
      id: json["id"],
      serviceSubCategoryName: json["service_sub_category_name"],
      serviceSubCatDescription: json["service_sub_cat_description"],
      serviceSubImage: json["service_sub_image"],
      serviceCategory: json["service_category"] == null ? null : ServiceCategory.fromJson(json["service_category"]),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class ServiceCategory {
  ServiceCategory({
    required this.id,
    required this.serviceCategoryName,
    required this.serviceCatDescriptions,
    required this.serviceCatImage,
    required this.createdBy,
    required this.admin,
  });

  final int? id;
  final String? serviceCategoryName;
  final String? serviceCatDescriptions;
  final String? serviceCatImage;
  final int? createdBy;
  final int? admin;

  factory ServiceCategory.fromJson(Map<String, dynamic> json){
    return ServiceCategory(
      id: json["id"],
      serviceCategoryName: json["service_category_name"],
      serviceCatDescriptions: json["service_cat_descriptions"],
      serviceCatImage: json["service_cat_image"],
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}
