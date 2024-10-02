import 'dart:convert';

class UpdateIncidentPayload {
  String? id;
  DateTime? datetime;
  String? incident;
  String? note;
  List<String>? attachmentJsonArray;

  UpdateIncidentPayload({
    this.id,
    this.datetime,
    this.incident,
    this.note,
    this.attachmentJsonArray,
  });

  factory UpdateIncidentPayload.fromJson(String str) =>
      UpdateIncidentPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateIncidentPayload.fromMap(Map<String, dynamic> json) =>
      UpdateIncidentPayload(
        id: json["id"],
        datetime: json["datetime"],
        incident: json["incident"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "datetime": datetime!.toIso8601String(),
        "incident": incident,
        "note": note,
        "attachment_json_array": attachmentJsonArray,
      };
}
