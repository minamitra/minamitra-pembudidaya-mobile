import 'dart:convert';

class UnitResponse {
  final List<UnitResponseData>? data;
  final Pagination? pagination;

  UnitResponse({
    this.data,
    this.pagination,
  });

  factory UnitResponse.fromJson(String str) =>
      UnitResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UnitResponse.fromMap(Map<String, dynamic> json) => UnitResponse(
        data: json['data'] == null
            ? []
            : List<UnitResponseData>.from(
                json['data']!.map((x) => UnitResponseData.fromMap(x)),
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

class UnitResponseData {
  final String? id;
  final String? name;
  final String? productCount;

  UnitResponseData({
    this.id,
    this.name,
    this.productCount,
  });

  factory UnitResponseData.fromJson(String str) =>
      UnitResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UnitResponseData.fromMap(Map<String, dynamic> json) =>
      UnitResponseData(
        id: json['id'],
        name: json['name'],
        productCount: json['product_count'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'product_count': productCount,
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
