import 'dart:convert';

class PlafonSummaryResponse {
  final PlafonSummaryResponseData? data;

  PlafonSummaryResponse({
    this.data,
  });

  factory PlafonSummaryResponse.fromJson(String str) =>
      PlafonSummaryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonSummaryResponse.fromMap(Map<String, dynamic> json) =>
      PlafonSummaryResponse(
        data: json['data'] == null
            ? null
            : PlafonSummaryResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class PlafonSummaryResponseData {
  final int? totalPlafon;
  final int? totalCost;
  final int? totalRemaining;
  final DateTime? nearestDueDate;

  PlafonSummaryResponseData({
    this.totalPlafon,
    this.totalCost,
    this.totalRemaining,
    this.nearestDueDate,
  });

  factory PlafonSummaryResponseData.fromJson(String str) =>
      PlafonSummaryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonSummaryResponseData.fromMap(Map<String, dynamic> json) =>
      PlafonSummaryResponseData(
        totalPlafon: json['total_plafon'],
        totalCost: json['total_cost'],
        totalRemaining: json['total_remaining'],
        nearestDueDate: json['nearest_due_date'] == null
            ? null
            : DateTime.parse(json['nearest_due_date']),
      );

  Map<String, dynamic> toMap() => {
        'total_plafon': totalPlafon,
        'total_cost': totalCost,
        'total_remaining': totalRemaining,
        'nearest_due_date':
            "${nearestDueDate!.year.toString().padLeft(4, '0')}-${nearestDueDate!.month.toString().padLeft(2, '0')}-${nearestDueDate!.day.toString().padLeft(2, '0')}",
      };
}
