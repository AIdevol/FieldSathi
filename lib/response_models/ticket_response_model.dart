class TicketResponseModel {
  TicketResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int? count;
  final int? totalPages;
  final int? currentPage;
  final dynamic next;
  final dynamic previous;
  final List<TicketResult>? results;

  factory TicketResponseModel.fromJson(Map<String, dynamic> json){
    return TicketResponseModel(
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null ? [] : List<TicketResult>.from(json["results"]!.map((x) => TicketResult.fromJson(x))),
    );
  }

}

class TicketResult {
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
    required this.fsrData,
    required this.rate,
    required this.brand,
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
    required this.model,
    required this.purpose,
    required this.acceptedNote,
    required this.ticketAddress,
    required this.region,
    required this.phoneNumber,
    required this.createdAt,
    required this.productName,
    required this.fsrDetails,
    required this.serviceDetails,
    required this.subCustomerDetails,
    required this.selectedAmc,
    required this.selectedCat,
    required this.checkpoints,
    required this.aging,
  });

  final int? id;
  final String? taskName;
  final DateTime? date;
  final String? time;
  final bool? israte;
  final bool? isamc;
  final AssignTo? assignTo;
  final CustomerDetails? customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String? totalTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<TicketCheckpoint> ticketCheckpoints;
  final int? admin;
  final String? createdBy;
  final FsrData? fsrData;
  final String? rate;
  final String? brand;
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
  final String? technicianSignature;
  final String? technicianName;
  final String? technicianNumber;
  final String? model;
  final String? purpose;
  final String? acceptedNote;
  final String? ticketAddress;
  final String? region;
  final String? phoneNumber;
  final DateTime? createdAt;
  final ProductName? productName;
  final FsrDetails? fsrDetails;
  final Service? serviceDetails;
  final CustomerDetails? subCustomerDetails;
  final SelectedAmc? selectedAmc;
  final SelectedCat? selectedCat;
  final List<int> checkpoints;
  final int? aging;

  factory TicketResult.fromJson(Map<String, dynamic> json){
    return TicketResult(
      id: json["id"],
      taskName: json["taskName"],
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      israte: json["israte"],
      isamc: json["isamc"],
      assignTo: json["assignTo"] == null ? null : AssignTo.fromJson(json["assignTo"]),
      customerDetails: json["customerDetails"] == null ? null : CustomerDetails.fromJson(json["customerDetails"]),
      technicalNotes: json["technical_notes"] == null ? [] : List<dynamic>.from(json["technical_notes"]!.map((x) => x)),
      devices: json["devices"] == null ? [] : List<dynamic>.from(json["devices"]!.map((x) => x)),
      totalTime: json["total_time"],
      startDateTime: DateTime.tryParse(json["start_date_time"] ?? ""),
      endDateTime: DateTime.tryParse(json["end_date_time"] ?? ""),
      ticketCheckpoints: json["ticket_checkpoints"] == null ? [] : List<TicketCheckpoint>.from(json["ticket_checkpoints"]!.map((x) => TicketCheckpoint.fromJson(x))),
      admin: json["admin"],
      createdBy: json["created_by"],
      fsrData: json["fsr_data"] == null ? null : FsrData.fromJson(json["fsr_data"]),
      rate: json["rate"],
      brand: json["brand"],
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
      model: json["model"],
      purpose: json["purpose"],
      acceptedNote: json["acceptedNote"],
      ticketAddress: json["ticket_address"],
      region: json["region"],
      phoneNumber: json["phone_number"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productName: json["product_name"] == null ? null : ProductName.fromJson(json["product_name"]),
      fsrDetails: json["fsrDetails"] == null ? null : FsrDetails.fromJson(json["fsrDetails"]),
      serviceDetails: json["serviceDetails"] == null ? null : Service.fromJson(json["serviceDetails"]),
      subCustomerDetails: json["subCustomerDetails"] == null ? null : CustomerDetails.fromJson(json["subCustomerDetails"]),
      selectedAmc: json["selected_amc"] == null ? null : SelectedAmc.fromJson(json["selected_amc"]),
      selectedCat: json["selected_cat"] == null ? null : SelectedCat.fromJson(json["selected_cat"]),
      checkpoints: json["checkpoints"] == null ? [] : List<int>.from(json["checkpoints"]!.map((x) => x)),
      aging: json["aging"],
    );
  }

}

