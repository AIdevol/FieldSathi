import 'package:intl/intl.dart';

class Ticket {
  final int id;
  final String customerName;
  final String subCustomerName;
  final String technicianName;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String address;
  final String region;
  final String purpose;
  final String status;
  final DateTime ticketDate;

  Ticket({
    required this.id,
    required this.customerName,
    required this.subCustomerName,
    required this.technicianName,
    required this.startDateTime,
    required this.endDateTime,
    required this.address,
    required this.region,
    required this.purpose,
    required this.status,
    required this.ticketDate,
  });

  String get time {
    Duration duration = endDateTime.difference(startDateTime);
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  }

  String get aging {
    Duration agingDuration = DateTime.now().difference(ticketDate);
    return '${agingDuration.inDays} days';
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      customerName: json['customer_name'],
      subCustomerName: json['subcustomer_name'],
      technicianName: json['technician_name'],
      startDateTime: DateTime.parse(json['start_datetime']),
      endDateTime: DateTime.parse(json['end_datetime']),
      address: json['address'],
      region: json['region'],
      purpose: json['purpose'],
      status: json['status'],
      ticketDate: DateTime.parse(json['ticket_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'subcustomer_name': subCustomerName,
      'technician_name': technicianName,
      'start_datetime': startDateTime.toIso8601String(),
      'end_datetime': endDateTime.toIso8601String(),
      'address': address,
      'region': region,
      'purpose': purpose,
      'status': status,
      'ticket_date': ticketDate.toIso8601String(),
    };
  }
}