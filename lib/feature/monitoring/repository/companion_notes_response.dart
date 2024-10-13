import 'dart:convert';

class CompanionNotesResponse {
  List<CompanionNotesResponseData>? data;
  Pagination? pagination;

  CompanionNotesResponse({
    this.data,
    this.pagination,
  });

  factory CompanionNotesResponse.fromJson(String str) =>
      CompanionNotesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanionNotesResponse.fromMap(Map<String, dynamic> json) =>
      CompanionNotesResponse(
        data: json["data"] == null
            ? []
            : List<CompanionNotesResponseData>.from(json["data"]!
                .map((x) => CompanionNotesResponseData.fromMap(x))),
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

class CompanionNotesResponseData {
  String? id;
  String? userId;
  String? memberId;
  String? fishpondId;
  String? fishpondcycleId;
  String? content;
  List<dynamic>? attachmentJsonArray;
  DateTime? createDatetime;
  String? userName;
  String? userImageUrl;

  CompanionNotesResponseData({
    this.id,
    this.userId,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.content,
    this.attachmentJsonArray,
    this.createDatetime,
    this.userName,
    this.userImageUrl,
  });

  factory CompanionNotesResponseData.fromJson(String str) =>
      CompanionNotesResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanionNotesResponseData.fromMap(Map<String, dynamic> json) =>
      CompanionNotesResponseData(
        id: json["id"],
        userId: json["user_id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        content: json["content"],
        attachmentJsonArray: json["attachment_json_array"] == null
            ? []
            : List<dynamic>.from(json["attachment_json_array"]!.map((x) => x)),
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        userName: json["user_name"],
        userImageUrl: json["user_image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "member_id": memberId,
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "content": content,
        "attachment_json_array": attachmentJsonArray == null
            ? []
            : List<dynamic>.from(attachmentJsonArray!.map((x) => x)),
        "create_datetime": createDatetime?.toIso8601String(),
        "user_name": userName,
        "user_image_url": userImageUrl,
      };
}

class Pagination {
  int? totalData;
  int? totalPage;
  int? totalDisplay;
  bool? firstPage;
  bool? lastPage;
  int? prev;
  int? current;
  int? next;
  List<dynamic>? detail;
  int? start;
  int? end;

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
