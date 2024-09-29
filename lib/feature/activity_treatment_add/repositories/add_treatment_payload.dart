import 'dart:convert';

class AddTreatmentPayload {
  int? fishpondId;
  int? fishpondcycleId;
  DateTime? datetime;
  int? fishAge;
  String? name;
  String? note;
  int? cost;
  List<String>? attachmentJsonArray;

  AddTreatmentPayload({
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.fishAge,
    this.name,
    this.note,
    this.cost,
    this.attachmentJsonArray,
  });

  factory AddTreatmentPayload.fromJson(String str) =>
      AddTreatmentPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTreatmentPayload.fromMap(Map<String, dynamic> json) =>
      AddTreatmentPayload(
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime: json["datetime"],
        fishAge: json["fish_age"],
        name: json["name"],
        note: json["note"],
        cost: json["cost"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime!.toIso8601String(),
        "fish_age": fishAge,
        "name": name,
        "note": note,
        "cost": cost,
        "attachment_json_array": attachmentJsonArray ?? [],
      };
}
