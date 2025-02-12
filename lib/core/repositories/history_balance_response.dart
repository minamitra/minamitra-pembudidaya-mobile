import 'dart:convert';

class HistoryBalanceResponse {
  final List<HistoryBalanceResponseData>? data;
  final Pagination? pagination;

  HistoryBalanceResponse({
    this.data,
    this.pagination,
  });

  factory HistoryBalanceResponse.fromJson(String str) =>
      HistoryBalanceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryBalanceResponse.fromMap(Map<String, dynamic> json) =>
      HistoryBalanceResponse(
        data: json['data'] == null
            ? []
            : List<HistoryBalanceResponseData>.from(
                json['data']!.map((x) => HistoryBalanceResponseData.fromMap(x)),
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

class HistoryBalanceResponseData {
  final String? id;
  final String? memberId;
  final String? category;
  final String? desc;
  final String? type;
  final int? nominal;
  final DateTime? dateTime;

  HistoryBalanceResponseData({
    this.id,
    this.memberId,
    this.category,
    this.desc,
    this.type,
    this.nominal,
    this.dateTime,
  });

  factory HistoryBalanceResponseData.fromJson(String str) =>
      HistoryBalanceResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryBalanceResponseData.fromMap(Map<String, dynamic> json) =>
      HistoryBalanceResponseData(
        id: json['id'],
        memberId: json['member_id'],
        category: json['category'],
        desc: json['desc'],
        type: json['type'],
        nominal: json['nominal'],
        dateTime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'category': category,
        'desc': desc,
        'type': type,
        'nominal': nominal,
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
