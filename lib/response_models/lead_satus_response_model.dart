class LeadStatusResponseModel {
  final int inDiscussion;
  final int serviceTaken;
  final int interact;
  final int inactive;
  final int quoteSent;
  final int notInterested;

  LeadStatusResponseModel({
    required this.inDiscussion,
    required this.serviceTaken,
    required this.interact,
    required this.inactive,
    required this.quoteSent,
    required this.notInterested,
  });

  factory LeadStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadStatusResponseModel(
      inDiscussion: json['In-Discussion'] ?? 0,
      serviceTaken: json['Service Taken'] ?? 0,
      interact: json['Interact'] ?? 0,
      inactive: json['Inactive'] ?? 0,
      quoteSent: json['Quote Sent'] ?? 0,
      notInterested: json['Not Interested'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'In-Discussion': inDiscussion,
      'Service Taken': serviceTaken,
      'Interact': interact,
      'Inactive': inactive,
      'Quote Sent': quoteSent,
      'Not Interested': notInterested,
    };
  }
}
