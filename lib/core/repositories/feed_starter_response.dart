import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/repositories/add_pond_cycle_payload.dart';

class FeedStarterResponse {
  List<FeedStarterResponseData>? data;
  Pagination? pagination;

  FeedStarterResponse({
    this.data,
    this.pagination,
  });

  factory FeedStarterResponse.fromJson(String str) =>
      FeedStarterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedStarterResponse.fromMap(Map<String, dynamic> json) =>
      FeedStarterResponse(
        data: json["data"] == null
            ? []
            : List<FeedStarterResponseData>.from(
                json["data"]!.map((x) => FeedStarterResponseData.fromMap(x))),
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

class FeedStarterResponseData {
  String? id;
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

  FeedStarterResponseData({
    this.id,
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

  factory FeedStarterResponseData.fromJson(String str) =>
      FeedStarterResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedStarterResponseData.fromMap(Map<String, dynamic> json) =>
      FeedStarterResponseData(
        id: json["id"],
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

  Finisher toFinisherObject() {
    return Finisher(
      id: int.parse(id ?? "0"),
      name: name ?? "",
    );
  }
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
