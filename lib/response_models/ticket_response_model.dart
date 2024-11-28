import 'dart:convert';

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
      results: (json['results'] as List<dynamic>?)
          ?.map((result) => TicketResult.fromJson(result))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class TicketResult {
  final int id;
  final String taskName;
  final String date;
  final String time;
  final bool israte;
  final bool isamc;
  final UserDetails assignTo;
  final UserDetails customerDetails;
  final UserDetails? subCustomerDetails;
  final List<dynamic> technicalNotes;
  final List<dynamic> devices;
  final String? totalTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<dynamic> ticketCheckpoints;
  final int admin;
  final String createdBy;
  final dynamic rate;
  final String? instructions;
  final String status;
  final String? rejectedNote;
  final String? onholdNote;
  final String? beforeNote;
  final String? afterNote;
  final String? beforeTaskImages1;
  final String? beforeTaskImages2;
  final String? beforeTaskImages3;
  final String? afterTaskImages1;
  final String? afterTaskImages2;
  final String? afterTaskImages3;
  final String? custName;
  final String? custNumber;
  final String? custRating;
  final String? technicalNote;
  final String? workmode;
  final String? custSignature;
  final String? technicianSignature;
  final String? technicianName;
  final String? technicianNumber;
  final String brand;
  final String model;
  final String purpose;
  final String? acceptedNote;
  final String? ticketAddress;
  final String createdAt;
  final FsrDetails fsrDetails;
  final ServiceDetails serviceDetails;
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
    this.subCustomerDetails,
    required this.technicalNotes,
    required this.devices,
    this.totalTime,
    this.startDateTime,
    this.endDateTime,
    required this.ticketCheckpoints,
    required this.admin,
    required this.createdBy,
    this.rate,
    this.instructions,
    required this.status,
    this.rejectedNote,
    this.onholdNote,
    this.beforeNote,
    this.afterNote,
    this.beforeTaskImages1,
    this.beforeTaskImages2,
    this.beforeTaskImages3,
    this.afterTaskImages1,
    this.afterTaskImages2,
    this.afterTaskImages3,
    this.custName,
    this.custNumber,
    this.custRating,
    this.technicalNote,
    this.workmode,
    this.custSignature,
    this.technicianSignature,
    this.technicianName,
    this.technicianNumber,
    required this.brand,
    required this.model,
    required this.purpose,
    this.acceptedNote,
    required this.ticketAddress,
    required this.createdAt,
    required this.fsrDetails,
    required this.serviceDetails,
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
      assignTo: UserDetails.fromJson(json['assignTo'] ?? {}),
      customerDetails: UserDetails.fromJson(json['customerDetails'] ?? {}),
      subCustomerDetails: json['subCustomerDetails'] != null
          ? UserDetails.fromJson(json['subCustomerDetails'])
          : null,
      technicalNotes: json['technical_notes'] ?? [],
      devices: json['devices'] ?? [],
      totalTime: json['total_time'],
      startDateTime: json['start_date_time'] != null
          ? DateTime.tryParse(json['start_date_time'])
          : null,
      endDateTime: json['end_date_time'] != null
          ? DateTime.tryParse(json['end_date_time'])
          : null,
      ticketCheckpoints: json['ticket_checkpoints'] ?? [],
      admin: json['admin'] ?? 0,
      createdBy: json['created_by'] ?? '',
      rate: json['rate'],
      instructions: json['instructions'],
      status: json['status'] ?? '',
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
      workmode: json['workmode'],
      custSignature: json['cust_signature'],
      technicianSignature: json['technician_signature'],
      technicianName: json['technician_name'],
      technicianNumber: json['technician_number'],
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      purpose: json['purpose'] ?? '',
      acceptedNote: json['acceptedNote'],
      ticketAddress: json['ticket_address']/*TicketAddress.fromJson(json['ticket_address'] ?? {})*/,
      createdAt: json['created_at'] ?? '',
      fsrDetails: FsrDetails.fromJson(json['fsrDetails'] ?? {}),
      serviceDetails: ServiceDetails.fromJson(json['serviceDetails'] ?? {}),
      aging: json['aging'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'date': date,
      'time': time,
      'israte': israte,
      'isamc': isamc,
      'assignTo': assignTo.toJson(),
      'customerDetails': customerDetails.toJson(),
      'subCustomerDetails': subCustomerDetails?.toJson(),
      'technical_notes': technicalNotes,
      'devices': devices,
      'total_time': totalTime,
      'start_date_time': startDateTime?.toIso8601String(),
      'end_date_time': endDateTime?.toIso8601String(),
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
      'workmode': workmode,
      'cust_signature': custSignature,
      'technician_signature': technicianSignature,
      'technician_name': technicianName,
      'technician_number': technicianNumber,
      'brand': brand,
      'model': model,
      'purpose': purpose,
      'acceptedNote': acceptedNote,
      'ticket_address': ticketAddress,
      'created_at': createdAt,
      'fsrDetails': fsrDetails.toJson(),
      'serviceDetails': serviceDetails.toJson(),
      'aging': aging,
    };
  }
}

