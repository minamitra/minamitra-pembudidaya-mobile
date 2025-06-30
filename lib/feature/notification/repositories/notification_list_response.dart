import 'dart:convert';

class NotificationListResponse {
  final List<NotificationListResponseData>? data;
  final Pagination? pagination;

  NotificationListResponse({
    this.data,
    this.pagination,
  });

  factory NotificationListResponse.fromJson(String str) =>
      NotificationListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationListResponse.fromMap(Map<String, dynamic> json) =>
      NotificationListResponse(
        data: json['data'] == null
            ? []
            : List<NotificationListResponseData>.from(
                json['data']!
                    .map((x) => NotificationListResponseData.fromMap(x)),
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

class NotificationListResponseData {
  final String? id;
  final String? type;
  final String? title;
  final String? message;
  final MetaJsonObject? metaJsonObject;
  final DateTime? createDatetime;
  final bool? isReadBool;
  final DateTime? updateDatetime;

  NotificationListResponseData({
    this.id,
    this.type,
    this.title,
    this.message,
    this.metaJsonObject,
    this.createDatetime,
    this.isReadBool,
    this.updateDatetime,
  });

  factory NotificationListResponseData.fromJson(String str) =>
      NotificationListResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationListResponseData.fromMap(Map<String, dynamic> json) =>
      NotificationListResponseData(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        message: json['message'],
        metaJsonObject: json['meta_json_object'] == null
            ? null
            : MetaJsonObject.fromMap(json['meta_json_object']),
        createDatetime:
            json['create_datetime'] == null || json['create_datetime'] == ''
                ? null
                : DateTime.parse(json['create_datetime']),
        isReadBool: json['is_read_bool'],
        updateDatetime:
            json['update_datetime'] == null || json['update_datetime'] == ''
                ? null
                : DateTime.parse(json['update_datetime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'title': title,
        'message': message,
        'meta_json_object': metaJsonObject?.toMap(),
        'create_datetime': createDatetime?.toIso8601String(),
        'is_read_bool': isReadBool,
        'update_datetime': updateDatetime?.toIso8601String(),
      };
}

class MetaJsonObject {
  MetaJsonObject();

  factory MetaJsonObject.fromJson(String str) =>
      MetaJsonObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaJsonObject.fromMap(Map<String, dynamic> json) => MetaJsonObject();

  Map<String, dynamic> toMap() => {};
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