class AssignTo {
  AssignTo({
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
  final DateTime? dob;
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
  final String? notes;
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

  factory AssignTo.fromJson(Map<String, dynamic> json){
    return AssignTo(
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
      dob: DateTime.tryParse(json["dob"] ?? ""),
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
  final List<ProductName> brandNames;
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
      brandNames: json["brand_names"] == null ? [] : List<ProductName>.from(json["brand_names"]!.map((x) => ProductName.fromJson(x))),
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

class ProductName {
  ProductName({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory ProductName.fromJson(Map<String, dynamic> json){
    return ProductName(
      id: json["id"],
      name: json["name"],
    );
  }

}

class FsrData {
  FsrData({
    required this.fsrName,
    required this.categoryName,
  });

  final String? fsrName;
  final dynamic? categoryName;

  factory FsrData.fromJson(Map<String, dynamic> json){
    return FsrData(
      fsrName: json["fsrName"],
      categoryName: json["categoryName"],
    );
  }

}

class SelectedCat {
  SelectedCat({
    required this.id,
    required this.name,
    required this.checkpoints,
    required this.createdBy,
    required this.admin,
    required this.checkpointNames,
  });

  final int? id;
  final String? name;
  final List<Checkpoint> checkpoints;
  final int? createdBy;
  final int? admin;
  final List<dynamic> checkpointNames;

  factory SelectedCat.fromJson(Map<String, dynamic> json){
    return SelectedCat(
      id: json["id"],
      name: json["name"],
      checkpoints: json["checkpoints"] == null ? [] : List<Checkpoint>.from(json["checkpoints"]!.map((x) => Checkpoint.fromJson(x))),
      createdBy: json["created_by"],
      admin: json["admin"],
      checkpointNames: json["checkpoint_names"] == null ? [] : List<dynamic>.from(json["checkpoint_names"]!.map((x) => x)),
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
  final List<String> checkpointStatuses;
  final String? displayType;
  final int? createdBy;
  final int? admin;

  factory Checkpoint.fromJson(Map<String, dynamic> json){
    return Checkpoint(
      id: json["id"],
      checkpointName: json["checkpoint_name"],
      checkpointStatuses: json["checkpointStatuses"] == null ? [] : List<String>.from(json["checkpointStatuses"]!.map((x) => x)),
      displayType: json["displayType"],
      createdBy: json["created_by"],
      admin: json["admin"],
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
  final List<SelectedCat> categories;
  final int? createdBy;
  final int? admin;

  factory FsrDetails.fromJson(Map<String, dynamic> json){
    return FsrDetails(
      id: json["id"],
      fsrName: json["fsrName"],
      categories: json["categories"] == null ? [] : List<SelectedCat>.from(json["categories"]!.map((x) => SelectedCat.fromJson(x))),
      createdBy: json["created_by"],
      admin: json["admin"],
    );
  }

}

class SelectedAmc {
  SelectedAmc({
    required this.amcName,
    required this.activationTime,
    required this.activationDate,
    required this.remainder,
    required this.productBrand,
    required this.serialModelNo,
    required this.underWarranty,
    required this.serviceAmount,
    required this.receivedAmount,
    required this.status,
    required this.selectServiceOccurence,
    required this.noOfService,
    required this.note,
    required this.expiry,
    required this.service,
    required this.brand,
    required this.customer,
    required this.createdBy,
    required this.admin,
    required this.id,
    required this.remainingAmount,
    required this.serviceCompleted,
    required this.createdAt,
  });

  final String? amcName;
  final String? activationTime;
  final DateTime? activationDate;
  final String? remainder;
  final String? productBrand;
  final String? serialModelNo;
  final bool? underWarranty;
  final String? serviceAmount;
  final String? receivedAmount;
  final String? status;
  final String? selectServiceOccurence;
  final String? noOfService;
  final String? note;
  final DateTime? expiry;
  final Service? service;
  final ProductName? brand;
  final CustomerDetails? customer;
  final String? createdBy;
  final int? admin;
  final int? id;
  final int? remainingAmount;
  final int? serviceCompleted;
  final DateTime? createdAt;

  factory SelectedAmc.fromJson(Map<String, dynamic> json){
    return SelectedAmc(
      amcName: json["amcName"],
      activationTime: json["activationTime"],
      activationDate: DateTime.tryParse(json["activationDate"] ?? ""),
      remainder: json["remainder"],
      productBrand: json["productBrand"],
      serialModelNo: json["serialModelNo"],
      underWarranty: json["underWarranty"],
      serviceAmount: json["serviceAmount"],
      receivedAmount: json["receivedAmount"],
      status: json["status"],
      selectServiceOccurence: json["select_service_occurence"],
      noOfService: json["no_of_service"],
      note: json["note"],
      expiry: DateTime.tryParse(json["expiry"] ?? ""),
      service: json["service"] == null ? null : Service.fromJson(json["service"]),
      brand: json["brand"] == null ? null : ProductName.fromJson(json["brand"]),
      customer: json["customer"] == null ? null : CustomerDetails.fromJson(json["customer"]),
      createdBy: json["created_by"],
      admin: json["admin"],
      id: json["id"],
      remainingAmount: json["remainingAmount"],
      serviceCompleted: json["serviceCompleted"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}

class Service {
  Service({
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
    required this.id,
  });

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
  final int? id;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
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
      id: json["id"],
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
  final String? serviceSubImage;
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

class TicketCheckpoint {
  TicketCheckpoint({
    required this.checkpoint,
    required this.status,
    required this.category,
    required this.checkpointStatuses,
    required this.displayType,
  });

  final Checkpoint? checkpoint;
  final String? status;
  final int? category;
  final String? checkpointStatuses;
  final String? displayType;

  factory TicketCheckpoint.fromJson(Map<String, dynamic> json){
    return TicketCheckpoint(
      checkpoint: json["checkpoint"] == null ? null : Checkpoint.fromJson(json["checkpoint"]),
      status: json["status"],
      category: json["category"],
      checkpointStatuses: json["checkpointStatuses"],
      displayType: json["displayType"],
    );
  }

}


//=====================================================================================================
class TicketCountsResponseModel {
  int? total;
  int? completed;
  int? rejected;
  int? ongoing;
  int? onHold;
  int? inactive;
  int? accepted;

  TicketCountsResponseModel(
      {this.total,
        this.completed,
        this.rejected,
        this.ongoing,
        this.onHold,
        this.inactive,
        this.accepted});

  TicketCountsResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    completed = json['completed'];
    rejected = json['rejected'];
    ongoing = json['ongoing'];
    onHold = json['on-hold'];
    inactive = json['inactive'];
    accepted = json['accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['completed'] = this.completed;
    data['rejected'] = this.rejected;
    data['ongoing'] = this.ongoing;
    data['on-hold'] = this.onHold;
    data['inactive'] = this.inactive;
    data['accepted'] = this.accepted;
    return data;
  }
}
//=============================================================================Ticket delete Api ===========================
class deleteTicketDataResponseModel {
  String? message;

  deleteTicketDataResponseModel({this.message});

  deleteTicketDataResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}