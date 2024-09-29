import 'dart:convert';

class WaterQualityResponse {
  final List<WaterQualityResponseData>? data;

  WaterQualityResponse({
    this.data,
  });

  factory WaterQualityResponse.fromJson(String str) =>
      WaterQualityResponse.fromMap(json.decode(str));

  factory WaterQualityResponse.fromMap(Map<String, dynamic> json) =>
      WaterQualityResponse(
        data: json["data"] == null
            ? []
            : List<WaterQualityResponseData>.from(
                json["data"]!.map((x) => WaterQualityResponseData.fromMap(x))),
      );
}

class WaterQualityResponseData {
  String? id;
  String? memberId;
  String? fishpondId;
  String? fishpondcycleId;
  DateTime? datetime;
  String? level;
  String? ph;
  String? salinitas;
  String? temperature;
  String? dO;
  String? clarity;
  String? orp;
  String? waterColor;
  String? waterWeather;
  String? note;
  List<String>? attachmentJsonArray;
  DateTime? createDatetime;
  String? createById;
  String? createByType;
  String? createByName;

  WaterQualityResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.level,
    this.ph,
    this.salinitas,
    this.temperature,
    this.dO,
    this.clarity,
    this.orp,
    this.waterColor,
    this.waterWeather,
    this.note,
    this.attachmentJsonArray,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
  });

  factory WaterQualityResponseData.fromJson(String str) =>
      WaterQualityResponseData.fromMap(json.decode(str));

  factory WaterQualityResponseData.fromMap(Map<String, dynamic> json) =>
      WaterQualityResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] != null ? DateTime.parse(json["datetime"]) : null,
        level: json["level"],
        ph: json["ph"],
        salinitas: json["salinitas"],
        temperature: json["temperature"],
        dO: json["do"],
        clarity: json["clarity"],
        orp: json["orp"],
        waterColor: json["water_color"],
        waterWeather: json["water_weather"],
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
