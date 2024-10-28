// class TicketResponseModel {
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
//   dynamic rate;
//   String? instructions;
//   String? status;
//   dynamic rejectedNote;
//   dynamic onholdNote;
//   dynamic beforeNote;
//   dynamic afterNote;
//   dynamic beforeTaskImages1;
//   dynamic beforeTaskImages2;
//   dynamic beforeTaskImages3;
//   dynamic afterTaskImages1;
//   dynamic afterTaskImages2;
//   dynamic afterTaskImages3;
//   dynamic custName;
//   dynamic custNumber;
//   dynamic custRating;
//   dynamic technicalNote;
//   dynamic workmode;
//   dynamic custSignature;
//   dynamic technicianSignature;
//   dynamic technicianName;
//   dynamic technicianNumber;
//   String? brand;
//   String? model;
//   dynamic purpose;
//   dynamic acceptedNote;
//   TicketAddress? ticketAddress;
//   FsrDetails? fsrDetails;
//   ServiceDetails? serviceDetails;
//   SubCustomerDetails? subCustomerDetails;
//   List<dynamic>? checkpoints;
//   int? aging;
//   bool?isSelected;
//
//   TicketResponseModel({
//     this.id,
//     this.taskName,
//     this.date,
//     this.time,
//     this.israte,
//     this.isamc,
//     this.assignTo,
//     this.customerDetails,
//     this.technicalNotes,
//     this.devices,
//     this.totalTime,
//     this.startDateTime,
//     this.endDateTime,
//     this.ticketCheckpoints,
//     this.admin,
//     this.createdBy,
//     this.rate,
//     this.instructions,
//     this.status,
//     this.rejectedNote,
//     this.onholdNote,
//     this.beforeNote,
//     this.afterNote,
//     this.beforeTaskImages1,
//     this.beforeTaskImages2,
//     this.beforeTaskImages3,
//     this.afterTaskImages1,
//     this.afterTaskImages2,
//     this.afterTaskImages3,
//     this.custName,
//     this.custNumber,
//     this.custRating,
//     this.technicalNote,
//     this.workmode,
//     this.custSignature,
//     this.technicianSignature,
//     this.technicianName,
//     this.technicianNumber,
//     this.brand,
//     this.model,
//     this.purpose,
//     this.acceptedNote,
//     this.ticketAddress,
//     this.fsrDetails,
//     this.serviceDetails,
//     this.subCustomerDetails,
//     this.checkpoints,
//     this.aging,
//     this.isSelected = false,
//   });
//
//   factory TicketResponseModel.fromJson(Map<String, dynamic> json) {
//     return TicketResponseModel(
//       id: json['id'],
//       taskName: json['taskName'],
//       date: json['date'],
//       time: json['time'],
//       israte: json['israte'],
//       isamc: json['isamc'],
//       assignTo: json['assignTo'] != null ? AssignTo.fromJson(json['assignTo']) : null,
//       customerDetails: json['customerDetails'] != null ? CustomerDetails.fromJson(json['customerDetails']) : null,
//       technicalNotes: json['technical_notes'] != null ? List<dynamic>.from(json['technical_notes']) : null,
//       devices: json['devices'] != null ? List<dynamic>.from(json['devices']) : null,
//       totalTime: json['total_time'],
//       startDateTime: json['start_date_time'],
//       endDateTime: json['end_date_time'],
//       ticketCheckpoints: json['ticket_checkpoints'] != null ? List<dynamic>.from(json['ticket_checkpoints']) : null,
//       admin: json['admin'],
//       createdBy: json['created_by'],
//       rate: json['rate'],
//       instructions: json['instructions'],
//       status: json['status'],
//       rejectedNote: json['rejected_note'],
//       onholdNote: json['onhold_note'],
//       beforeNote: json['before_note'],
//       afterNote: json['after_note'],
//       beforeTaskImages1: json['before_task_images_1'],
//       beforeTaskImages2: json['before_task_images_2'],
//       beforeTaskImages3: json['before_task_images_3'],
//       afterTaskImages1: json['after_task_images_1'],
//       afterTaskImages2: json['after_task_images_2'],
//       afterTaskImages3: json['after_task_images_3'],
//       custName: json['cust_name'],
//       custNumber: json['cust_number'],
//       custRating: json['cust_rating'],
//       technicalNote: json['technical_note'],
//       workmode: json['workmode'],
//       custSignature: json['cust_signature'],
//       technicianSignature: json['technician_signature'],
//       technicianName: json['technician_name'],
//       technicianNumber: json['technician_number'],
//       brand: json['brand'],
//       model: json['model'],
//       purpose: json['purpose'],
//       acceptedNote: json['acceptedNote'],
//       ticketAddress: json['ticket_address'] != null ? TicketAddress.fromJson(json['ticket_address']) : null,
//       fsrDetails: json['fsrDetails'] != null ? FsrDetails.fromJson(json['fsrDetails']) : null,
//       serviceDetails: json['serviceDetails'] != null ? ServiceDetails.fromJson(json['serviceDetails']) : null,
//       subCustomerDetails: json['subCustomerDetails'] != null ? SubCustomerDetails.fromJson(json['subCustomerDetails']) : null,
//       checkpoints: json['checkpoints'] != null ? List<dynamic>.from(json['checkpoints']) : null,
//       aging: json['aging'],
//     );
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
//       data['technical_notes'] = this.technicalNotes;
//     }
//     if (this.devices != null) {
//       data['devices'] = this.devices;
//     }
//     data['total_time'] = this.totalTime;
//     data['start_date_time'] = this.startDateTime;
//     data['end_date_time'] = this.endDateTime;
//     if (this.ticketCheckpoints != null) {
//       data['ticket_checkpoints'] = this.ticketCheckpoints;
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
//       data['checkpoints'] = this.checkpoints;
//     }
//     data['aging'] = this.aging;
//     return data;
//   }
//
//
// }
//
// class AssignTo {
//   int? id;
//   TodayAttendance? todayAttendance;
//   List<dynamic>? brandNames;
//   dynamic lastLogin;
//   String? firstName;
//   String? lastName;
//   String? email;
//   dynamic phoneNumber;
//   String? companyName;
//   String? employees;
//   dynamic dob;
//   String? otp;
//   bool? otpVerified;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isAdmin;
//   dynamic lastLatitude;
//   dynamic lastLongitude;
//   bool? isActive;
//   String? dateJoined;
//   bool? isFieldworker;
//   bool? isHrAdmin;
//   bool? isSubAdmin;
//   bool? isFranchiseAdmin;
//   bool? isSubFranchiseAdmin;
//   bool? isFreelancerAdmin;
//   bool? isFreelancerTechnician;
//   bool? isPartnerAdmin;
//   bool? isFranchiseFieldworker;
//   bool? isSubFranchiseFieldworker;
//   bool? isTechnicianAdmin;
//   bool? isFranchiseTechnician;
//   bool? isPartnerFieldworker;
//   bool? isPartnerTechnician;
//   dynamic profilePic;
//   bool? isInvited;
//   String? status;
//
//   AssignTo({
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
//     this.isAdmin,
//     this.lastLatitude,
//     this.lastLongitude,
//     this.isActive,
//     this.dateJoined,
//     this.isFieldworker,
//     this.isHrAdmin,
//     this.isSubAdmin,
//     this.isFranchiseAdmin,
//     this.isSubFranchiseAdmin,
//     this.isFreelancerAdmin,
//     this.isFreelancerTechnician,
//     this.isPartnerAdmin,
//     this.isFranchiseFieldworker,
//     this.isSubFranchiseFieldworker,
//     this.isTechnicianAdmin,
//     this.isFranchiseTechnician,
//     this.isPartnerFieldworker,
//     this.isPartnerTechnician,
//     this.profilePic,
//     this.isInvited,
//     this.status,
//   });
//
//   factory AssignTo.fromJson(Map<String, dynamic> json) {
//     return AssignTo(
//         id: json['id'],
//         todayAttendance: json['today_attendance'] != null
//         ? TodayAttendance.fromJson(json['today_attendance'])
//         : null,
//     brandNames: json['brand_names'] != null
//     ? List<dynamic>.from(json['brand_names'])
//         : null,
//     lastLogin: json['last_login'],
//     firstName: json['first_name'],
//     lastName: json['last_name'],
//     email: json['email'],
//     phoneNumber: json['phone_number'],
//     companyName: json['company_name'],
//     employees: json['employees'],
//     dob: json['dob'],
//     otp: json['otp'],
//     otpVerified: json['otp_verified'],
//     isStaff: json['is_staff'],
//     isSuperuser: json['is_superuser'],
//     isAdmin: json['is_admin'],
//     lastLatitude: json['last_latitude'],
//     lastLongitude: json['last_longitude'],
//     isActive: json['is_active'],
//     dateJoined: json['date_joined'],
//     isFieldworker: json['is_fieldworker'],
//     isHrAdmin: json['is_hr_admin'],
//     isSubAdmin: json['is_sub_admin'],
//     isFranchiseAdmin: json['is_franchise_admin'],
//     isSubFranchiseAdmin: json['is_sub_franchise_admin'],
//     isFreelancerAdmin: json['is_freelancer_admin'],
//     isFreelancerTechnician: json['is_freelancer_technician'],
//     isPartnerAdmin: json['is_partner_admin'],
//     isFranchiseFieldworker: json['is_franchise_fieldworker'],
//     isSubFranchiseFieldworker: json['is_sub_franchise_fieldworker'],
//     isTechnicianAdmin: json['is_technician_admin'],
//     isFranchiseTechnician: json['is_franchise_technician'],
//     isPartnerFieldworker: json['is_partner_fieldworker'],
//     isPartnerTechnician: json['is_partner_technician'],
//       profilePic: json['profile_pic'],
//       isInvited: json['is_invited'],
//       status: json['status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.todayAttendance != null) {
//       data['today_attendance'] = this.todayAttendance!.toJson();
//     }
//     if (this.brandNames != null) {
//       data['brand_names'] = this.brandNames;
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
//     data['is_admin'] = this.isAdmin;
//     data['last_latitude'] = this.lastLatitude;
//     data['last_longitude'] = this.lastLongitude;
//     data['is_active'] = this.isActive;
//     data['date_joined'] = this.dateJoined;
//     data['is_fieldworker'] = this.isFieldworker;
//     data['is_hr_admin'] = this.isHrAdmin;
//     data['is_sub_admin'] = this.isSubAdmin;
//     data['is_franchise_admin'] = this.isFranchiseAdmin;
//     data['is_sub_franchise_admin'] = this.isSubFranchiseAdmin;
//     data['is_freelancer_admin'] = this.isFreelancerAdmin;
//     data['is_freelancer_technician'] = this.isFreelancerTechnician;
//     data['is_partner_admin'] = this.isPartnerAdmin;
//     data['is_franchise_fieldworker'] = this.isFranchiseFieldworker;
//     data['is_sub_franchise_fieldworker'] = this.isSubFranchiseFieldworker;
//     data['is_technician_admin'] = this.isTechnicianAdmin;
//     data['is_franchise_technician'] = this.isFranchiseTechnician;
//     data['is_partner_fieldworker'] = this.isPartnerFieldworker;
//     data['is_partner_technician'] = this.isPartnerTechnician;
//     data['profile_pic'] = this.profilePic;
//     data['is_invited'] = this.isInvited;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class TodayAttendance {
//   String? checkin;
//   String? checkout;
//   String? workingHours;
//
//   TodayAttendance({
//     this.checkin,
//     this.checkout,
//     this.workingHours,
//   });
//
//   factory TodayAttendance.fromJson(Map<String, dynamic> json) {
//     return TodayAttendance(
//       checkin: json['checkin'],
//       checkout: json['checkout'],
//       workingHours: json['working_hours'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['checkin'] = this.checkin;
//     data['checkout'] = this.checkout;
//     data['working_hours'] = this.workingHours;
//     return data;
//   }
// }
//
// class CustomerDetails {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//
//   CustomerDetails({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//   });
//
//   factory CustomerDetails.fromJson(Map<String, dynamic> json) {
//     return CustomerDetails(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       phone: json['phone'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     return data;
//   }
// }
//
// class TicketAddress {
//   String? city;
//   String? state;
//   String? country;
//   String? pincode;
//
//   TicketAddress({
//     this.city,
//     this.state,
//     this.country,
//     this.pincode,
//   });
//
//   factory TicketAddress.fromJson(Map<String, dynamic> json) {
//     return TicketAddress(
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       pincode: json['pincode'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['pincode'] = this.pincode;
//     return data;
//   }
// }
//
// class FsrDetails {
//   String? fsrNumber;
//   String? fsrStatus;
//
//   FsrDetails({
//     this.fsrNumber,
//     this.fsrStatus,
//   });
//
//   factory FsrDetails.fromJson(Map<String, dynamic> json) {
//     return FsrDetails(
//       fsrNumber: json['fsr_number'],
//       fsrStatus: json['fsr_status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['fsr_number'] = this.fsrNumber;
//     data['fsr_status'] = this.fsrStatus;
//     return data;
//   }
// }
//
// class ServiceDetails {
//   String? serviceType;
//   String? serviceCategory;
//
//   ServiceDetails({
//     this.serviceType,
//     this.serviceCategory,
//   });
//
//   factory ServiceDetails.fromJson(Map<String, dynamic> json) {
//     return ServiceDetails(
//       serviceType: json['service_type'],
//       serviceCategory: json['service_category'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service_type'] = this.serviceType;
//     data['service_category'] = this.serviceCategory;
//     return data;
//   }
// }
//
// class SubCustomerDetails {
//   int? subCustomerId;
//   String? subCustomerName;
//   String? subCustomerContact;
//
//   SubCustomerDetails({
//     this.subCustomerId,
//     this.subCustomerName,
//     this.subCustomerContact,
//   });
//
//   factory SubCustomerDetails.fromJson(Map<String, dynamic> json) {
//     return SubCustomerDetails(
//       subCustomerId: json['sub_customer_id'],
//       subCustomerName: json['sub_customer_name'],
//       subCustomerContact: json['sub_customer_contact'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sub_customer_id'] = this.subCustomerId;
//     data['sub_customer_name'] = this.subCustomerName;
//     data['sub_customer_contact'] = this.subCustomerContact;
//     return data;
//   }
// }
//
class TicketResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<TicketResult> results;

  TicketResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory TicketResponseModel.fromJson(Map<String, dynamic> json) {
    return TicketResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((e) => TicketResult.fromJson(e))
          .toList(),
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
  final User assignTo;
  final CustomerDetails customerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String totalTime;
  final String startDateTime;
  final String endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int admin;
  final String createdBy;
  final dynamic rate;
  final String instructions;
  final String status;
  final String? rejectedNote;
  final String? onholdNote;
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
  final String brand;
  final String? model;
  final String purpose;
  final String? acceptedNote;
  final TicketAddress ticketAddress;
  final String createdAt;
  final FsrDetails fsrDetails;
  final ServiceDetails serviceDetails;
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
    required this.instructions,
    required this.status,
    this.rejectedNote,
    this.onholdNote,
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
    required this.brand,
    this.model,
    required this.purpose,
    this.acceptedNote,
    required this.ticketAddress,
    required this.createdAt,
    required this.fsrDetails,
    required this.serviceDetails,
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
      assignTo: User.fromJson(json['assignTo'] ?? {}),
      customerDetails: CustomerDetails.fromJson(json['customerDetails'] ?? {}),
      technicalNotes: json['technical_notes'] ?? [],
      devices: json['devices'] ?? [],
      totalTime: json['total_time'] ?? '',
      startDateTime: json['start_date_time'] ?? '',
      endDateTime: json['end_date_time'] ?? '',
      ticketCheckpoints: json['ticket_checkpoints'] ?? [],
      admin: json['admin'] ?? 0,
      createdBy: json['created_by'] ?? '',
      rate: json['rate'],
      instructions: json['instructions'] ?? '',
      status: json['status'] ?? '',
      rejectedNote: json['rejected_note'],
      onholdNote: json['onhold_note'],
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
      brand: json['brand'] ?? '',
      model: json['model'],
      purpose: json['purpose'] ?? '',
      acceptedNote: json['acceptedNote'],
      ticketAddress: TicketAddress.fromJson(json['ticket_address'] ?? {}),
      createdAt: json['created_at'] ?? '',
      fsrDetails: FsrDetails.fromJson(json['fsrDetails'] ?? {}),
      serviceDetails: ServiceDetails.fromJson(json['serviceDetails'] ?? {}),
      subCustomerDetails: SubCustomerDetails.fromJson(json['subCustomerDetails'] ?? {}),
      checkpoints: json['checkpoints'] ?? [],
      aging: json['aging'] ?? 0,
    );
  }
}

