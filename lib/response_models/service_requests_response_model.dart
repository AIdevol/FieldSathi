class ServiceRequestResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<Result> results;

  ServiceRequestResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory ServiceRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'total_pages': totalPages,
    'current_page': currentPage,
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  final int id;
  final Ticket ticket;
  final List<dynamic> materialRequired;
  final String status;
  final dynamic approvedRemark;
  final dynamic dispatchedRemark;
  final dynamic hubAddress;
  final dynamic courierContactNumber;
  final dynamic docktNo;
  final dynamic whereToDispatched;

  Result({
    required this.id,
    required this.ticket,
    required this.materialRequired,
    required this.status,
    this.approvedRemark,
    this.dispatchedRemark,
    this.hubAddress,
    this.courierContactNumber,
    this.docktNo,
    this.whereToDispatched,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      ticket: Ticket.fromJson(json['ticket']),
      materialRequired: List<dynamic>.from(json['material_required']),
      status: json['status'],
      approvedRemark: json['approved_remark'],
      dispatchedRemark: json['dispatched_remark'],
      hubAddress: json['hub_address'],
      courierContactNumber: json['courier_contact_number'],
      docktNo: json['dockt_no'],
      whereToDispatched: json['where_to_dispatched'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ticket': ticket.toJson(),
    'material_required': materialRequired,
    'status': status,
    'approved_remark': approvedRemark,
    'dispatched_remark': dispatchedRemark,
    'hub_address': hubAddress,
    'courier_contact_number': courierContactNumber,
    'dockt_no': docktNo,
    'where_to_dispatched': whereToDispatched,
  };
}

class Ticket {
  final int id;
  final String taskName;
  final String date;
  final String time;
  final bool isRate;
  final bool isAmc;
  final AssignTo assignTo;
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
  final dynamic rejectedNote;
  final dynamic onholdNote;
  final String beforeNote;
  final String afterNote;
  final String beforeTaskImages1;
  final String beforeTaskImages2;
  final String beforeTaskImages3;
  final String afterTaskImages1;
  final String? afterTaskImages2;
  final dynamic afterTaskImages3;
  final dynamic custName;
  final dynamic custNumber;
  final String custRating;
  final String technicalNote;
  final String workMode;
  final String custSignature;
  final dynamic technicianSignature;
  final dynamic technicianName;
  final dynamic technicianNumber;
  final dynamic brand;
  final dynamic model;
  final String purpose;
  final dynamic acceptedNote;
  final TicketAddress ticketAddress;
  final String createdAt;
  final FsrDetails fsrDetails;
  final dynamic serviceDetails;
  final SubCustomerDetails subCustomerDetails;
  final List<dynamic> checkpoints;

  Ticket({
    required this.id,
    required this.taskName,
    required this.date,
    required this.time,
    required this.isRate,
    required this.isAmc,
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
    required this.beforeTaskImages1,
    required this.beforeTaskImages2,
    required this.beforeTaskImages3,
    required this.afterTaskImages1,
    this.afterTaskImages2,
    this.afterTaskImages3,
    this.custName,
    this.custNumber,
    required this.custRating,
    required this.technicalNote,
    required this.workMode,
    required this.custSignature,
    this.technicianSignature,
    this.technicianName,
    this.technicianNumber,
    this.brand,
    this.model,
    required this.purpose,
    this.acceptedNote,
    required this.ticketAddress,
    required this.createdAt,
    required this.fsrDetails,
    this.serviceDetails,
    required this.subCustomerDetails,
    required this.checkpoints,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      taskName: json['taskName'],
      date: json['date'],
      time: json['time'],
      isRate: json['israte'],
      isAmc: json['isamc'],
      assignTo: AssignTo.fromJson(json['assignTo']),
      customerDetails: CustomerDetails.fromJson(json['customerDetails']),
      technicalNotes: List<dynamic>.from(json['technical_notes']),
      devices: List<dynamic>.from(json['devices']),
      totalTime: json['total_time'],
      startDateTime: json['start_date_time'],
      endDateTime: json['end_date_time'],
      ticketCheckpoints: List<dynamic>.from(json['ticket_checkpoints']),
      admin: json['admin'],
      createdBy: json['created_by'],
      rate: json['rate'],
      instructions: json['instructions'],
      status: json['status'],
      rejectedNote: json['rejected_note'],
      onholdNote: json['onhold_note'],
      beforeNote: json['before_note'],
      afterNote: json['after_note'],
      beforeTaskImages1: json['before_task_images_1'],
      beforeTaskImages2: json['before_task_images_2'],
      beforeTaskImages3: json['before_task_images_3'],
      afterTaskImages1: json['after_task_images_1'],
      afterTaskImages2: json['after_task_images_2'],
      afterTaskImages3: json['after_task_images_3'],
      custName: json['cust_name'],
      custNumber: json['cust_number'],
      custRating: json['cust_rating'],
      technicalNote: json['technical_note'],
      workMode: json['workmode'],
      custSignature: json['cust_signature'],
      technicianSignature: json['technician_signature'],
      technicianName: json['technician_name'],
      technicianNumber: json['technician_number'],
      brand: json['brand'],
      model: json['model'],
      purpose: json['purpose'],
      acceptedNote: json['acceptedNote'],
      ticketAddress: TicketAddress.fromJson(json['ticket_address']),
      createdAt: json['created_at'],
      fsrDetails: FsrDetails.fromJson(json['fsrDetails']),
      serviceDetails: json['serviceDetails'],
      subCustomerDetails: SubCustomerDetails.fromJson(json['subCustomerDetails']),
      checkpoints: List<dynamic>.from(json['checkpoints']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskName': taskName,
    'date': date,
    'time': time,
    'israte': isRate,
    'isamc': isAmc,
    'assignTo': assignTo.toJson(),
    'customerDetails': customerDetails.toJson(),
    'technical_notes': technicalNotes,
    'devices': devices,
    'total_time': totalTime,
    'start_date_time': startDateTime,
    'end_date_time': endDateTime,
    'ticket_checkpoints': ticketCheckpoints,
    'admin': admin,
    'created_by': createdBy,
    'rate': rate,
    'instructions': instructions,
    'status': status,
    'rejected_note': rejectedNote,
    'onhold_note': onholdNote,
    'before_note': beforeNote,
    'after_note': afterNote,
    'before_task_images_1': beforeTaskImages1,
    'before_task_images_2': beforeTaskImages2,
    'before_task_images_3': beforeTaskImages3,
    'after_task_images_1': afterTaskImages1,
    'after_task_images_2': afterTaskImages2,
    'after_task_images_3': afterTaskImages3,
    'cust_name': custName,
    'cust_number': custNumber,
    'cust_rating': custRating,
    'technical_note': technicalNote,
    'workmode': workMode,
    'cust_signature': custSignature,
    'technician_signature': technicianSignature,
    'technician_name': technicianName,
    'technician_number': technicianNumber,
    'brand': brand,
    'model': model,
    'purpose': purpose,
    'acceptedNote': acceptedNote,
    'ticket_address': ticketAddress.toJson(),
    'created_at': createdAt,
    'fsrDetails': fsrDetails.toJson(),
    'serviceDetails': serviceDetails,
    'subCustomerDetails': subCustomerDetails.toJson(),
    'checkpoints': checkpoints,
  };
}

class AssignTo {
  final int id;
  final TodayAttendance todayAttendance;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String role;
  final String batteryStatus;
  final bool gpsStatus;
  final String longitude;
  final String latitude;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;
  final bool isLeaveAllocated;
  final String empId;
  final bool isDisabled;

  AssignTo({
    required this.id,
    required this.todayAttendance,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.batteryStatus,
    required this.gpsStatus,
    required this.longitude,
    required this.latitude,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
    required this.isLeaveAllocated,
    required this.empId,
    required this.isDisabled,
  });

  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(
      id: json['id'],
      todayAttendance: TodayAttendance.fromJson(json['today_attendance']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      batteryStatus: json['battery_status'],
      gpsStatus: json['gps_status'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      allocatedSickLeave: json['allocated_sick_leave'],
      allocatedCasualLeave: json['allocated_casual_leave'],
      isLeaveAllocated: json['is_leave_allocated'],
      empId: json['emp_id'],
      isDisabled: json['is_disabled'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'today_attendance': todayAttendance.toJson(),
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone_number': phoneNumber,
    'role': role,
    'battery_status': batteryStatus,
    'gps_status': gpsStatus,
    'longitude': longitude,
    'latitude': latitude,
    'allocated_sick_leave': allocatedSickLeave,
    'allocated_casual_leave': allocatedCasualLeave,
    'is_leave_allocated': isLeaveAllocated,
    'emp_id': empId,
    'is_disabled': isDisabled,
  };
}

class TodayAttendance {
  final int id;
  final int user;
  final String status;
  final String date;

  TodayAttendance({
    required this.id,
    required this.user,
    required this.status,
    required this.date,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      id: json['id'],
      user: json['user'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user,
    'status': status,
    'date': date,
  };
}

class CustomerDetails {
  final int id;
  final TodayAttendance todayAttendance;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String customerName;
  final String state;
  final String country;
  final String city;
  final bool isActive;

  CustomerDetails({
    required this.id,
    required this.todayAttendance,
    this.email,
    this.phoneNumber,
    this.companyName,
    required this.customerName,
    required this.state,
    required this.country,
    required this.city,
    required this.isActive,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      id: json['id'],
      todayAttendance: TodayAttendance.fromJson(json['today_attendance']),
      email: json['email'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      customerName: json['customer_name'],
      state: json['state'],
      country: json['country'],
      city: json['city'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'today_attendance': todayAttendance.toJson(),
    'email': email,
    'phone_number': phoneNumber,
    'company_name': companyName,
    'customer_name': customerName,
    'state': state,
    'country': country,
    'city': city,
    'is_active': isActive,
  };
}

class TicketAddress {
  final String city;
  final String state;
  final String country;

  TicketAddress({
    required this.city,
    required this.state,
    required this.country,
  });

  factory TicketAddress.fromJson(Map<String, dynamic> json) {
    return TicketAddress(
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() => {
    'city': city,
    'state': state,
    'country': country,
  };
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
      fsrName: json['fsrName'],
      categories: List<dynamic>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() => {
    'fsrName': fsrName,
    'categories': categories,
  };
}

class SubCustomerDetails {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final bool isActive;

  SubCustomerDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    required this.isActive,
  });

  factory SubCustomerDetails.fromJson(Map<String, dynamic> json) {
    return SubCustomerDetails(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone_number': phoneNumber,
    'is_active': isActive,
  };
}
