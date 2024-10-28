import 'dart:convert';

class AddFishFeedBody {
  int? fishpondId;
  int? fishpondcycleId;
  DateTime? datetime;
  int? fishAge;
  double? recommendation;
  double? actual;
  double? total;
  int? fishfoodId;
  String? note;
  String? dataID;
  // time_sheet_json_array
  String? timeSheet;
  List<String>? timeSheetJsonArray;

  AddFishFeedBody({
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.fishAge,
    this.recommendation,
    this.actual,
    this.total,
    this.fishfoodId,
    this.note,
    this.dataID,
    this.timeSheet,
    this.timeSheetJsonArray,
  });

  factory AddFishFeedBody.fromJson(String str) =>
      AddFishFeedBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  String toEditJson() => json.encode(toEditMap());

  factory AddFishFeedBody.fromMap(Map<String, dynamic> json) => AddFishFeedBody(
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        fishAge: json["fish_age"],
        recommendation: json["recommendation"]?.toDouble(),
        actual: json["actual"]?.toDouble(),
        total: json["total"]?.toDouble(),
        fishfoodId: json["fishfood_id"],
        note: json["note"],
        timeSheet: json["time_sheet"],
        timeSheetJsonArray: json["time_sheet_json_array"] == null
            ? null
            : List<String>.from(json["time_sheet_json_array"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime?.toIso8601String(),
        "fish_age": fishAge,
        "recommendation": recommendation,
        "actual": actual,
        "total": total,
        "fishfood_id": fishfoodId,
        "note": note,
        "time_sheet": timeSheet,
        "time_sheet_json_array": timeSheetJsonArray == null
            ? null
            : List<dynamic>.from(timeSheetJsonArray!.map((x) => x)),
      };

  Map<String, dynamic> toEditMap() => {
        "id": dataID,
        "datetime": datetime?.toIso8601String(),
        "fish_age": fishAge,
        "recommendation": recommendation,
        "actual": actual,
        "total": total,
        "fishfood_id": fishfoodId,
        "note": note,
        "time_sheet": timeSheet,
        "time_sheet_json_array": timeSheetJsonArray == null
            ? null
            : List<dynamic>.from(timeSheetJsonArray!.map((x) => x)),
      };
}
