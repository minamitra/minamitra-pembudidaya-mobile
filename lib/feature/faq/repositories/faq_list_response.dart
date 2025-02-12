import 'dart:convert';

class FaqListResponse {
  final List<FaqListResponseData>? data;
  final Pagination? pagination;

  FaqListResponse({
    this.data,
    this.pagination,
  });

  factory FaqListResponse.fromJson(String str) =>
      FaqListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqListResponse.fromMap(Map<String, dynamic> json) => FaqListResponse(
        data: json['data'] == null
            ? []
            : List<FaqListResponseData>.from(
                json['data']!.map((x) => FaqListResponseData.fromMap(x)),
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

class FaqListResponseData {
  final String? id;
  final String? question;
  final String? answer;

  FaqListResponseData({
    this.id,
    this.question,
    this.answer,
  });

  factory FaqListResponseData.fromJson(String str) =>
      FaqListResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqListResponseData.fromMap(Map<String, dynamic> json) =>
      FaqListResponseData(
        id: json['id'],
        question: json['question'],
        answer: json['answer'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'question': question,
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
