import 'dart:convert';

class DeliveryStatusResponse {
  final List<DeliveryStatusResponseData>? data;
  final Pagination? pagination;

  DeliveryStatusResponse({
    this.data,
    this.pagination,
  });

  factory DeliveryStatusResponse.fromJson(String str) =>
      DeliveryStatusResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryStatusResponse.fromMap(Map<String, dynamic> json) =>
      DeliveryStatusResponse(
        data: json['data'] == null
            ? []
            : List<DeliveryStatusResponseData>.from(json['data']!
                .map((x) => DeliveryStatusResponseData.fromMap(x))),
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

class DeliveryStatusResponseData {
  final String? id;
  final String? orderId;
  final String? memberId;
  final DateTime? datetime;
  final String? note;

  DeliveryStatusResponseData({
    this.id,
    this.orderId,
    this.memberId,
    this.datetime,
    this.note,
  });

  factory DeliveryStatusResponseData.fromJson(String str) =>
      DeliveryStatusResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryStatusResponseData.fromMap(Map<String, dynamic> json) =>
      DeliveryStatusResponseData(
        id: json['id'],
        orderId: json['order_id'],
        memberId: json['member_id'],
        datetime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        note: json['note'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_id': orderId,
        'member_id': memberId,
        'datetime': datetime?.toIso8601String(),
        'note': note,
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
