import 'dart:convert';

class PointBalanceResponse {
  final PointBalanceResponseData? data;

  PointBalanceResponse({
    this.data,
  });

  factory PointBalanceResponse.fromJson(String str) =>
      PointBalanceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointBalanceResponse.fromMap(Map<String, dynamic> json) =>
      PointBalanceResponse(
        data: json['data'] == null
            ? null
            : PointBalanceResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class PointBalanceResponseData {
  final String? levelName;
  final String? levelNote;
  final int? totalPoin;
  final int? totalPoinUsed;
  final int? totalPoinRemaining;

  PointBalanceResponseData({
    this.levelName,
    this.levelNote,
    this.totalPoin,
    this.totalPoinUsed,
    this.totalPoinRemaining,
  });

  factory PointBalanceResponseData.fromJson(String str) =>
      PointBalanceResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointBalanceResponseData.fromMap(Map<String, dynamic> json) =>
      PointBalanceResponseData(
        levelName: json['level_name'],
        levelNote: json['level_note'],
        totalPoin: json['total_poin'],
        totalPoinUsed: json['total_poin_used'],
        totalPoinRemaining: json['total_poin_remaining'],
      );

  Map<String, dynamic> toMap() => {
        'level_name': levelName,
        'level_note': levelNote,
        'total_poin': totalPoin,
        'total_poin_used': totalPoinUsed,
        'total_poin_remaining': totalPoinRemaining,
      };
}