class UserDetails {
  final int id;
  final UserAttendance? todayAttendance;
  final List<String> brandNames;
  final DateTime? lastLogin;
  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String? companyName;
  final String? role;
  final bool isActive;
  final String? createdAt;

  UserDetails({
    required this.id,
    this.todayAttendance,
    required this.brandNames,
    this.lastLogin,
    this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.companyName,
    this.role,
    required this.isActive,
    this.createdAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? 0,
      todayAttendance: json['today_attendance'] != null
          ? UserAttendance.fromJson(json['today_attendance'])
          : null,
      brandNames: List<String>.from(json['brand_names'] ?? []),
      lastLogin: json['last_login'] != null
          ? DateTime.tryParse(json['last_login'])
          : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'],
      role: json['role'],
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'today_attendance': todayAttendance?.toJson(),
      'brand_names': brandNames,
      'last_login': lastLogin?.toIso8601String(),
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'company_name': companyName,
      'role': role,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }
}

class UserAttendance {
  final int id;
  final int user;
  final DateTime? punchIn;
  final DateTime? punchOut;
  final String status;
  final String date;

  UserAttendance({
    required this.id,
    required this.user,
    this.punchIn,
    this.punchOut,
    required this.status,
    required this.date,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) {
    return UserAttendance(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      punchIn: json['punch_in'] != null
          ? DateTime.tryParse(json['punch_in'])
          : null,
      punchOut: json['punch_out'] != null
          ? DateTime.tryParse(json['punch_out'])
          : null,
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'punch_in': punchIn?.toIso8601String(),
      'punch_out': punchOut?.toIso8601String(),
      'status': status,
      'date': date,
    };
  }
}

class TicketAddress {
  final String city;
  final String state;
  final String region;
  final String country;
  final String zipcode;
  final String primaryAddress;

  TicketAddress({
    required this.city,
    required this.state,
    required this.region,
    required this.country,
    required this.zipcode,
    required this.primaryAddress,
  });

  factory TicketAddress.fromJson(Map<String, dynamic> json) {
    return TicketAddress(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      zipcode: json['zipcode'] ?? '',
      primaryAddress: json['primary_address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'region': region,
      'country': country,
      'zipcode': zipcode,
      'primary_address': primaryAddress,
    };
  }
}

class FsrDetails {
  final int id;
  final String fsrName;
  final List<FsrCategory> categories;
  final int createdBy;
  final int admin;

  FsrDetails({
    required this.id,
    required this.fsrName,
    required this.categories,
    required this.createdBy,
    required this.admin,
  });

