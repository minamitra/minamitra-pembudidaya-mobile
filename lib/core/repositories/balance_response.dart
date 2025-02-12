import 'dart:convert';

class BalanceResponse {
  final BalanceResponseData? data;

  BalanceResponse({this.data});

  factory BalanceResponse.fromJson(String str) =>
      BalanceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BalanceResponse.fromMap(Map<String, dynamic> json) => BalanceResponse(
        data: json['data'] == null
            ? null
            : BalanceResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {'data': data?.toMap()};
}

class BalanceResponseData {
  final double? totalPlafon;
  final double? totalUsed;
  final double? totalSaldoRemaining;

  BalanceResponseData({
    this.totalPlafon,
    this.totalUsed,
    this.totalSaldoRemaining,
  });

  factory BalanceResponseData.fromJson(String str) =>
      BalanceResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BalanceResponseData.fromMap(Map<String, dynamic> json) =>
      BalanceResponseData(
        totalPlafon: json['total_plafon']?.toDouble(),
        totalUsed: json['total_used']?.toDouble(),
        totalSaldoRemaining: json['total_saldo_remaining']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'total_plafon': totalPlafon,
        'total_used': totalUsed,
        'total_saldo_remaining': totalSaldoRemaining,
      };
}
