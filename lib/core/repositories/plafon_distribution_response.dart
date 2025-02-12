import 'dart:convert';

class PlafonDistributionResponse {
  final List<PlafonDistributionResponseData>? data;
  final Pagination? pagination;

  PlafonDistributionResponse({
    this.data,
    this.pagination,
  });

  factory PlafonDistributionResponse.fromJson(String str) =>
      PlafonDistributionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonDistributionResponse.fromMap(Map<String, dynamic> json) =>
      PlafonDistributionResponse(
        data: json['data'] == null
            ? []
            : List<PlafonDistributionResponseData>.from(
                json['data']!.map(
                  (x) => PlafonDistributionResponseData.fromMap(x),
                ),
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

class PlafonDistributionResponseData {
  final String? id;
  final String? name;
  final int? sumCostNominal;
  final double? percentage;

  PlafonDistributionResponseData({
    this.id,
    this.name,
    this.sumCostNominal,
    this.percentage,
  });

  factory PlafonDistributionResponseData.fromJson(String str) =>
      PlafonDistributionResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonDistributionResponseData.fromMap(
    Map<String, dynamic> json,
  ) =>
      PlafonDistributionResponseData(
        id: json['id'],
        name: json['name'],
        sumCostNominal: json['sum_cost_nominal'],
        percentage: json['percentage']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'sum_cost_nominal': sumCostNominal,
        'percentage': percentage,
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
