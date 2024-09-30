import 'dart:convert';

class SamplingResponse {
  final List<SamplingResponseData>? data;

  SamplingResponse({
    this.data,
  });

  factory SamplingResponse.fromJson(String str) =>
      SamplingResponse.fromMap(json.decode(str));

  factory SamplingResponse.fromMap(Map<String, dynamic> json) =>
      SamplingResponse(
        data: json["data"] == null
            ? []
            : List<SamplingResponseData>.from(
                json["data"]!.map((x) => SamplingResponseData.fromMap(x))),
      );
}

class SamplingResponseData {
  String? id;
  String? memberId;
  String? fishpondId;
  String? fishpondcycleId;
  DateTime? datetime;
  String? mbw;
  String? sr;
  String? note;
  List<String>? attachmentJsonArray;
  DateTime? createDatetime;
  String? createById;
  String? createByType;
  String? createByName;

  SamplingResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.mbw,
    this.sr,
    this.note,
    this.attachmentJsonArray,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
  });

  factory SamplingResponseData.fromJson(String str) =>
      SamplingResponseData.fromMap(json.decode(str));

  factory SamplingResponseData.fromMap(Map<String, dynamic> json) =>
      SamplingResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] != null ? DateTime.parse(json["datetime"]) : null,
        mbw: json["mbw"],
        sr: json["sr"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"] == null
            ? []
            : List<String>.from(json["attachment_json_array"].map((x) => x)),
        createDatetime: json["create_datetime"] != null
            ? DateTime.parse(json["create_datetime"])
            : null,
        createById: json["create_by_id"],
        createByType: json["create_by_type"],
        createByName: json["create_by_name"],
      );
}
