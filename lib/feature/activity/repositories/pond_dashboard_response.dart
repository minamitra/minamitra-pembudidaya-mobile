import 'dart:convert';

class PondDashboardResponse {
  PondDashboardResponseData? data;

  PondDashboardResponse({
    this.data,
  });

  factory PondDashboardResponse.fromJson(String str) =>
      PondDashboardResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PondDashboardResponse.fromMap(Map<String, dynamic> json) =>
      PondDashboardResponse(
        data: json["data"] == null
            ? null
            : PondDashboardResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class PondDashboardResponseData {
  double? totalFishpondActive;
  double? totalBiomas;
  double? totalFeeding;
  double? avgSurvivalRate;
  double? salesEstimate;

  PondDashboardResponseData({
    this.totalFishpondActive,
    this.totalBiomas,
    this.totalFeeding,
    this.avgSurvivalRate,
    this.salesEstimate,
  });

  factory PondDashboardResponseData.fromJson(String str) =>
      PondDashboardResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PondDashboardResponseData.fromMap(Map<String, dynamic> json) =>
      PondDashboardResponseData(
        totalFishpondActive:
            double.parse(json["total_fishpond_active"]?.toString() ?? "0"),
        totalBiomas: double.parse(json["total_biomas"]?.toString() ?? "0"),
        totalFeeding: double.parse(json["total_feeding"]?.toString() ?? "0"),
        avgSurvivalRate:
            double.parse(json["avg_survival_rate"]?.toString() ?? "0"),
        salesEstimate: double.parse(json["sales_estimate"]?.toString() ?? "0"),
      );

  Map<String, dynamic> toMap() => {
        "total_fishpond_active": totalFishpondActive,
        "total_biomas": totalBiomas,
        "total_feeding": totalFeeding,
        "avg_survival_rate": avgSurvivalRate,
        "sales_estimate": salesEstimate,
      };
}
