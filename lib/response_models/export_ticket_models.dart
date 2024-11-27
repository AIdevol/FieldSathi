import 'package:excel/excel.dart';

class ExcelTicket {
  final String ticketId;
  final String taskName;
  final String date;
  final String time;
  final String assignTo;
  final bool isRated;
  final double? rate;
  final bool isAMC;
  final String customerName;
  final String fsrName;
  final String instructions;
  final String status;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String purpose;
  final String subCustomerName;

  ExcelTicket({
    required this.ticketId,
    required this.taskName,
    required this.date,
    required this.time,
    required this.assignTo,
    required this.isRated,
    this.rate,
    required this.isAMC,
    required this.customerName,
    required this.fsrName,
    required this.instructions,
    required this.status,
    this.startDateTime,
    this.endDateTime,
    required this.purpose,
    required this.subCustomerName,
  });

  // Example of converting from JSON (if data comes as a map)
  factory ExcelTicket.fromJson(Map<String, dynamic> json) {
    return ExcelTicket(
      ticketId: json['ticketId'] as String,
      taskName: json['taskName'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      assignTo: json['assignTo'] as String,
      isRated: json['isRated'] as bool,
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
      isAMC: json['isAMC'] as bool,
      customerName: json['customerName'] as String,
      fsrName: json['fsrName'] as String,
      instructions: json['instructions'] as String,
      status: json['status'] as String,
      startDateTime: json['startDateTime'] != null
          ? DateTime.parse(json['startDateTime'])
          : null,
      endDateTime: json['endDateTime'] != null
          ? DateTime.parse(json['endDateTime'])
          : null,
      purpose: json['purpose'] as String,
      subCustomerName: json['subCustomerName'] as String,
    );
  }

  // Example of converting to JSON (for saving or transferring data)
  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'taskName': taskName,
      'date': date,
      'time': time,
      'assignTo': assignTo,
      'isRated': isRated,
      'rate': rate,
      'isAMC': isAMC,
      'customerName': customerName,
      'fsrName': fsrName,
      'instructions': instructions,
      'status': status,
      'startDateTime': startDateTime?.toIso8601String(),
      'endDateTime': endDateTime?.toIso8601String(),
      'purpose': purpose,
      'subCustomerName': subCustomerName,
    };
  }



}
