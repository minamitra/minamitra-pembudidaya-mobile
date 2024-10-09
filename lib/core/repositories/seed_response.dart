import 'dart:convert';

class SeedResponse {
  List<SeedResponseData>? data;
  Pagination? pagination;

  SeedResponse({
    this.data,
    this.pagination,
  });

  factory SeedResponse.fromJson(String str) =>
      SeedResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SeedResponse.fromMap(Map<String, dynamic> json) => SeedResponse(
        data: json["data"] == null
            ? []
            : List<SeedResponseData>.from(
                json["data"]!.map((x) => SeedResponseData.fromMap(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
      );

  SeedResponse copyWith({
    List<SeedResponseData>? data,
    Pagination? pagination,
  }) {
    return SeedResponse(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "pagination": pagination?.toMap(),
      };
}

class SeedResponseData {
  String? id;
  String? name;
  String? age;
  String? bobot;
  String? price;
  String? varietasId;
  String? varietasName;
  String? hatcheryId;
  String? hatcheryName;
  String? note;
  bool? activeBool;
  DateTime? createDatetime;
  String? createById;
  String? createByType;
  String? createByName;

  SeedResponseData({
    this.id,
    this.name,
    this.age,
    this.bobot,
    this.price,
    this.varietasId,
    this.varietasName,
    this.hatcheryId,
    this.hatcheryName,
    this.note,
    this.activeBool,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
  });

  factory SeedResponseData.fromJson(String str) =>
      SeedResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SeedResponseData.fromMap(Map<String, dynamic> json) =>
      SeedResponseData(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        bobot: json["bobot"],
        price: json["price"],
        varietasId: json["varietas_id"],
        varietasName: json["varietas_name"],
        hatcheryId: json["hatchery_id"],
        hatcheryName: json["hatchery_name"],
        note: json["note"],
        activeBool: json["active_bool"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createById: json["create_by_id"],
        createByType: json["create_by_type"],
        createByName: json["create_by_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "bobot": bobot,
        "price": price,
        "varietas_id": varietasId,
        "varietas_name": varietasName,
        "hatchery_id": hatcheryId,
        "hatchery_name": hatcheryName,
        "note": note,
        "active_bool": activeBool,
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
