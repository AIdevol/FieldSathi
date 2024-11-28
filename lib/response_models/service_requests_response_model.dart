// class ServiceRequestResponseModel {
//   int? count;
//   int? totalPages;
//   int? currentPage;
//   List<ServiceRequest>? results;
//
//   ServiceRequestResponseModel(
//       {this.count, this.totalPages, this.currentPage, this.results});
//
//   ServiceRequestResponseModel.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     totalPages = json['total_pages'];
//     currentPage = json['current_page'];
//     if (json['results'] != null) {
//       results = <ServiceRequest>[];
//       json['results'].forEach((v) {
//         results!.add(new ServiceRequest.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['total_pages'] = this.totalPages;
//     data['current_page'] = this.currentPage;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ServiceRequest {
//   int? id;
//   Ticket? ticket;
//   List<MaterialRequired>? materialRequired;
//   String? status;
//   String? approvedRemark;
//   Null? dispatchedRemark;
//   Null? hubAddress;
//   Null? courierContactNumber;
//   Null? docktNo;
//   Null? whereToDispatched;
//   Null? createdBy;
//
//   ServiceRequest(
//       {this.id,
//         this.ticket,
//         this.materialRequired,
//         this.status,
//         this.approvedRemark,
//         this.dispatchedRemark,
//         this.hubAddress,
//         this.courierContactNumber,
//         this.docktNo,
//         this.whereToDispatched,
//         this.createdBy});
//
//   ServiceRequest.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     ticket =
//     json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
//     if (json['material_required'] != null) {
//       materialRequired = <MaterialRequired>[];
//       json['material_required'].forEach((v) {
//         materialRequired!.add(new MaterialRequired.fromJson(v));
//       });
//     }
//     status = json['status'];
//     approvedRemark = json['approved_remark'];
//     dispatchedRemark = json['dispatched_remark'];
//     hubAddress = json['hub_address'];
//     courierContactNumber = json['courier_contact_number'];
//     docktNo = json['dockt_no'];
//     whereToDispatched = json['where_to_dispatched'];
//     createdBy = json['created_by'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.ticket != null) {
//       data['ticket'] = this.ticket!.toJson();
//     }
//     if (this.materialRequired != null) {
//       data['material_required'] =
//           this.materialRequired!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     data['approved_remark'] = this.approvedRemark;
//     data['dispatched_remark'] = this.dispatchedRemark;
//     data['hub_address'] = this.hubAddress;
//     data['courier_contact_number'] = this.courierContactNumber;
//     data['dockt_no'] = this.docktNo;
//     data['where_to_dispatched'] = this.whereToDispatched;
//     data['created_by'] = this.createdBy;
//     return data;
//   }
// }
//
// class Ticket {
//   int? id;
//   String? taskName;
//   String? date;
//   String? time;
//   bool? israte;
//   bool? isamc;
//   AssignTo? assignTo;
//   CustomerDetails? customerDetails;
//   List<dynamic>? technicalNotes;
//   List<dynamic>? devices;
//   String? totalTime;
//   String? startDateTime;
//   String? endDateTime;
//   List<dynamic>? ticketCheckpoints;
//   int? admin;
//   String? createdBy;
//   Null? rate;
//   String? instructions;
//   String? status;
//   Null? rejectedNote;
//   Null? onholdNote;
//   String? beforeNote;
//   String? afterNote;
//   String? beforeTaskImages1;
//   Null? beforeTaskImages2;
//   Null? beforeTaskImages3;
//   String? afterTaskImages1;
//   Null? afterTaskImages2;
//   Null? afterTaskImages3;
//   String? custName;
//   String? custNumber;
//   String? custRating;
//   String? technicalNote;
//   String? workmode;
//   String? custSignature;
//   Null? technicianSignature;
//   String? technicianName;
//   String? technicianNumber;
//   String? brand;
//   Null? model;
//   String? purpose;
//   Null? acceptedNote;
//   Null? ticketAddress;
//   Null? region;
//   Null? phoneNumber;
//   String? createdAt;
//   FsrDetails? fsrDetails;
//   Null? serviceDetails;
//   SubCustomerDetails? subCustomerDetails;
//   List<dynamic>? checkpoints;
//
//   Ticket(
//       {this.id,
//         this.taskName,
//         this.date,
//         this.time,
//         this.israte,
//         this.isamc,
//         this.assignTo,
//         this.customerDetails,
//         this.technicalNotes,
//         this.devices,
//         this.totalTime,
//         this.startDateTime,
//         this.endDateTime,
//         this.ticketCheckpoints,
//         this.admin,
//         this.createdBy,
//         this.rate,
//         this.instructions,
//         this.status,
//         this.rejectedNote,
//         this.onholdNote,
//         this.beforeNote,
//         this.afterNote,
//         this.beforeTaskImages1,
//         this.beforeTaskImages2,
//         this.beforeTaskImages3,
//         this.afterTaskImages1,
//         this.afterTaskImages2,
//         this.afterTaskImages3,
//         this.custName,
//         this.custNumber,
//         this.custRating,
//         this.technicalNote,
//         this.workmode,
//         this.custSignature,
//         this.technicianSignature,
//         this.technicianName,
//         this.technicianNumber,
//         this.brand,
//         this.model,
//         this.purpose,
//         this.acceptedNote,
//         this.ticketAddress,
//         this.region,
//         this.phoneNumber,
//         this.createdAt,
//         this.fsrDetails,
//         this.serviceDetails,
//         this.subCustomerDetails,
//         this.checkpoints});
//
//   Ticket.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     taskName = json['taskName'];
//     date = json['date'];
//     time = json['time'];
//     israte = json['israte'];
//     isamc = json['isamc'];
//     assignTo = json['assignTo'] != null
//         ? new AssignTo.fromJson(json['assignTo'])
//         : null;
//     customerDetails = json['customerDetails'] != null
//         ? new CustomerDetails.fromJson(json['customerDetails'])
//         : null;
//     technicalNotes = json['technical_notes'].cast<dynamic>();
//     // if (json['technical_notes'] != null) {
//     //   technicalNotes = <Null>[];
//     //   json['technical_notes'].forEach((v) {
//     //     technicalNotes!.add(new Null.fromJson(v));
//     //   });
//     // }
//     devices = json['devices'].cast<dynamic>();
//     // if (json['devices'] != null) {
//     //   devices = <Null>[];
//     //   json['devices'].forEach((v) {
//     //     devices!.add(new Null.fromJson(v));
//     //   });
//     // }
//     totalTime = json['total_time'];
//     startDateTime = json['start_date_time'];
//     endDateTime = json['end_date_time'];
//     ticketCheckpoints = json['ticket_checkpoints'].cast<dynamic>();
//     // if (json['ticket_checkpoints'] != null) {
//     //   ticketCheckpoints = <Null>[];
//     //   json['ticket_checkpoints'].forEach((v) {
//     //     ticketCheckpoints!.add(new Null.fromJson(v));
//     //   });
//     // }
//     admin = json['admin'];
//     createdBy = json['created_by'];
//     rate = json['rate'];
//     instructions = json['instructions'];
//     status = json['status'];
//     rejectedNote = json['rejected_note'];
//     onholdNote = json['onhold_note'];
//     beforeNote = json['before_note'];
//     afterNote = json['after_note'];
//     beforeTaskImages1 = json['before_task_images_1'];
//     beforeTaskImages2 = json['before_task_images_2'];
//     beforeTaskImages3 = json['before_task_images_3'];
//     afterTaskImages1 = json['after_task_images_1'];
//     afterTaskImages2 = json['after_task_images_2'];
//     afterTaskImages3 = json['after_task_images_3'];
//     custName = json['cust_name'];
//     custNumber = json['cust_number'];
//     custRating = json['cust_rating'];
//     technicalNote = json['technical_note'];
//     workmode = json['workmode'];
//     custSignature = json['cust_signature'];
//     technicianSignature = json['technician_signature'];
//     technicianName = json['technician_name'];
//     technicianNumber = json['technician_number'];
//     brand = json['brand'];
//     model = json['model'];
//     purpose = json['purpose'];
//     acceptedNote = json['acceptedNote'];
//     ticketAddress = json['ticket_address'];
//     region = json['region'];
//     phoneNumber = json['phone_number'];
//     createdAt = json['created_at'];
//     fsrDetails = json['fsrDetails'] != null
//         ? new FsrDetails.fromJson(json['fsrDetails'])
//         : null;
//     serviceDetails = json['serviceDetails'];
//     subCustomerDetails = json['subCustomerDetails'] != null
//         ? new SubCustomerDetails.fromJson(json['subCustomerDetails'])
//         : null;
//     checkpoints = json['checkpoints'].cast<dynamic>();
//     // if (json['checkpoints'] != null) {
//     //   checkpoints = <Null>[];
//     //   json['checkpoints'].forEach((v) {
//     //     checkpoints!.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['taskName'] = this.taskName;
//     data['date'] = this.date;
//     data['time'] = this.time;
//     data['israte'] = this.israte;
//     data['isamc'] = this.isamc;
//     if (this.assignTo != null) {
//       data['assignTo'] = this.assignTo!.toJson();
//     }
//     if (this.customerDetails != null) {
//       data['customerDetails'] = this.customerDetails!.toJson();
//     }
//     if (this.technicalNotes != null) {
//       data['technical_notes'] =
//           this.technicalNotes!.map((v) => v.toJson()).toList();
//     }
//     if (this.devices != null) {
//       data['devices'] = this.devices!.map((v) => v.toJson()).toList();
//     }
//     data['total_time'] = this.totalTime;
//     data['start_date_time'] = this.startDateTime;
//     data['end_date_time'] = this.endDateTime;
//     if (this.ticketCheckpoints != null) {
//       data['ticket_checkpoints'] =
//           this.ticketCheckpoints!.map((v) => v.toJson()).toList();
//     }
//     data['admin'] = this.admin;
//     data['created_by'] = this.createdBy;
//     data['rate'] = this.rate;
//     data['instructions'] = this.instructions;
//     data['status'] = this.status;
//     data['rejected_note'] = this.rejectedNote;
//     data['onhold_note'] = this.onholdNote;
//     data['before_note'] = this.beforeNote;
//     data['after_note'] = this.afterNote;
//     data['before_task_images_1'] = this.beforeTaskImages1;
//     data['before_task_images_2'] = this.beforeTaskImages2;
//     data['before_task_images_3'] = this.beforeTaskImages3;
//     data['after_task_images_1'] = this.afterTaskImages1;
//     data['after_task_images_2'] = this.afterTaskImages2;
//     data['after_task_images_3'] = this.afterTaskImages3;
//     data['cust_name'] = this.custName;
//     data['cust_number'] = this.custNumber;
//     data['cust_rating'] = this.custRating;
//     data['technical_note'] = this.technicalNote;
//     data['workmode'] = this.workmode;
//     data['cust_signature'] = this.custSignature;
//     data['technician_signature'] = this.technicianSignature;
//     data['technician_name'] = this.technicianName;
//     data['technician_number'] = this.technicianNumber;
//     data['brand'] = this.brand;
//     data['model'] = this.model;
//     data['purpose'] = this.purpose;
//     data['acceptedNote'] = this.acceptedNote;
//     data['ticket_address'] = this.ticketAddress;
//     data['region'] = this.region;
//     data['phone_number'] = this.phoneNumber;
//     data['created_at'] = this.createdAt;
//     if (this.fsrDetails != null) {
//       data['fsrDetails'] = this.fsrDetails!.toJson();
//     }
//     data['serviceDetails'] = this.serviceDetails;
//     if (this.subCustomerDetails != null) {
//       data['subCustomerDetails'] = this.subCustomerDetails!.toJson();
//     }
//     if (this.checkpoints != null) {
//       data['checkpoints'] = this.checkpoints!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AssignTo {
//   int? id;
//   TodayAttendance? todayAttendance;
//   List<dynamic>? brandNames;
//   Null? lastLogin;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phoneNumber;
//   String? companyName;
//   String? employees;
//   Null? dob;
//   String? otp;
//   bool? otpVerified;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isActive;
//   Null? profileImage;
//   Null? customerName;
//   Null? customerTag;
//   Null? modelNo;
//   Null? socialId;
//   bool? deactivate;
//   String? role;
//   Null? customerType;
//   String? batteryStatus;
//   bool? gpsStatus;
//   String? longitude;
//   String? latitude;
//   Null? companyAddress;
//   Null? companyCity;
//   Null? companyState;
//   Null? companyPincode;
//   Null? companyCountry;
//   Null? companyRegion;
//   Null? companyLandlineNo;
//   Null? gstNo;
//   Null? cinNo;
//   Null? panNo;
//   Null? companyContactNo;
//   Null? companyWebsite;
//   Null? bankName;
//   Null? ifscSwift;
//   Null? accountNumber;
//   Null? branchAddress;
//   Null? upiId;
//   Null? paymentLink;
//   Null? fileUpload;
//   Null? primaryAddress;
//   Null? landmarkPaci;
//   Null? notes;
//   Null? state;
//   Null? country;
//   Null? city;
//   Null? zipcode;
//   Null? region;
//   int? allocatedSickLeave;
//   int? allocatedCasualLeave;
//   String? dateJoined;
//   int? maxEmployeesAllowed;
//   int? employeesCreated;
//   bool? isLeaveAllocated;
//   String? empId;
//   bool? isDisabled;
//   String? createdAt;
//   String? createdBy;
//   int? admin;
//   Null? customerId;
//   Null? subscription;
//
//   AssignTo(
//       {this.id,
//         this.todayAttendance,
//         this.brandNames,
//         this.lastLogin,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phoneNumber,
//         this.companyName,
//         this.employees,
//         this.dob,
//         this.otp,
//         this.otpVerified,
//         this.isStaff,
//         this.isSuperuser,
//         this.isActive,
//         this.profileImage,
//         this.customerName,
//         this.customerTag,
//         this.modelNo,
//         this.socialId,
//         this.deactivate,
//         this.role,
//         this.customerType,
//         this.batteryStatus,
//         this.gpsStatus,
//         this.longitude,
//         this.latitude,
//         this.companyAddress,
//         this.companyCity,
//         this.companyState,
//         this.companyPincode,
//         this.companyCountry,
//         this.companyRegion,
//         this.companyLandlineNo,
//         this.gstNo,
//         this.cinNo,
//         this.panNo,
//         this.companyContactNo,
//         this.companyWebsite,
//         this.bankName,
//         this.ifscSwift,
//         this.accountNumber,
//         this.branchAddress,
//         this.upiId,
//         this.paymentLink,
//         this.fileUpload,
//         this.primaryAddress,
//         this.landmarkPaci,
//         this.notes,
//         this.state,
//         this.country,
//         this.city,
//         this.zipcode,
//         this.region,
//         this.allocatedSickLeave,
//         this.allocatedCasualLeave,
//         this.dateJoined,
//         this.maxEmployeesAllowed,
//         this.employeesCreated,
//         this.isLeaveAllocated,
//         this.empId,
//         this.isDisabled,
//         this.createdAt,
//         this.createdBy,
//         this.admin,
//         this.customerId,
//         this.subscription});
//
//   AssignTo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     todayAttendance = json['today_attendance'] != null
//         ? new TodayAttendance.fromJson(json['today_attendance'])
//         : null;
//     brandNames = json['brand_names'].cast<dynamic>();
//     // if (json['brand_names'] != null) {
//     //   brandNames = <Null>[];
//     //   json['brand_names'].forEach((v) {
//     //     brandNames!.add(new Null.fromJson(v));
//     //   });
//     // }
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
//     companyAddress = json['companyAddress'];
//     companyCity = json['companyCity'];
//     companyState = json['companyState'];
//     companyPincode = json['companyPincode'];
//     companyCountry = json['companyCountry'];
//     companyRegion = json['companyRegion'];
//     companyLandlineNo = json['companyLandlineNo'];
//     gstNo = json['gstNo'];
//     cinNo = json['cinNo'];
//     panNo = json['panNo'];
//     companyContactNo = json['companyContactNo'];
//     companyWebsite = json['companyWebsite'];
//     bankName = json['bankName'];
//     ifscSwift = json['ifscSwift'];
//     accountNumber = json['accountNumber'];
//     branchAddress = json['branchAddress'];
//     upiId = json['upiId'];
//     paymentLink = json['paymentLink'];
//     fileUpload = json['fileUpload'];
//     primaryAddress = json['primary_address'];
//     landmarkPaci = json['landmark_paci'];
//     notes = json['notes'];
//     state = json['state'];
//     country = json['country'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     region = json['region'];
//     allocatedSickLeave = json['allocated_sick_leave'];
//     allocatedCasualLeave = json['allocated_casual_leave'];
//     dateJoined = json['date_joined'];
//     maxEmployeesAllowed = json['max_employees_allowed'];
//     employeesCreated = json['employees_created'];
//     isLeaveAllocated = json['is_leave_allocated'];
//     empId = json['emp_id'];
//     isDisabled = json['is_disabled'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//     customerId = json['customer_id'];
//     subscription = json['subscription'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.todayAttendance != null) {
//       data['today_attendance'] = this.todayAttendance!.toJson();
//     }
//     if (this.brandNames != null) {
//       data['brand_names'] = this.brandNames!.map((v) => v.toJson()).toList();
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
//     data['companyAddress'] = this.companyAddress;
//     data['companyCity'] = this.companyCity;
//     data['companyState'] = this.companyState;
//     data['companyPincode'] = this.companyPincode;
//     data['companyCountry'] = this.companyCountry;
//     data['companyRegion'] = this.companyRegion;
//     data['companyLandlineNo'] = this.companyLandlineNo;
//     data['gstNo'] = this.gstNo;
//     data['cinNo'] = this.cinNo;
//     data['panNo'] = this.panNo;
//     data['companyContactNo'] = this.companyContactNo;
//     data['companyWebsite'] = this.companyWebsite;
//     data['bankName'] = this.bankName;
//     data['ifscSwift'] = this.ifscSwift;
//     data['accountNumber'] = this.accountNumber;
//     data['branchAddress'] = this.branchAddress;
//     data['upiId'] = this.upiId;
//     data['paymentLink'] = this.paymentLink;
//     data['fileUpload'] = this.fileUpload;
//     data['primary_address'] = this.primaryAddress;
//     data['landmark_paci'] = this.landmarkPaci;
//     data['notes'] = this.notes;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['region'] = this.region;
//     data['allocated_sick_leave'] = this.allocatedSickLeave;
//     data['allocated_casual_leave'] = this.allocatedCasualLeave;
//     data['date_joined'] = this.dateJoined;
//     data['max_employees_allowed'] = this.maxEmployeesAllowed;
//     data['employees_created'] = this.employeesCreated;
//     data['is_leave_allocated'] = this.isLeaveAllocated;
//     data['emp_id'] = this.empId;
//     data['is_disabled'] = this.isDisabled;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     data['customer_id'] = this.customerId;
//     data['subscription'] = this.subscription;
//     return data;
//   }
// }
//
// class TodayAttendance {
//   int? id;
//   int? user;
//   Null? punchIn;
//   Null? punchOut;
//   String? status;
//   String? date;
//
//   TodayAttendance(
//       {this.id,
//         this.user,
//         this.punchIn,
//         this.punchOut,
//         this.status,
//         this.date});
//
//   TodayAttendance.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'];
//     punchIn = json['punch_in'];
//     punchOut = json['punch_out'];
//     status = json['status'];
//     date = json['date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user'] = this.user;
//     data['punch_in'] = this.punchIn;
//     data['punch_out'] = this.punchOut;
//     data['status'] = this.status;
//     data['date'] = this.date;
//     return data;
//   }
// }
//
// class CustomerDetails {
//   int? id;
//   TodayAttendance? todayAttendance;
//   List<String>? brandNames;
//   Null? lastLogin;
//   Null? firstName;
//   Null? lastName;
//   String? email;
//   String? phoneNumber;
//   String? companyName;
//   String? employees;
//   Null? dob;
//   String? otp;
//   bool? otpVerified;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isActive;
//   Null? profileImage;
//   String? customerName;
//   Null? customerTag;
//   String? modelNo;
//   Null? socialId;
//   bool? deactivate;
//   String? role;
//   String? customerType;
//   Null? batteryStatus;
//   bool? gpsStatus;
//   Null? longitude;
//   Null? latitude;
//   Null? companyAddress;
//   Null? companyCity;
//   Null? companyState;
//   Null? companyPincode;
//   Null? companyCountry;
//   Null? companyRegion;
//   Null? companyLandlineNo;
//   Null? gstNo;
//   Null? cinNo;
//   Null? panNo;
//   Null? companyContactNo;
//   Null? companyWebsite;
//   Null? bankName;
//   Null? ifscSwift;
//   Null? accountNumber;
//   Null? branchAddress;
//   Null? upiId;
//   Null? paymentLink;
//   Null? fileUpload;
//   String? primaryAddress;
//   String? landmarkPaci;
//   Null? notes;
//   String? state;
//   String? country;
//   String? city;
//   String? zipcode;
//   String? region;
//   int? allocatedSickLeave;
//   int? allocatedCasualLeave;
//   Null? dateJoined;
//   int? maxEmployeesAllowed;
//   int? employeesCreated;
//   bool? isLeaveAllocated;
//   Null? empId;
//   bool? isDisabled;
//   String? createdAt;
//   String? createdBy;
//   int? admin;
//   Null? customerId;
//   Null? subscription;
//
//   CustomerDetails(
//       {this.id,
//         this.todayAttendance,
//         this.brandNames,
//         this.lastLogin,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phoneNumber,
//         this.companyName,
//         this.employees,
//         this.dob,
//         this.otp,
//         this.otpVerified,
//         this.isStaff,
//         this.isSuperuser,
//         this.isActive,
//         this.profileImage,
//         this.customerName,
//         this.customerTag,
//         this.modelNo,
//         this.socialId,
//         this.deactivate,
//         this.role,
//         this.customerType,
//         this.batteryStatus,
//         this.gpsStatus,
//         this.longitude,
//         this.latitude,
//         this.companyAddress,
//         this.companyCity,
//         this.companyState,
//         this.companyPincode,
//         this.companyCountry,
//         this.companyRegion,
//         this.companyLandlineNo,
//         this.gstNo,
//         this.cinNo,
//         this.panNo,
//         this.companyContactNo,
//         this.companyWebsite,
//         this.bankName,
//         this.ifscSwift,
//         this.accountNumber,
//         this.branchAddress,
//         this.upiId,
//         this.paymentLink,
//         this.fileUpload,
//         this.primaryAddress,
//         this.landmarkPaci,
//         this.notes,
//         this.state,
//         this.country,
//         this.city,
//         this.zipcode,
//         this.region,
//         this.allocatedSickLeave,
//         this.allocatedCasualLeave,
//         this.dateJoined,
//         this.maxEmployeesAllowed,
//         this.employeesCreated,
//         this.isLeaveAllocated,
//         this.empId,
//         this.isDisabled,
//         this.createdAt,
//         this.createdBy,
//         this.admin,
//         this.customerId,
//         this.subscription});
//
//   CustomerDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     todayAttendance = json['today_attendance'] != null
//         ? new TodayAttendance.fromJson(json['today_attendance'])
//         : null;
//     brandNames = json['brand_names'].cast<String>();
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
//     companyAddress = json['companyAddress'];
//     companyCity = json['companyCity'];
//     companyState = json['companyState'];
//     companyPincode = json['companyPincode'];
//     companyCountry = json['companyCountry'];
//     companyRegion = json['companyRegion'];
//     companyLandlineNo = json['companyLandlineNo'];
//     gstNo = json['gstNo'];
//     cinNo = json['cinNo'];
//     panNo = json['panNo'];
//     companyContactNo = json['companyContactNo'];
//     companyWebsite = json['companyWebsite'];
//     bankName = json['bankName'];
//     ifscSwift = json['ifscSwift'];
//     accountNumber = json['accountNumber'];
//     branchAddress = json['branchAddress'];
//     upiId = json['upiId'];
//     paymentLink = json['paymentLink'];
//     fileUpload = json['fileUpload'];
//     primaryAddress = json['primary_address'];
//     landmarkPaci = json['landmark_paci'];
//     notes = json['notes'];
//     state = json['state'];
//     country = json['country'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     region = json['region'];
//     allocatedSickLeave = json['allocated_sick_leave'];
//     allocatedCasualLeave = json['allocated_casual_leave'];
//     dateJoined = json['date_joined'];
//     maxEmployeesAllowed = json['max_employees_allowed'];
//     employeesCreated = json['employees_created'];
//     isLeaveAllocated = json['is_leave_allocated'];
//     empId = json['emp_id'];
//     isDisabled = json['is_disabled'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//     customerId = json['customer_id'];
//     subscription = json['subscription'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.todayAttendance != null) {
//       data['today_attendance'] = this.todayAttendance!.toJson();
//     }
//     data['brand_names'] = this.brandNames;
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
//     data['companyAddress'] = this.companyAddress;
//     data['companyCity'] = this.companyCity;
//     data['companyState'] = this.companyState;
//     data['companyPincode'] = this.companyPincode;
//     data['companyCountry'] = this.companyCountry;
//     data['companyRegion'] = this.companyRegion;
//     data['companyLandlineNo'] = this.companyLandlineNo;
//     data['gstNo'] = this.gstNo;
//     data['cinNo'] = this.cinNo;
//     data['panNo'] = this.panNo;
//     data['companyContactNo'] = this.companyContactNo;
//     data['companyWebsite'] = this.companyWebsite;
//     data['bankName'] = this.bankName;
//     data['ifscSwift'] = this.ifscSwift;
//     data['accountNumber'] = this.accountNumber;
//     data['branchAddress'] = this.branchAddress;
//     data['upiId'] = this.upiId;
//     data['paymentLink'] = this.paymentLink;
//     data['fileUpload'] = this.fileUpload;
//     data['primary_address'] = this.primaryAddress;
//     data['landmark_paci'] = this.landmarkPaci;
//     data['notes'] = this.notes;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['region'] = this.region;
//     data['allocated_sick_leave'] = this.allocatedSickLeave;
//     data['allocated_casual_leave'] = this.allocatedCasualLeave;
//     data['date_joined'] = this.dateJoined;
//     data['max_employees_allowed'] = this.maxEmployeesAllowed;
//     data['employees_created'] = this.employeesCreated;
//     data['is_leave_allocated'] = this.isLeaveAllocated;
//     data['emp_id'] = this.empId;
//     data['is_disabled'] = this.isDisabled;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     data['customer_id'] = this.customerId;
//     data['subscription'] = this.subscription;
//     return data;
//   }
// }
//
// class FsrDetails {
//   String? fsrName;
//   List<dynamic>? categories;
//
//   FsrDetails({this.fsrName, this.categories});
//
//   FsrDetails.fromJson(Map<String, dynamic> json) {
//     fsrName = json['fsrName'];
//     categories = json['categories'].cast<dynamic>();
//     // if (json['categories'] != null) {
//     //   categories = <dynamic>[];
//     //   json['categories'].forEach((v) {
//     //     categories!.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['fsrName'] = this.fsrName;
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SubCustomerDetails {
//   String? password;
//   Null? lastLogin;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phoneNumber;
//   String? companyName;
//   String? employees;
//   Null? dob;
//   String? otp;
//   bool? otpVerified;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isActive;
//   Null? profileImage;
//   String? customerName;
//   String? customerTag;
//   String? modelNo;
//   String? socialId;
//   Null? deactivate;
//   Null? role;
//   String? customerType;
//   String? batteryStatus;
//   Null? gpsStatus;
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
//   Null? fileUpload;
//   String? primaryAddress;
//   String? landmarkPaci;
//   String? notes;
//   String? state;
//   String? country;
//   String? city;
//   String? zipcode;
//   String? region;
//   Null? allocatedSickLeave;
//   Null? allocatedCasualLeave;
//   Null? dateJoined;
//   Null? maxEmployeesAllowed;
//   Null? employeesCreated;
//   bool? isLeaveAllocated;
//   String? empId;
//   bool? isDisabled;
//   Null? createdBy;
//   Null? customerId;
//   Null? subscription;
//
//   SubCustomerDetails(
//       {this.password,
//         this.lastLogin,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phoneNumber,
//         this.companyName,
//         this.employees,
//         this.dob,
//         this.otp,
//         this.otpVerified,
//         this.isStaff,
//         this.isSuperuser,
//         this.isActive,
//         this.profileImage,
//         this.customerName,
//         this.customerTag,
//         this.modelNo,
//         this.socialId,
//         this.deactivate,
//         this.role,
//         this.customerType,
//         this.batteryStatus,
//         this.gpsStatus,
//         this.longitude,
//         this.latitude,
//         this.companyAddress,
//         this.companyCity,
//         this.companyState,
//         this.companyPincode,
//         this.companyCountry,
//         this.companyRegion,
//         this.companyLandlineNo,
//         this.gstNo,
//         this.cinNo,
//         this.panNo,
//         this.companyContactNo,
//         this.companyWebsite,
//         this.bankName,
//         this.ifscSwift,
//         this.accountNumber,
//         this.branchAddress,
//         this.upiId,
//         this.paymentLink,
//         this.fileUpload,
//         this.primaryAddress,
//         this.landmarkPaci,
//         this.notes,
//         this.state,
//         this.country,
//         this.city,
//         this.zipcode,
//         this.region,
//         this.allocatedSickLeave,
//         this.allocatedCasualLeave,
//         this.dateJoined,
//         this.maxEmployeesAllowed,
//         this.employeesCreated,
//         this.isLeaveAllocated,
//         this.empId,
//         this.isDisabled,
//         this.createdBy,
//         this.customerId,
//         this.subscription});
//
//   SubCustomerDetails.fromJson(Map<String, dynamic> json) {
//     password = json['password'];
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
//     companyAddress = json['companyAddress'];
//     companyCity = json['companyCity'];
//     companyState = json['companyState'];
//     companyPincode = json['companyPincode'];
//     companyCountry = json['companyCountry'];
//     companyRegion = json['companyRegion'];
//     companyLandlineNo = json['companyLandlineNo'];
//     gstNo = json['gstNo'];
//     cinNo = json['cinNo'];
//     panNo = json['panNo'];
//     companyContactNo = json['companyContactNo'];
//     companyWebsite = json['companyWebsite'];
//     bankName = json['bankName'];
//     ifscSwift = json['ifscSwift'];
//     accountNumber = json['accountNumber'];
//     branchAddress = json['branchAddress'];
//     upiId = json['upiId'];
//     paymentLink = json['paymentLink'];
//     fileUpload = json['fileUpload'];
//     primaryAddress = json['primary_address'];
//     landmarkPaci = json['landmark_paci'];
//     notes = json['notes'];
//     state = json['state'];
//     country = json['country'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     region = json['region'];
//     allocatedSickLeave = json['allocated_sick_leave'];
//     allocatedCasualLeave = json['allocated_casual_leave'];
//     dateJoined = json['date_joined'];
//     maxEmployeesAllowed = json['max_employees_allowed'];
//     employeesCreated = json['employees_created'];
//     isLeaveAllocated = json['is_leave_allocated'];
//     empId = json['emp_id'];
//     isDisabled = json['is_disabled'];
//     createdBy = json['created_by'];
//     customerId = json['customer_id'];
//     subscription = json['subscription'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['password'] = this.password;
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
//     data['companyAddress'] = this.companyAddress;
//     data['companyCity'] = this.companyCity;
//     data['companyState'] = this.companyState;
//     data['companyPincode'] = this.companyPincode;
//     data['companyCountry'] = this.companyCountry;
//     data['companyRegion'] = this.companyRegion;
//     data['companyLandlineNo'] = this.companyLandlineNo;
//     data['gstNo'] = this.gstNo;
//     data['cinNo'] = this.cinNo;
//     data['panNo'] = this.panNo;
//     data['companyContactNo'] = this.companyContactNo;
//     data['companyWebsite'] = this.companyWebsite;
//     data['bankName'] = this.bankName;
//     data['ifscSwift'] = this.ifscSwift;
//     data['accountNumber'] = this.accountNumber;
//     data['branchAddress'] = this.branchAddress;
//     data['upiId'] = this.upiId;
//     data['paymentLink'] = this.paymentLink;
//     data['fileUpload'] = this.fileUpload;
//     data['primary_address'] = this.primaryAddress;
//     data['landmark_paci'] = this.landmarkPaci;
//     data['notes'] = this.notes;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['region'] = this.region;
//     data['allocated_sick_leave'] = this.allocatedSickLeave;
//     data['allocated_casual_leave'] = this.allocatedCasualLeave;
//     data['date_joined'] = this.dateJoined;
//     data['max_employees_allowed'] = this.maxEmployeesAllowed;
//     data['employees_created'] = this.employeesCreated;
//     data['is_leave_allocated'] = this.isLeaveAllocated;
//     data['emp_id'] = this.empId;
//     data['is_disabled'] = this.isDisabled;
//     data['created_by'] = this.createdBy;
//     data['customer_id'] = this.customerId;
//     data['subscription'] = this.subscription;
//     return data;
//   }
// }
//
// class MaterialRequired {
//   String? name;
//
//   MaterialRequired({this.name});
//
//   MaterialRequired.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
class ServiceRequestResponseModel {
  ServiceRequestResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  final int? count;
  final int? totalPages;
  final int? currentPage;
  final List<ServiceRequest> results;

  factory ServiceRequestResponseModel.fromJson(Map<String, dynamic> json){
    return ServiceRequestResponseModel(
      count: json["count"],
      totalPages: json["total_pages"],
      currentPage: json["current_page"],
      results: json["results"] == null ? [] : List<ServiceRequest>.from(json["results"]!.map((x) => ServiceRequest.fromJson(x))),
    );
  }

}

class ServiceRequest {
  ServiceRequest({
    required this.id,
    required this.ticket,
    required this.materialRequired,
    required this.status,
    required this.approvedRemark,
    required this.dispatchedRemark,
    required this.hubAddress,
    required this.courierContactNumber,
    required this.docktNo,
    required this.whereToDispatched,
    required this.createdBy,
  });

  final int? id;
  final Ticket? ticket;
  final List<MaterialRequired> materialRequired;
  final String? status;
  final String? approvedRemark;
  final dynamic dispatchedRemark;
  final dynamic hubAddress;
  final dynamic courierContactNumber;
  final dynamic docktNo;
  final dynamic whereToDispatched;
  final dynamic createdBy;

  factory ServiceRequest.fromJson(Map<String, dynamic> json){
    return ServiceRequest(
      id: json["id"],
      ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
      materialRequired: json["material_required"] == null ? [] : List<MaterialRequired>.from(json["material_required"]!.map((x) => MaterialRequired.fromJson(x))),
      status: json["status"],
      approvedRemark: json["approved_remark"],
      dispatchedRemark: json["dispatched_remark"],
      hubAddress: json["hub_address"],
      courierContactNumber: json["courier_contact_number"],
      docktNo: json["dockt_no"],
      whereToDispatched: json["where_to_dispatched"],
      createdBy: json["created_by"],
    );
  }

}

class MaterialRequired {
  MaterialRequired({
    required this.name,
  });

  final String? name;

  factory MaterialRequired.fromJson(Map<String, dynamic> json){
    return MaterialRequired(
      name: json["name"],
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
    required this.checkpoints,
  });

  final int? id;
  final String? taskName;
  final DateTime? date;
  final String? time;
  final bool? israte;
  final bool? isamc;
  final AssignTo? assignTo;
  final AssignTo? customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String? totalTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int? admin;
  final String? createdBy;
  final dynamic rate;
  final String? instructions;
  final String? status;
  final dynamic rejectedNote;
  final dynamic onholdNote;
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
  final dynamic model;
  final String? purpose;
  final dynamic acceptedNote;
  final dynamic ticketAddress;
  final dynamic region;
  final dynamic phoneNumber;
  final DateTime? createdAt;
  final FsrDetails? fsrDetails;
  final dynamic serviceDetails;
  final AssignTo? subCustomerDetails;
  final List<dynamic> checkpoints;

  factory Ticket.fromJson(Map<String, dynamic> json){
    return Ticket(
      id: json["id"],
      taskName: json["taskName"],
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      israte: json["israte"],
      isamc: json["isamc"],
      assignTo: json["assignTo"] == null ? null : AssignTo.fromJson(json["assignTo"]),
      customerDetails: json["customerDetails"] == null ? null : AssignTo.fromJson(json["customerDetails"]),
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
      serviceDetails: json["serviceDetails"],
      subCustomerDetails: json["subCustomerDetails"] == null ? null : AssignTo.fromJson(json["subCustomerDetails"]),
      checkpoints: json["checkpoints"] == null ? [] : List<dynamic>.from(json["checkpoints"]!.map((x) => x)),
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
    required this.password,
  });

  final int? id;
  final TodayAttendance? todayAttendance;
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
  final String? password;

  factory AssignTo.fromJson(Map<String, dynamic> json){
    return AssignTo(
      id: json["id"],
      todayAttendance: json["today_attendance"] == null ? null : TodayAttendance.fromJson(json["today_attendance"]),
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
      password: json["password"],
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

class FsrDetails {
  FsrDetails({
    required this.fsrName,
    required this.categories,
  });

  final String? fsrName;
  final List<dynamic> categories;

  factory FsrDetails.fromJson(Map<String, dynamic> json){
    return FsrDetails(
      fsrName: json["fsrName"],
      categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
    );
  }

}
