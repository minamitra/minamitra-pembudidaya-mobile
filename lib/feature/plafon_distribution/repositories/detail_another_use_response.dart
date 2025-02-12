import 'dart:convert';

class DetailAnotherUseResponse {
  final List<DetailAnotherUseResponseData>? data;
  final Pagination? pagination;

  DetailAnotherUseResponse({
    this.data,
    this.pagination,
  });

  factory DetailAnotherUseResponse.fromJson(String str) =>
      DetailAnotherUseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailAnotherUseResponse.fromMap(Map<String, dynamic> json) =>
      DetailAnotherUseResponse(
        data: json['data'] == null
            ? []
            : List<DetailAnotherUseResponseData>.from(
                json['data']!
                    .map((x) => DetailAnotherUseResponseData.fromMap(x)),
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

class DetailAnotherUseResponseData {
  final String? id;
  final DateTime? date;
  final String? type;
  final int? cost;

  DetailAnotherUseResponseData({
    this.id,
    this.date,
    this.type,
    this.cost,
  });

  factory DetailAnotherUseResponseData.fromJson(String str) =>
      DetailAnotherUseResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailAnotherUseResponseData.fromMap(Map<String, dynamic> json) =>
      DetailAnotherUseResponseData(
        id: json['id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        type: json['type'],
        cost: json['cost'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date':
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        'type': type,
        'cost': cost,
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
