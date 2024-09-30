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

  Map<String, dynamic> toMap() => {
        "id": id,
        "datetime": datetime!.toIso8601String(),
        "fish_age": fishAge,
        "name": name,
        "note": note,
        "cost": cost,
        "attachment_json_array": attachmentJsonArray ?? [],
      };
}
