class ExportServiceResponse {
  final List<int> data;

  ExportServiceResponse({required this.data});

  factory ExportServiceResponse.fromJson(Map<String, dynamic> json) {
    return ExportServiceResponse(
      data: List<int>.from(json['data'] ?? []),
    );
  }
}
