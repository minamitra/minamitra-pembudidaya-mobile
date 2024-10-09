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
  String? timeSheet;

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
      };
}
