import 'dart:convert';

class LiteracyInformationResponse {
  final List<LiteracyInformationResponseData>? data;
  final Pagination? pagination;

  LiteracyInformationResponse({
    this.data,
    this.pagination,
  });

  factory LiteracyInformationResponse.fromJson(String str) =>
      LiteracyInformationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiteracyInformationResponse.fromMap(Map<String, dynamic> json) =>
      LiteracyInformationResponse(
        data: json['data'] == null
            ? []
            : List<LiteracyInformationResponseData>.from(
                json['data']!
                    .map((x) => LiteracyInformationResponseData.fromMap(x)),
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

class LiteracyInformationResponseData {
  final String? id;
  final String? authorName;
  final String? imageUrl;
  final String? title;
  final String? content;
  final DateTime? createDatetime;

  LiteracyInformationResponseData({
    this.id,
    this.authorName,
    this.imageUrl,
    this.title,
    this.content,
    this.createDatetime,
  });

  factory LiteracyInformationResponseData.fromJson(String str) =>
      LiteracyInformationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiteracyInformationResponseData.fromMap(Map<String, dynamic> json) =>
      LiteracyInformationResponseData(
        id: json['id'],
        authorName: json['author_name'],
        imageUrl: json['image_url'],
        title: json['title'],
        content: json['content'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'author_name': authorName,
        'image_url': imageUrl,
        'title': title,
        'content': content,
        'create_datetime': createDatetime?.toIso8601String(),
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
