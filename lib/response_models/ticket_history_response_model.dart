class TicketHistoryResponseModel {
  int? ticketId;
  String? taskName;
  String? purpose;
  String? status;
  String? note;
  ActionBy? actionBy;
  String? createdBy;
  Address? address;
  String? phoneNumber;
  String? historyDate;
  bool? isCurrent;
  String? changeTimestamp;
  String? instructions;
  String? actionMessage;
  List<String>? fieldChanges;

  TicketHistoryResponseModel(
      {this.ticketId,
        this.taskName,
        this.purpose,
        this.status,
        this.note,
        this.actionBy,
        this.createdBy,
        this.address,
        this.phoneNumber,
        this.historyDate,
        this.isCurrent,
        this.changeTimestamp,
        this.instructions,
        this.actionMessage,
        this.fieldChanges});

  TicketHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    taskName = json['taskName'];
    purpose = json['purpose'];
    status = json['status'];
    note = json['note'];
    actionBy = json['action_by'] != null
        ? new ActionBy.fromJson(json['action_by'])
        : null;
    createdBy = json['created_by'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phoneNumber = json['phone_number'];
    historyDate = json['history_date'];
    isCurrent = json['is_current'];
    changeTimestamp = json['change_timestamp'];
    instructions = json['instructions'];
    actionMessage = json['action_message'];
    fieldChanges = json['field_changes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['taskName'] = this.taskName;
    data['purpose'] = this.purpose;
    data['status'] = this.status;
    data['note'] = this.note;
    if (this.actionBy != null) {
      data['action_by'] = this.actionBy!.toJson();
    }
    data['created_by'] = this.createdBy;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone_number'] = this.phoneNumber;
    data['history_date'] = this.historyDate;
    data['is_current'] = this.isCurrent;
    data['change_timestamp'] = this.changeTimestamp;
    data['instructions'] = this.instructions;
    data['action_message'] = this.actionMessage;
    data['field_changes'] = this.fieldChanges;
    return data;
  }
}

class ActionBy {
  String? name;
  int? id;
  String? email;

  ActionBy({this.name, this.id, this.email});

  ActionBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? region;
  String? country;
  String? zipcode;
  String? primaryAddress;

  Address(
      {this.city,
        this.state,
        this.region,
        this.country,
        this.zipcode,
        this.primaryAddress});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    region = json['region'];
    country = json['country'];
    zipcode = json['zipcode'];
    primaryAddress = json['primary_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['region'] = this.region;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['primary_address'] = this.primaryAddress;
    return data;
  }
}