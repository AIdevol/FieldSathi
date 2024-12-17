class LeavesHistoryViewResponseModel {
  LeavesHistoryViewResponseModel({
    required this.actionBy,
    required this.changeTimestamp,
    required this.actionMessage,
    required this.fieldChanges,
  });

  final String? actionBy;
  final String? changeTimestamp;
  final String? actionMessage;
  final List<String> fieldChanges;

  factory LeavesHistoryViewResponseModel.fromJson(Map<String, dynamic> json){
    return LeavesHistoryViewResponseModel(
      actionBy: json["action_by"],
      changeTimestamp: json["change_timestamp"],
      actionMessage: json["action_message"],
      fieldChanges: json["field_changes"] == null ? [] : List<String>.from(json["field_changes"]!.map((x) => x)),
    );
  }
}
