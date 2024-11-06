class LeaveAllocationResponseModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final List<LeaveAllocationResult> results;

  LeaveAllocationResponseModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory LeaveAllocationResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveAllocationResponseModel(
      count: json['count'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      results: (json['results'] as List)
          .map((item) => LeaveAllocationResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

class LeaveAllocationResult {
  final int id;
  final int adminUser;
  final int months;
  final int allocatedSickLeave;
  final int allocatedCasualLeave;

  LeaveAllocationResult({
    required this.id,
    required this.adminUser,
    required this.months,
    required this.allocatedSickLeave,
    required this.allocatedCasualLeave,
  });

  factory LeaveAllocationResult.fromJson(Map<String, dynamic> json) {
    return LeaveAllocationResult(
      id: json['id'],
      adminUser: json['admin_user'],
      months: json['months'],
      allocatedSickLeave: json['allocated_sick_leave'],
      allocatedCasualLeave: json['allocated_casual_leave'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_user': adminUser,
      'months': months,
      'allocated_sick_leave': allocatedSickLeave,
      'allocated_casual_leave': allocatedCasualLeave,
    };
  }
}