class User {
  final int id;
  final TodayAttendance todayAttendance;
  final List<String> brandNames;
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
  final String? customerTag;
  final String? modelNo;
  final String? socialId;
  final bool deactivate;
  final String role;
  final String? customerType;
  final String batteryStatus;
  final bool gpsStatus;
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

  User({
    required this.id,
    required this.todayAttendance,
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      todayAttendance: TodayAttendance.fromJson(json['today_attendance'] ?? {}),
      brandNames: List<String>.from(json['brand_names'] ?? []),
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
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

class SubCustomerDetails {
  int? subCustomerId;
  String? subCustomerName;
  String? subCustomerContact;

  SubCustomerDetails({
    this.subCustomerId,
    this.subCustomerName,
    this.subCustomerContact,
  });

  factory SubCustomerDetails.fromJson(Map<String, dynamic> json) {
    return SubCustomerDetails(
      subCustomerId: json['sub_customer_id'],
      subCustomerName: json['sub_customer_name'],
      subCustomerContact: json['sub_customer_contact'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_customer_id'] = this.subCustomerId;
    data['sub_customer_name'] = this.subCustomerName;
    data['sub_customer_contact'] = this.subCustomerContact;
    return data;
  }
}
//
class ServiceDetails {
  String? serviceType;
  String? serviceCategory;

  ServiceDetails({
    this.serviceType,
    this.serviceCategory,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      serviceType: json['service_type'],
      serviceCategory: json['service_category'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type'] = this.serviceType;
    data['service_category'] = this.serviceCategory;
    return data;
  }
}
//
class FsrDetails {
  String? fsrNumber;
  String? fsrStatus;

  FsrDetails({
    this.fsrNumber,
    this.fsrStatus,
  });

  factory FsrDetails.fromJson(Map<String, dynamic> json) {
    return FsrDetails(
      fsrNumber: json['fsr_number'],
      fsrStatus: json['fsr_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fsr_number'] = this.fsrNumber;
    data['fsr_status'] = this.fsrStatus;
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? name;
  String? email;
  String? phone;

  CustomerDetails({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class TicketAddress {
  String? city;
  String? state;
  String? country;
  String? pincode;

  TicketAddress({
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  factory TicketAddress.fromJson(Map<String, dynamic> json) {
    return TicketAddress(
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    return data;
  }
}