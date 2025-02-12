import 'dart:convert';

class PointHistoryResponse {
  final List<PointHistoryResponseData>? data;
  final Pagination? pagination;

  PointHistoryResponse({
    this.data,
    this.pagination,
  });

  factory PointHistoryResponse.fromJson(String str) =>
      PointHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointHistoryResponse.fromMap(Map<String, dynamic> json) =>
      PointHistoryResponse(
        data: json['data'] == null
            ? []
            : List<PointHistoryResponseData>.from(
                json['data']!.map((x) => PointHistoryResponseData.fromMap(x)),
              ),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromMap(json['pagination']),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        'pagination': pagination?.toMap(),
      };
}

class PointHistoryResponseData {
  final String? id;
  final String? memberId;
  final String? desc;
  final String? type;
  final int? poin;
  final DateTime? datetime;

  PointHistoryResponseData({
    this.id,
    this.memberId,
    this.desc,
    this.type,
    this.poin,
    this.datetime,
  });

  factory PointHistoryResponseData.fromJson(String str) =>
      PointHistoryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointHistoryResponseData.fromMap(Map<String, dynamic> json) =>
      PointHistoryResponseData(
        id: json['id'],
        memberId: json['member_id'],
        desc: json['desc'],
        type: json['type'],
        poin: json['poin'],
        datetime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'desc': desc,
        'type': type,
        'poin': poin,
        'datetime': datetime?.toIso8601String(),
      };
}

class Pagination {
  final int? totalData;
  final int? totalPage;
  final int? totalDisplay;
  final bool? firstPage;
  final bool? lastPage;
  final int? prev;
  final int? current;
  final int? next;
  final List<dynamic>? detail;
  final int? start;
  final int? end;

  Pagination({
    this.totalData,
    this.totalPage,
    this.totalDisplay,
    this.firstPage,
    this.lastPage,
    this.prev,
    this.current,
    this.next,
    this.detail,
    this.start,
    this.end,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        totalData: json['total_data'],
        totalPage: json['total_page'],
        totalDisplay: json['total_display'],
        firstPage: json['first_page'],
        lastPage: json['last_page'],
        prev: json['prev'],
        current: json['current'],
        next: json['next'],
        detail: json['detail'] == null
            ? []
            : List<dynamic>.from(json['detail']!.map((x) => x)),
        start: json['start'],
        end: json['end'],
      );

  Map<String, dynamic> toMap() => {
        'total_data': totalData,
        'total_page': totalPage,
        'total_display': totalDisplay,
        'first_page': firstPage,
        'last_page': lastPage,
        'prev': prev,
        'current': current,
        'next': next,
        'detail':
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        'start': start,
        'end': end,
      };
}
