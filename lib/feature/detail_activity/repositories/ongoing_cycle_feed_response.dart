import 'dart:convert';

class OnGoingCycleFeedResponse {
  List<OnGoingCycleFeedResponseData>? data;
  Pagination? pagination;

  OnGoingCycleFeedResponse({
    this.data,
    this.pagination,
  });

  factory OnGoingCycleFeedResponse.fromJson(String str) =>
      OnGoingCycleFeedResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OnGoingCycleFeedResponse.fromMap(Map<String, dynamic> json) =>
      OnGoingCycleFeedResponse(
        data: json["data"] == null
            ? []
            : List<OnGoingCycleFeedResponseData>.from(json["data"]!
                .map((x) => OnGoingCycleFeedResponseData.fromMap(x))),
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

class OnGoingCycleFeedResponseData {
  String? id;
  String? memberId;
  String? fishpondId;
  DateTime? tebarDate;
  String? tebarFishTotal;
  String? fishseedId;
  String? tebarBobot;
  String? targetPanenBobot;
  String? actualPanenBobot;
  String? srTarget;
  String? estimationFishfoodEpp;
  DateTime? estimationPanenDate;
  String? actualPanenDate;
  String? estimationPanenTonase;
  String? actualPanenTonase;
  String? panenNote;
  List<dynamic>? panenAttachmentJsonArray;
  String? status;
  DateTime? createDatetime;
  String? createById;
  String? createByType;
  String? createByName;
  String? fishseedName;
  String? memberCode;
  String? memberName;
  String? fishpondName;
  String? fishfoodTotalSum;
  FishfoodJsonObject? fishfoodJsonObject;

  OnGoingCycleFeedResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.tebarDate,
    this.tebarFishTotal,
    this.fishseedId,
    this.tebarBobot,
    this.targetPanenBobot,
    this.actualPanenBobot,
    this.srTarget,
    this.estimationFishfoodEpp,
    this.estimationPanenDate,
    this.actualPanenDate,
    this.estimationPanenTonase,
    this.actualPanenTonase,
    this.panenNote,
    this.panenAttachmentJsonArray,
    this.status,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
    this.fishseedName,
    this.memberCode,
    this.memberName,
    this.fishpondName,
    this.fishfoodTotalSum,
    this.fishfoodJsonObject,
  });

  factory OnGoingCycleFeedResponseData.fromJson(String str) =>
      OnGoingCycleFeedResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OnGoingCycleFeedResponseData.fromMap(Map<String, dynamic> json) =>
      OnGoingCycleFeedResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        tebarDate: json["tebar_date"] == null
            ? null
            : DateTime.parse(json["tebar_date"]),
        tebarFishTotal: json["tebar_fish_total"],
        fishseedId: json["fishseed_id"],
        tebarBobot: json["tebar_bobot"],
        targetPanenBobot: json["target_panen_bobot"],
        actualPanenBobot: json["actual_panen_bobot"],
        srTarget: json["sr_target"],
        estimationFishfoodEpp: json["estimation_fishfood_epp"],
        estimationPanenDate: json["estimation_panen_date"] == null
            ? null
            : DateTime.parse(json["estimation_panen_date"]),
        actualPanenDate: json["actual_panen_date"],
        estimationPanenTonase: json["estimation_panen_tonase"],
        actualPanenTonase: json["actual_panen_tonase"],
        panenNote: json["panen_note"],
        panenAttachmentJsonArray: json["panen_attachment_json_array"] == null
            ? []
            : List<dynamic>.from(
                json["panen_attachment_json_array"]!.map((x) => x)),
        status: json["status"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createById: json["create_by_id"],
        createByType: json["create_by_type"],
        createByName: json["create_by_name"],
        fishseedName: json["fishseed_name"],
        memberCode: json["member_code"],
        memberName: json["member_name"],
        fishpondName: json["fishpond_name"],
        fishfoodTotalSum: json["fishfood_total_sum"],
        fishfoodJsonObject: json["fishfood_json_object"] == null
            ? null
            : FishfoodJsonObject.fromMap(json["fishfood_json_object"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "member_id": memberId,
        "fishpond_id": fishpondId,
        "tebar_date":
            "${tebarDate!.year.toString().padLeft(4, '0')}-${tebarDate!.month.toString().padLeft(2, '0')}-${tebarDate!.day.toString().padLeft(2, '0')}",
        "tebar_fish_total": tebarFishTotal,
        "fishseed_id": fishseedId,
        "tebar_bobot": tebarBobot,
        "target_panen_bobot": targetPanenBobot,
        "actual_panen_bobot": actualPanenBobot,
        "sr_target": srTarget,
        "estimation_fishfood_epp": estimationFishfoodEpp,
        "estimation_panen_date":
            "${estimationPanenDate!.year.toString().padLeft(4, '0')}-${estimationPanenDate!.month.toString().padLeft(2, '0')}-${estimationPanenDate!.day.toString().padLeft(2, '0')}",
        "actual_panen_date": actualPanenDate,
        "estimation_panen_tonase": estimationPanenTonase,
        "actual_panen_tonase": actualPanenTonase,
        "panen_note": panenNote,
        "panen_attachment_json_array": panenAttachmentJsonArray == null
            ? []
            : List<dynamic>.from(panenAttachmentJsonArray!.map((x) => x)),
        "status": status,
        "create_datetime": createDatetime?.toIso8601String(),
        "create_by_id": createById,
        "create_by_type": createByType,
        "create_by_name": createByName,
        "fishseed_name": fishseedName,
        "member_code": memberCode,
        "member_name": memberName,
        "fishpond_name": fishpondName,
        "fishfood_total_sum": fishfoodTotalSum,
        "fishfood_json_object": fishfoodJsonObject?.toMap(),
      };
}

class FishfoodJsonObject {
  List<Finisher>? starter;
  List<Finisher>? grower;
  List<Finisher>? finisher;

  FishfoodJsonObject({
    this.starter,
    this.grower,
    this.finisher,
  });

  factory FishfoodJsonObject.fromJson(String str) =>
      FishfoodJsonObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FishfoodJsonObject.fromMap(Map<String, dynamic> json) =>
      FishfoodJsonObject(
        starter: json["starter"] == null
            ? []
            : List<Finisher>.from(
                json["starter"]!.map((x) => Finisher.fromMap(x))),
        grower: json["grower"] == null
            ? []
            : List<Finisher>.from(
                json["grower"]!.map((x) => Finisher.fromMap(x))),
        finisher: json["finisher"] == null
            ? []
            : List<Finisher>.from(
                json["finisher"]!.map((x) => Finisher.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "starter": starter == null
            ? []
            : List<dynamic>.from(starter!.map((x) => x.toMap())),
        "grower": grower == null
            ? []
            : List<dynamic>.from(grower!.map((x) => x.toMap())),
        "finisher": finisher == null
            ? []
            : List<dynamic>.from(finisher!.map((x) => x.toMap())),
      };
}

class Finisher {
  String? id;
  String? name;

  Finisher({
    this.id,
    this.name,
  });

  factory Finisher.fromJson(String str) => Finisher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Finisher.fromMap(Map<String, dynamic> json) => Finisher(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
