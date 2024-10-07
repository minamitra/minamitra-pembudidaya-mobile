import 'dart:convert';

class TreatmentResponse {
  final List<TreatmentResponseData>? data;

  TreatmentResponse({
    this.data,
  });

  factory TreatmentResponse.fromJson(String str) =>
      TreatmentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TreatmentResponse.fromMap(Map<String, dynamic> json) =>
      TreatmentResponse(
        data: json["data"] == null
            ? []
            : List<TreatmentResponseData>.from(
                json["data"]!.map((x) => TreatmentResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class TreatmentResponseData {
  final String? id;
  final String? memberId;
  final String? fishpondId;
  final String? fishpondcycleId;
  final DateTime? datetime;
  final String? fishAge;
  final String? name;
  final String? cost;
  final String? note;
  final List<String>? attachmentJsonArray;
  final DateTime? createDatetime;
  final String? createById;
  final String? createByType;
  final String? createByName;

  TreatmentResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.fishAge,
    this.name,
    this.cost,
    this.note,
    this.attachmentJsonArray,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
  });

  factory TreatmentResponseData.fromJson(String str) =>
      TreatmentResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TreatmentResponseData.fromMap(Map<String, dynamic> json) =>
      TreatmentResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        fishAge: json["fish_age"],
        name: json["name"],
        cost: json["cost"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"] == null
            ? []
            : List<String>.from(json["attachment_json_array"].map((x) => x)),
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createById: json["create_by_id"],
        createByType: json["create_by_type"],
        createByName: json["create_by_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "member_id": memberId,
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime!.toIso8601String(),
        "fish_age": fishAge,
        "name": name,
        "cost": cost,
        "note": note,
        "attachment_json_array": attachmentJsonArray,
        "create_datetime": createDatetime!.toIso8601String(),
        "create_by_id": createById,
        "create_by_type": createByType,
        "create_by_name": createByName,
      };
}
