import 'dart:convert';

class DetailTreatmentUseResponse {
  final List<DetailTreatmentUseResponseData>? data;
  final Pagination? pagination;

  DetailTreatmentUseResponse({
    this.data,
    this.pagination,
  });

  factory DetailTreatmentUseResponse.fromJson(String str) =>
      DetailTreatmentUseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailTreatmentUseResponse.fromMap(Map<String, dynamic> json) =>
      DetailTreatmentUseResponse(
        data: json['data'] == null
            ? []
            : List<DetailTreatmentUseResponseData>.from(
                json['data']!
                    .map((x) => DetailTreatmentUseResponseData.fromMap(x)),
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

class DetailTreatmentUseResponseData {
  final String? id;
  final DateTime? datetime;
  final String? name;
  final String? note;
  final int? cost;

  DetailTreatmentUseResponseData({
    this.id,
    this.datetime,
    this.name,
    this.note,
    this.cost,
  });

  factory DetailTreatmentUseResponseData.fromJson(String str) =>
      DetailTreatmentUseResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailTreatmentUseResponseData.fromMap(Map<String, dynamic> json) =>
      DetailTreatmentUseResponseData(
        id: json['id'],
        datetime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        name: json['name'],
        note: json['note'],
        cost: json['cost'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'datetime': datetime?.toIso8601String(),
        'name': name,
        'note': note,
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
