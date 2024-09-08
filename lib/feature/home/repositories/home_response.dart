import 'dart:convert';

class HomeResponse {
  final List<HomeResponseData>? data;
  final Pagination? pagination;

  HomeResponse({
    this.data,
    this.pagination,
  });

  factory HomeResponse.fromJson(String str) =>
      HomeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeResponse.fromMap(Map<String, dynamic> json) => HomeResponse(
        data: json["data"] == null
            ? []
            : List<HomeResponseData>.from(
                json["data"]!.map((x) => HomeResponseData.fromMap(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "pagination": pagination?.toMap(),
      };
}

class HomeResponseData {
  final String? id;
  final List<String>? platformJsonArray;
  final String? imageUrl;
  final String? title;
  final String? desc;
  final DateTime? startDatetime;
  final DateTime? endDatetime;
  final String? linkUrl;
  final bool? activeBool;

  HomeResponseData({
    this.id,
    this.platformJsonArray,
    this.imageUrl,
    this.title,
    this.desc,
    this.startDatetime,
    this.endDatetime,
    this.linkUrl,
    this.activeBool,
  });

  factory HomeResponseData.fromJson(String str) =>
      HomeResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeResponseData.fromMap(Map<String, dynamic> json) =>
      HomeResponseData(
        id: json["id"],
        platformJsonArray: json["platform_json_array"] == null
            ? []
            : List<String>.from(json["platform_json_array"]!.map((x) => x)),
        imageUrl: json["image_url"],
        title: json["title"],
        desc: json["desc"],
        startDatetime: json["start_datetime"] == null
            ? null
            : DateTime.parse(json["start_datetime"]),
        endDatetime: json["end_datetime"] == null
            ? null
            : DateTime.parse(json["end_datetime"]),
        linkUrl: json["link_url"],
        activeBool: json["active_bool"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "platform_json_array": platformJsonArray == null
            ? []
            : List<dynamic>.from(platformJsonArray!.map((x) => x)),
        "image_url": imageUrl,
        "title": title,
        "desc": desc,
        "start_datetime": startDatetime?.toIso8601String(),
        "end_datetime": endDatetime?.toIso8601String(),
        "link_url": linkUrl,
        "active_bool": activeBool,
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
        totalData: json["total_data"],
        totalPage: json["total_page"],
        totalDisplay: json["total_display"],
        firstPage: json["first_page"],
        lastPage: json["last_page"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        detail: json["detail"] == null
            ? []
            : List<dynamic>.from(json["detail"]!.map((x) => x)),
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toMap() => {
        "total_data": totalData,
        "total_page": totalPage,
        "total_display": totalDisplay,
        "first_page": firstPage,
        "last_page": lastPage,
        "prev": prev,
        "current": current,
        "next": next,
        "detail":
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        "start": start,
        "end": end,
      };
}
