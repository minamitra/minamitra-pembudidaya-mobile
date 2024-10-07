import 'dart:convert';

class AddIncidentPayload {
  int? fishpondId;
  int? fishpondcycleId;
  String? incident;
  DateTime? datetime;
  String? note;
  List<String>? attachmentJsonArray;

  AddIncidentPayload({
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.incident,
    this.note,
    this.attachmentJsonArray,
  });

  factory AddIncidentPayload.fromJson(String str) =>
      AddIncidentPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddIncidentPayload.fromMap(Map<String, dynamic> json) =>
      AddIncidentPayload(
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime: json["datetime"],
        incident: json["incident"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime!.toIso8601String(),
        "incident": incident,
        "note": note,
        "attachment_json_array": attachmentJsonArray,
      };
}
