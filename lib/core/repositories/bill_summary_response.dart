import 'dart:convert';

class BillSummaryResponse {
  final BillSummaryResponseData? data;

  BillSummaryResponse({this.data});

  factory BillSummaryResponse.fromJson(String str) =>
      BillSummaryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillSummaryResponse.fromMap(Map<String, dynamic> json) =>
      BillSummaryResponse(
        data: json['data'] == null
            ? null
            : BillSummaryResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class BillSummaryResponseData {
  final String? memberCreditScore;
  final int? totalInvoice;
  final DateTime? nearestDueDate;

  BillSummaryResponseData({
    this.memberCreditScore,
    this.totalInvoice,
    this.nearestDueDate,
  });

  factory BillSummaryResponseData.fromJson(String str) =>
      BillSummaryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillSummaryResponseData.fromMap(Map<String, dynamic> json) =>
      BillSummaryResponseData(
        memberCreditScore: json['member_credit_score'],
        totalInvoice: json['total_invoice'],
        nearestDueDate:
            json['nearest_due_date'] == null || json['nearest_due_date'].isEmpty
                ? null
                : DateTime.parse(json['nearest_due_date']),
      );

  Map<String, dynamic> toMap() => {
        'member_credit_score': memberCreditScore,
        'total_invoice': totalInvoice,
        'nearest_due_date':
            "${nearestDueDate!.year.toString().padLeft(4, '0')}-${nearestDueDate!.month.toString().padLeft(2, '0')}-${nearestDueDate!.day.toString().padLeft(2, '0')}",
      };
}
