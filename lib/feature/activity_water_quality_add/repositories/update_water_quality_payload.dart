import 'dart:convert';

class UpdateWaterQualityPayload {
  String? id;
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

  UpdateWaterQualityPayload({
    this.id,
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

  factory UpdateWaterQualityPayload.fromJson(String str) =>
      UpdateWaterQualityPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateWaterQualityPayload.fromMap(Map<String, dynamic> json) =>
      UpdateWaterQualityPayload(
        id: json["id"],
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
        "id": id,
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
