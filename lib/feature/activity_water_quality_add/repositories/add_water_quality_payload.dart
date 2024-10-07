import 'dart:convert';

class AddWaterQualityPayload {
  int? fishpondId;
  int? fishpondcycleId;
  DateTime? datetime;
  double? level;
  double? ph;
  double? salinitas;
  double? temperature;
  double? dissolvedOxygen;
  double? clarity;
  double? orp;
  String? waterColor;
  String? waterWeather;
  String? note;
  List<String>? attachmentJsonArray;

  AddWaterQualityPayload({
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.level,
    this.ph,
    this.salinitas,
    this.temperature,
    this.dissolvedOxygen,
    this.clarity,
    this.orp,
    this.waterColor,
    this.waterWeather,
    this.note,
    this.attachmentJsonArray,
  });

  factory AddWaterQualityPayload.fromJson(String str) =>
      AddWaterQualityPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddWaterQualityPayload.fromMap(Map<String, dynamic> json) =>
      AddWaterQualityPayload(
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime: json["datetime"],
        level: json["level"],
        ph: json["ph"],
        salinitas: json["salinitas"],
        temperature: json["temperature"],
        dissolvedOxygen: json["do"],
        clarity: json["clarity"],
        orp: json["orp"],
        waterColor: json["water_color"],
        waterWeather: json["water_weather"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime!.toIso8601String(),
        "level": level,
        "ph": ph,
        "salinitas": salinitas,
        "temperature": temperature,
        "do": dissolvedOxygen,
        "clarity": clarity,
        "orp": orp,
        "water_color": waterColor,
        "water_weather": waterWeather,
        "note": note,
        "attachment_json_array": attachmentJsonArray ?? [],
      };
}