  factory FsrDetails.fromJson(Map<String, dynamic> json) {
    return FsrDetails(
      id: json['id'] ?? 0,
      fsrName: json['fsrName'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => FsrCategory.fromJson(category))
          .toList() ??
          [],
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fsrName': fsrName,
      'categories': categories.map((category) => category.toJson()).toList(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class FsrCategory {
  final int id;
  final String name;
  final List<dynamic> checkpoints;
  final int createdBy;
  final int admin;

  FsrCategory({
  required this.id,
  required this.name,
  required this.checkpoints,
  required this.createdBy,
    required this.admin,
  });

  factory FsrCategory.fromJson(Map<String, dynamic> json) {
    return FsrCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      checkpoints: json['checkpoints'] ?? [],
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'checkpoints': checkpoints,
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceDetails {
  final int id;
  final String serviceName;
  final String servicePrice;
  final String serviceContactNumber;
  final String serviceDescription;
  final String? serviceImage1;
  final String? serviceImage2;
  final String? serviceImage3;
  final ServiceSubCategory serviceSubCategory;
  final int createdBy;
  final int admin;

  ServiceDetails({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceContactNumber,
    required this.serviceDescription,
    this.serviceImage1,
    this.serviceImage2,
    this.serviceImage3,
    required this.serviceSubCategory,
    required this.createdBy,
    required this.admin,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      id: json['id'] ?? 0,
      serviceName: json['service_name'] ?? '',
      servicePrice: json['service_price'] ?? '0.00',
      serviceContactNumber: json['service_contact_number'] ?? '',
      serviceDescription: json['service_description'] ?? '',
      serviceImage1: json['service_image1'],
      serviceImage2: json['service_image2'],
      serviceImage3: json['service_image3'],
      serviceSubCategory: ServiceSubCategory.fromJson(
          json['service_sub_category'] ?? {}),
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
      'service_price': servicePrice,
      'service_contact_number': serviceContactNumber,
      'service_description': serviceDescription,
      'service_image1': serviceImage1,
      'service_image2': serviceImage2,
      'service_image3': serviceImage3,
      'service_sub_category': serviceSubCategory.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceSubCategory {
  final int id;
  final String serviceSubCategoryName;
  final String serviceSubCategoryDescription;
  final String? serviceSubImage;
  final ServiceCategory serviceCategory;
  final int createdBy;
  final int admin;

  ServiceSubCategory({
    required this.id,
    required this.serviceSubCategoryName,
    required this.serviceSubCategoryDescription,
    this.serviceSubImage,
    required this.serviceCategory,
    required this.createdBy,
    required this.admin,
  });

  factory ServiceSubCategory.fromJson(Map<String, dynamic> json) {
    return ServiceSubCategory(
      id: json['id'] ?? 0,
      serviceSubCategoryName: json['service_sub_category_name'] ?? '',
      serviceSubCategoryDescription: json['service_sub_cat_description'] ?? '',
      serviceSubImage: json['service_sub_image'],
      serviceCategory: ServiceCategory.fromJson(
          json['service_category'] ?? {}),
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_sub_category_name': serviceSubCategoryName,
      'service_sub_cat_description': serviceSubCategoryDescription,
      'service_sub_image': serviceSubImage,
      'service_category': serviceCategory.toJson(),
      'created_by': createdBy,
      'admin': admin,
    };
  }
}

class ServiceCategory {
  final int id;
  final String serviceCategoryName;
  final String serviceCategoryDescription;
  final String? serviceCategoryImage;
  final int createdBy;
  final int admin;

  ServiceCategory({
    required this.id,
    required this.serviceCategoryName,
    required this.serviceCategoryDescription,
    this.serviceCategoryImage,
    required this.createdBy,
    required this.admin,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] ?? 0,
      serviceCategoryName: json['service_category_name'] ?? '',
      serviceCategoryDescription: json['service_cat_descriptions'] ?? '',
      serviceCategoryImage: json['service_cat_image'],
      createdBy: json['created_by'] ?? 0,
      admin: json['admin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_category_name': serviceCategoryName,
      'service_cat_descriptions': serviceCategoryDescription,
      'service_cat_image': serviceCategoryImage,
      'created_by': createdBy,
      'admin': admin,
    };
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
