import 'dart:convert';

class FeedDataByCycleResponse {
  List<FeedDataByCycleResponseData>? data;
  Pagination? pagination;

  FeedDataByCycleResponse({
    this.data,
    this.pagination,
  });

  factory FeedDataByCycleResponse.fromJson(String str) =>
      FeedDataByCycleResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedDataByCycleResponse.fromMap(Map<String, dynamic> json) =>
      FeedDataByCycleResponse(
        data: json["data"] == null
            ? []
            : List<FeedDataByCycleResponseData>.from(json["data"]!
                .map((x) => FeedDataByCycleResponseData.fromMap(x))),
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

class FeedDataByCycleResponseData {
  String? id;
  String? fishpondId;
  String? fishpondcycleId;
  String? type;
  String? name;
  String? weight;
  String? proteinPercent;
  String? eppEstimationPercent;
  String? price;
  String? unitId;
  String? unitName;
  String? supplierId;
  String? supplierName;
  String? note;
  bool? activeBool;

  FeedDataByCycleResponseData({
    this.id,
    this.fishpondId,
    this.fishpondcycleId,
    this.type,
    this.name,
    this.weight,
    this.proteinPercent,
    this.eppEstimationPercent,
    this.price,
    this.unitId,
    this.unitName,
    this.supplierId,
    this.supplierName,
    this.note,
    this.activeBool,
  });

  factory FeedDataByCycleResponseData.fromJson(String str) =>
      FeedDataByCycleResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedDataByCycleResponseData.fromMap(Map<String, dynamic> json) =>
      FeedDataByCycleResponseData(
        id: json["id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        type: json["type"],
        name: json["name"],
        weight: json["weight"],
        proteinPercent: json["protein_percent"],
        eppEstimationPercent: json["epp_estimation_percent"],
        price: json["price"],
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        note: json["note"],
        activeBool: json["active_bool"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "type": type,
        "name": name,
        "weight": weight,
        "protein_percent": proteinPercent,
        "epp_estimation_percent": eppEstimationPercent,
        "price": price,
        "unit_id": unitId,
        "unit_name": unitName,
        "supplier_id": supplierId,
        "supplier_name": supplierName,
        "note": note,
        "active_bool": activeBool,
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
