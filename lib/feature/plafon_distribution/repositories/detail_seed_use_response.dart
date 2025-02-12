import 'dart:convert';

class DetailSeedUseResponse {
  final List<DetailSeedUseResponseData>? data;
  final Pagination? pagination;

  DetailSeedUseResponse({
    this.data,
    this.pagination,
  });

  factory DetailSeedUseResponse.fromJson(String str) =>
      DetailSeedUseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailSeedUseResponse.fromMap(Map<String, dynamic> json) =>
      DetailSeedUseResponse(
        data: json['data'] == null
            ? []
            : List<DetailSeedUseResponseData>.from(
                json['data']!.map((x) => DetailSeedUseResponseData.fromMap(x)),
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

class DetailSeedUseResponseData {
  final String? id;
  final DateTime? tebarDate;
  final DateTime? estimationPanenDate;
  final String? actualPanenDate;
  final String? status;
  final int? tebarFishTotal;
  final String? fishseedId;
  final String? fishseedName;
  final int? fishseedPrice;
  final double? cost;

  DetailSeedUseResponseData({
    this.id,
    this.tebarDate,
    this.estimationPanenDate,
    this.actualPanenDate,
    this.status,
    this.tebarFishTotal,
    this.fishseedId,
    this.fishseedName,
    this.fishseedPrice,
    this.cost,
  });

  factory DetailSeedUseResponseData.fromJson(String str) =>
      DetailSeedUseResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailSeedUseResponseData.fromMap(Map<String, dynamic> json) =>
      DetailSeedUseResponseData(
        id: json['id'],
        tebarDate: json['tebar_date'] == null
            ? null
            : DateTime.parse(json['tebar_date']),
        estimationPanenDate: json['estimation_panen_date'] == null
            ? null
            : DateTime.parse(json['estimation_panen_date']),
        actualPanenDate: json['actual_panen_date'],
        status: json['status'],
        tebarFishTotal: json['tebar_fish_total'],
        fishseedId: json['fishseed_id'],
        fishseedName: json['fishseed_name'],
        fishseedPrice: json['fishseed_price'],
        cost: json['cost'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'tebar_date':
            "${tebarDate!.year.toString().padLeft(4, '0')}-${tebarDate!.month.toString().padLeft(2, '0')}-${tebarDate!.day.toString().padLeft(2, '0')}",
        'estimation_panen_date':
            "${estimationPanenDate!.year.toString().padLeft(4, '0')}-${estimationPanenDate!.month.toString().padLeft(2, '0')}-${estimationPanenDate!.day.toString().padLeft(2, '0')}",
        'actual_panen_date': actualPanenDate,
        'status': status,
        'tebar_fish_total': tebarFishTotal,
        'fishseed_id': fishseedId,
        'fishseed_name': fishseedName,
        'fishseed_price': fishseedPrice,
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
