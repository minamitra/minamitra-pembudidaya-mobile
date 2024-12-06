import 'dart:convert';

class FinanceResponse {
  final List<FinanceResponseData>? data;

  FinanceResponse({this.data});

  factory FinanceResponse.fromJson(String str) =>
      FinanceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinanceResponse.fromMap(Map<String, dynamic> json) => FinanceResponse(
        data: json['data'] == null
            ? []
            : List<FinanceResponseData>.from(
                json['data']!.map((x) => FinanceResponseData.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class FinanceResponseData {
  final DateTime? periodeSiklusStart;
  final DateTime? periodeSiklusEnd;
  final String? status;
  final int? totalBiayaProduksi;
  final int? totalPendapatan;
  final double? persentaseLabaRugi;
  final int? labaRugi;
  final double? hppPerEkor;
  final double? hppPerKg;
  final String? fishPondCycleID;
  final double? totalBiayaPakan;
  final double? totalBiayaBenih;
  final double? totalBiayaThreatment;

  FinanceResponseData({
    this.periodeSiklusStart,
    this.periodeSiklusEnd,
    this.status,
    this.totalBiayaProduksi,
    this.totalPendapatan,
    this.persentaseLabaRugi,
    this.labaRugi,
    this.hppPerEkor,
    this.hppPerKg,
    this.fishPondCycleID,
    this.totalBiayaPakan,
    this.totalBiayaBenih,
    this.totalBiayaThreatment,
  });

  factory FinanceResponseData.fromJson(String str) =>
      FinanceResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinanceResponseData.fromMap(Map<String, dynamic> json) =>
      FinanceResponseData(
        periodeSiklusStart: json['periode_siklus_start'] == null
            ? null
            : DateTime.parse(json['periode_siklus_start']),
        periodeSiklusEnd: json['periode_siklus_end'] == null
            ? null
            : DateTime.parse(json['periode_siklus_end']),
        status: json['status'],
        totalBiayaProduksi: json['total_biaya_produksi'],
        totalPendapatan: json['total_pendapatan'],
        persentaseLabaRugi: json['persentase_laba_rugi']?.toDouble(),
        labaRugi: json['laba_rugi'],
        hppPerEkor: json['hpp_per_ekor']?.toDouble(),
        hppPerKg: json['hpp_per_kg']?.toDouble(),
        fishPondCycleID: json['fishpondcycle_id'],
        totalBiayaPakan: json['total_biaya_pakan']?.toDouble(),
        totalBiayaBenih: json['total_biaya_benih']?.toDouble(),
        totalBiayaThreatment: json['total_biaya_threatment']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'periode_siklus_start':
            "${periodeSiklusStart!.year.toString().padLeft(4, '0')}-${periodeSiklusStart!.month.toString().padLeft(2, '0')}-${periodeSiklusStart!.day.toString().padLeft(2, '0')}",
        'periode_siklus_end':
            "${periodeSiklusEnd!.year.toString().padLeft(4, '0')}-${periodeSiklusEnd!.month.toString().padLeft(2, '0')}-${periodeSiklusEnd!.day.toString().padLeft(2, '0')}",
        'status': status,
        'total_biaya_produksi': totalBiayaProduksi,
        'total_pendapatan': totalPendapatan,
        'persentase_laba_rugi': persentaseLabaRugi,
        'laba_rugi': labaRugi,
        'hpp_per_ekor': hppPerEkor,
        'hpp_per_kg': hppPerKg,
      };
}
