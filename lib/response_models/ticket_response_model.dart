// class TicketResponseModel {
//   int? id;
//   String? taskName;
//   String? date;
//   String? time;
//   bool? israte;
//   bool? isamc;
//   AssignTo? assignTo;
//   AssignTo? customerDetails;
//   List<Null>? technicalNotes;
//   List<Null>? devices;
//   String? totalTime;
//   Null? startDateTime;
//   Null? endDateTime;
//   List<Null>? ticketCheckpoints;
//   int? admin;
//   String? createdBy;
//   Null? rate;
//   String? instructions;
//   String? status;
//   Null? rejectedNote;
//   Null? onholdNote;
//   Null? beforeNote;
//   Null? afterNote;
//   Null? beforeTaskImages1;
//   Null? beforeTaskImages2;
//   Null? beforeTaskImages3;
//   Null? afterTaskImages1;
//   Null? afterTaskImages2;
//   Null? afterTaskImages3;
//   Null? custName;
//   Null? custNumber;
//   Null? custRating;
//   Null? technicalNote;
//   Null? workmode;
//   Null? custSignature;
//   Null? technicianSignature;
//   Null? technicianName;
//   Null? technicianNumber;
//   String? brand;
//   String? model;
//   Null? purpose;
//   Null? acceptedNote;
//   TicketAddress? ticketAddress;
//   FsrDetails? fsrDetails;
//   ServiceDetails? serviceDetails;
//   SubCustomerDetails? subCustomerDetails;
//   List<Null>? checkpoints;
//   int? aging;
//
//   TicketResponseModel(
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
//         this.fsrDetails,
//         this.serviceDetails,
//         this.subCustomerDetails,
//         this.checkpoints,
//         this.aging});
//
//   TicketResponseModel.fromJson(Map<String, dynamic> json) {
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
//         ? new AssignTo.fromJson(json['customerDetails'])
//         : null;
//     if (json['technical_notes'] != null) {
//       technicalNotes = <Null>[];
//       json['technical_notes'].forEach((v) {
//         technicalNotes!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['devices'] != null) {
//       devices = <Null>[];
//       json['devices'].forEach((v) {
//         devices!.add(new Null.fromJson(v));
//       });
//     }
//     totalTime = json['total_time'];
//     startDateTime = json['start_date_time'];
//     endDateTime = json['end_date_time'];
//     if (json['ticket_checkpoints'] != null) {
//       ticketCheckpoints = <Null>[];
//       json['ticket_checkpoints'].forEach((v) {
//         ticketCheckpoints!.add(new Null.fromJson(v));
//       });
//     }
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
//     ticketAddress = json['ticket_address'] != null
//         ? new TicketAddress.fromJson(json['ticket_address'])
//         : null;
//     fsrDetails = json['fsrDetails'] != null
//         ? new FsrDetails.fromJson(json['fsrDetails'])
//         : null;
//     serviceDetails = json['serviceDetails'] != null
//         ? new ServiceDetails.fromJson(json['serviceDetails'])
//         : null;
//     subCustomerDetails = json['subCustomerDetails'] != null
//         ? new SubCustomerDetails.fromJson(json['subCustomerDetails'])
//         : null;
//     if (json['checkpoints'] != null) {
//       checkpoints = <Null>[];
//       json['checkpoints'].forEach((v) {
//         checkpoints!.add(new Null.fromJson(v));
//       });
//     }
//     aging = json['aging'];
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
//     if (this.ticketAddress != null) {
//       data['ticket_address'] = this.ticketAddress!.toJson();
//     }
//     if (this.fsrDetails != null) {
//       data['fsrDetails'] = this.fsrDetails!.toJson();
//     }
//     if (this.serviceDetails != null) {
//       data['serviceDetails'] = this.serviceDetails!.toJson();
//     }
//     if (this.subCustomerDetails != null) {
//       data['subCustomerDetails'] = this.subCustomerDetails!.toJson();
//     }
//     if (this.checkpoints != null) {
//       data['checkpoints'] = this.checkpoints!.map((v) => v.toJson()).toList();
//     }
//     data['aging'] = this.aging;
//     return data;
//   }
// }
//
// class AssignTo {
//   int? id;
//   Null? todayAttendance;
//   List<Null>? brandNames;
//   Null? lastLogin;
//   String? firstName;
//   String? lastName;
//   String? email;
//   Null? phoneNumber;
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
//   Null? primaryAddress;
//   Null? landmarkPaci;
//   Null? notes;
//   Null? state;
//   String? country;
//   Null? city;
//   Null? zipcode;
//   Null? region;
//   int? allocatedSickLeave;
//   int? allocatedCasualLeave;
//   Null? dateJoined;
//   Null? createdBy;
//   Null? admin;
//   Null? customerId;
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
//         this.createdBy,
//         this.admin,
//         this.customerId});
//
//   AssignTo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     todayAttendance = json['today_attendance'];
//     if (json['brand_names'] != null) {
//       brandNames = <Null>[];
//       json['brand_names'].forEach((v) {
//         brandNames!.add(new Null.fromJson(v));
//       });
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
//     createdBy = json['created_by'];
//     admin = json['admin'];
//     customerId = json['customer_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['today_attendance'] = this.todayAttendance;
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
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     data['customer_id'] = this.customerId;
//     return data;
//   }
// }
//
// class TicketAddress {
//   Null? primaryAddress;
//   Null? state;
//   String? country;
//   Null? city;
//   Null? zipcode;
//   Null? region;
//
//   TicketAddress(
//       {this.primaryAddress,
//         this.state,
//         this.country,
//         this.city,
//         this.zipcode,
//         this.region});
//
//   TicketAddress.fromJson(Map<String, dynamic> json) {
//     primaryAddress = json['primary_address'];
//     state = json['state'];
//     country = json['country'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     region = json['region'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['primary_address'] = this.primaryAddress;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['region'] = this.region;
//     return data;
//   }
// }
//
// class FsrDetails {
//   List<Null>? categories;
//   String? fsrName;
//   Null? createdBy;
//   Null? admin;
//
//   FsrDetails({this.categories, this.fsrName, this.createdBy, this.admin});
//
//   FsrDetails.fromJson(Map<String, dynamic> json) {
//     if (json['categories'] != null) {
//       categories = <Null>[];
//       json['categories'].forEach((v) {
//         categories!.add(new Null.fromJson(v));
//       });
//     }
//     fsrName = json['fsrName'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     data['fsrName'] = this.fsrName;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
//     return data;
//   }
// }
//
// class ServiceDetails {
//   String? serviceName;
//   Null? servicePrice;
//   String? serviceContactNumber;
//   String? serviceDescription;
//   Null? serviceImage1;
//   Null? serviceImage2;
//   Null? serviceImage3;
//   Null? serviceSubCategory;
//   Null? createdBy;
//   Null? admin;
//
//   ServiceDetails(
//       {this.serviceName,
//         this.servicePrice,
//         this.serviceContactNumber,
//         this.serviceDescription,
//         this.serviceImage1,
//         this.serviceImage2,
//         this.serviceImage3,
//         this.serviceSubCategory,
//         this.createdBy,
//         this.admin});
//
//   ServiceDetails.fromJson(Map<String, dynamic> json) {
//     serviceName = json['service_name'];
//     servicePrice = json['service_price'];
//     serviceContactNumber = json['service_contact_number'];
//     serviceDescription = json['service_description'];
//     serviceImage1 = json['service_image1'];
//     serviceImage2 = json['service_image2'];
//     serviceImage3 = json['service_image3'];
//     serviceSubCategory = json['service_sub_category'];
//     createdBy = json['created_by'];
//     admin = json['admin'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service_name'] = this.serviceName;
//     data['service_price'] = this.servicePrice;
//     data['service_contact_number'] = this.serviceContactNumber;
//     data['service_description'] = this.serviceDescription;
//     data['service_image1'] = this.serviceImage1;
//     data['service_image2'] = this.serviceImage2;
//     data['service_image3'] = this.serviceImage3;
//     data['service_sub_category'] = this.serviceSubCategory;
//     data['created_by'] = this.createdBy;
//     data['admin'] = this.admin;
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
//   Null? createdBy;
//   Null? customerId;
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
//         this.createdBy,
//         this.customerId});
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
//     createdBy = json['created_by'];
//     customerId = json['customer_id'];
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
//     data['created_by'] = this.createdBy;
//     data['customer_id'] = this.customerId;
//     return data;
//   }
// }