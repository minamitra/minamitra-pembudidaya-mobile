import 'dart:convert';

class FinanceSummaryResponse {
  final FinanceSummaryResponseData? data;

  FinanceSummaryResponse({this.data});

  factory FinanceSummaryResponse.fromJson(String str) =>
      FinanceSummaryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinanceSummaryResponse.fromMap(Map<String, dynamic> json) =>
      FinanceSummaryResponse(
        data: json['data'] == null
            ? null
            : FinanceSummaryResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class FinanceSummaryResponseData {
  final double? totalBiayaProduksi;
  final double? totalPendapatan;
  final double? persentaseLabaRugi;
  final double? labaRugi;
  final double? hppPerEkor;
  final double? hppPerKg;

  FinanceSummaryResponseData({
    this.totalBiayaProduksi,
    this.totalPendapatan,
    this.persentaseLabaRugi,
    this.labaRugi,
    this.hppPerEkor,
    this.hppPerKg,
  });

  factory FinanceSummaryResponseData.fromJson(String str) =>
      FinanceSummaryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinanceSummaryResponseData.fromMap(Map<String, dynamic> json) =>
      FinanceSummaryResponseData(
        totalBiayaProduksi: json['total_biaya_produksi']?.toDouble(),
        totalPendapatan: json['total_pendapatan']?.toDouble(),
        persentaseLabaRugi: json['persentase_laba_rugi']?.toDouble(),
        labaRugi: json['laba_rugi']?.toDouble(),
        hppPerEkor: json['hpp_per_ekor']?.toDouble(),
        hppPerKg: json['hpp_per_kg']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'total_biaya_produksi': totalBiayaProduksi,
        'total_pendapatan': totalPendapatan,
        'persentase_laba_rugi': persentaseLabaRugi,
        'laba_rugi': labaRugi,
        'hpp_per_ekor': hppPerEkor,
        'hpp_per_kg': hppPerKg,
      };
}
