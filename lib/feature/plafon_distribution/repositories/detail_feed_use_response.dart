import 'dart:convert';

class DetailFeedUseResponse {
  final List<DetailFeedUseResponseData>? data;
  final Pagination? pagination;

  DetailFeedUseResponse({
    this.data,
    this.pagination,
  });

  factory DetailFeedUseResponse.fromJson(String str) =>
      DetailFeedUseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailFeedUseResponse.fromMap(Map<String, dynamic> json) =>
      DetailFeedUseResponse(
        data: json['data'] == null
            ? []
            : List<DetailFeedUseResponseData>.from(
                json['data']!.map((x) => DetailFeedUseResponseData.fromMap(x)),
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

class DetailFeedUseResponseData {
  final String? id;
  final DateTime? datetime;
  final String? fishfoodId;
  final String? fishfoodName;
  final String? fishfoodType;
  final int? fishfoodPrice;
  final double? actual;
  final double? cost;

  DetailFeedUseResponseData({
    this.id,
    this.datetime,
    this.fishfoodId,
    this.fishfoodName,
    this.fishfoodType,
    this.fishfoodPrice,
    this.actual,
    this.cost,
  });

  factory DetailFeedUseResponseData.fromJson(String str) =>
      DetailFeedUseResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailFeedUseResponseData.fromMap(Map<String, dynamic> json) =>
      DetailFeedUseResponseData(
        id: json['id'],
        datetime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        fishfoodId: json['fishfood_id'],
        fishfoodName: json['fishfood_name'],
        fishfoodType: json['fishfood_type'],
        fishfoodPrice: json['fishfood_price'],
        actual: json['actual']?.toDouble(),
        cost: json['cost']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'datetime': datetime?.toIso8601String(),
        'fishfood_id': fishfoodId,
        'fishfood_name': fishfoodName,
        'fishfood_type': fishfoodType,
        'fishfood_price': fishfoodPrice,
        'actual': actual,
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
