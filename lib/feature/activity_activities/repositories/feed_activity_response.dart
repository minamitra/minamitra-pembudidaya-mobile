import 'dart:convert';

class FeedActivityResponse {
  List<FeedActivityResponseData>? data;
  Pagination? pagination;

  FeedActivityResponse({
    this.data,
    this.pagination,
  });

  factory FeedActivityResponse.fromJson(String str) =>
      FeedActivityResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedActivityResponse.fromMap(Map<String, dynamic> json) =>
      FeedActivityResponse(
        data: json["data"] == null
            ? []
            : List<FeedActivityResponseData>.from(
                json["data"]!.map((x) => FeedActivityResponseData.fromMap(x))),
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

class FeedActivityResponseData {
  String? id;
  String? memberId;
  String? fishpondId;
  String? fishpondcycleId;
  DateTime? datetime;
  String? fishAge;
  String? recommendation;
  String? actual;
  String? total;
  String? fishfoodId;
  String? fishfoodName;
  String? note;
  DateTime? createDatetime;
  String? createById;
  String? createByType;
  String? createByName;

  FeedActivityResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.fishAge,
    this.recommendation,
    this.actual,
    this.total,
    this.fishfoodId,
    this.fishfoodName,
    this.note,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
  });

  factory FeedActivityResponseData.fromJson(String str) =>
      FeedActivityResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedActivityResponseData.fromMap(Map<String, dynamic> json) =>
      FeedActivityResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        fishAge: json["fish_age"],
        recommendation: json["recommendation"],
        actual: json["actual"],
        total: json["total"],
        fishfoodId: json["fishfood_id"],
        fishfoodName: json["fishfood_name"],
        note: json["note"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createById: json["create_by_id"],
        createByType: json["create_by_type"],
        createByName: json["create_by_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "member_id": memberId,
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime?.toIso8601String(),
        "fish_age": fishAge,
        "recommendation": recommendation,
        "actual": actual,
        "total": total,
        "fishfood_id": fishfoodId,
        "fishfood_name": fishfoodName,
        "note": note,
        "create_datetime": createDatetime?.toIso8601String(),
        "create_by_id": createById,
        "create_by_type": createByType,
        "create_by_name": createByName,
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
