import 'dart:convert';

class UpdateTreatmentPayload {
  String? id;
  DateTime? datetime;
  int? fishAge;
  String? name;
  String? note;
  int? cost;
  List<String>? attachmentJsonArray;

  UpdateTreatmentPayload({
    this.id,
    this.datetime,
    this.fishAge,
    this.name,
    this.note,
    this.cost,
    this.attachmentJsonArray,
  });

  factory UpdateTreatmentPayload.fromJson(String str) =>
      UpdateTreatmentPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateTreatmentPayload.fromMap(Map<String, dynamic> json) =>
      UpdateTreatmentPayload(
        id: json["id"],
        datetime: json["datetime"],
        fishAge: json["fish_age"],
        name: json["name"],
        note: json["note"],
        cost: json["cost"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, String> toMap() => {
        "id": id.toString(),
        "datetime": datetime!.toIso8601String(),
        "fish_age": fishAge.toString(),
        "name": name.toString(),
        "note": note.toString(),
        "cost": cost.toString(),
        "attachment_json_array": attachmentJsonArray!.toString(),
      };
}
