import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/buyer_data.dart';

class FeedCycleHistoryResponse {
  List<FeedCycleHistoryResponseData>? data;

  FeedCycleHistoryResponse({this.data});

  factory FeedCycleHistoryResponse.fromJson(String str) =>
      FeedCycleHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedCycleHistoryResponse.fromMap(Map<String, dynamic> json) =>
      FeedCycleHistoryResponse(
        data: json['data'] == null
            ? []
            : List<FeedCycleHistoryResponseData>.from(
                json['data']!
                    .map((x) => FeedCycleHistoryResponseData.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class FeedCycleHistoryResponseData {
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
  List<String>? panenAttachmentJsonArray;
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
  List<BuyerData>? buyerJsonArray;
  String? fishpondAddress;
  String? fishpondAddressProvinceName;
  String? fishpondAddressCityName;
  String? fishpondAddressSubdistrictName;
  String? fishpondAddressVillageName;
  String? densitas;
  String? fishpondAreaTotal;
  String? fishpondAreaDepth;

  FeedCycleHistoryResponseData({
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
    this.buyerJsonArray,
    this.fishpondAddress,
    this.fishpondAddressProvinceName,
    this.fishpondAddressCityName,
    this.fishpondAddressSubdistrictName,
    this.fishpondAddressVillageName,
    this.densitas,
    this.fishpondAreaTotal,
    this.fishpondAreaDepth,
  });

  factory FeedCycleHistoryResponseData.fromJson(String str) =>
      FeedCycleHistoryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedCycleHistoryResponseData.fromMap(Map<String, dynamic> json) =>
      FeedCycleHistoryResponseData(
        id: json['id'],
        memberId: json['member_id'],
        fishpondId: json['fishpond_id'],
        tebarDate: json['tebar_date'] == null
            ? null
            : DateTime.parse(json['tebar_date']),
        tebarFishTotal: json['tebar_fish_total'],
        fishseedId: json['fishseed_id'],
        tebarBobot: json['tebar_bobot'],
        targetPanenBobot: json['target_panen_bobot'],
        actualPanenBobot: json['actual_panen_bobot'],
        srTarget: json['sr_target'],
        estimationFishfoodEpp: json['estimation_fishfood_epp'],
        estimationPanenDate: json['estimation_panen_date'] == null
            ? null
            : DateTime.parse(json['estimation_panen_date']),
        actualPanenDate: json['actual_panen_date'],
        estimationPanenTonase: json['estimation_panen_tonase'],
        actualPanenTonase: json['actual_panen_tonase'],
        panenNote: json['panen_note'],
        panenAttachmentJsonArray: json['panen_attachment_json_array'] == null
            ? []
            : List<String>.from(
                json['panen_attachment_json_array']!.map((x) => x),
              ),
        status: json['status'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
        createById: json['create_by_id'],
        createByType: json['create_by_type'],
        createByName: json['create_by_name'],
        fishseedName: json['fishseed_name'],
        memberCode: json['member_code'],
        memberName: json['member_name'],
        fishpondName: json['fishpond_name'],
        fishfoodTotalSum: json['fishfood_total_sum'],
        fishfoodJsonObject: json['fishfood_json_object'] == null
            ? null
            : FishfoodJsonObject.fromMap(json['fishfood_json_object']),
        buyerJsonArray: json['buyer_json_array'] == null
            ? []
            : List<BuyerData>.from(
                json['buyer_json_array'].map((x) => BuyerData.fromMap(x)),
              ),
        fishpondAddress: json['fishpond_address'],
        fishpondAddressProvinceName: json['fishpond_address_province_name'],
        fishpondAddressCityName: json['fishpond_address_city_name'],
        fishpondAddressSubdistrictName:
            json['fishpond_address_subdistrict_name'],
        fishpondAddressVillageName: json['fishpond_address_village_name'],
        densitas: json['densitas'],
        fishpondAreaTotal: json['fishpond_area_total'],
        fishpondAreaDepth: json['fishpond_area_depth'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'fishpond_id': fishpondId,
        'tebar_date':
            "${tebarDate!.year.toString().padLeft(4, '0')}-${tebarDate!.month.toString().padLeft(2, '0')}-${tebarDate!.day.toString().padLeft(2, '0')}",
        'tebar_fish_total': tebarFishTotal,
        'fishseed_id': fishseedId,
        'tebar_bobot': tebarBobot,
        'target_panen_bobot': targetPanenBobot,
        'actual_panen_bobot': actualPanenBobot,
        'sr_target': srTarget,
        'estimation_fishfood_epp': estimationFishfoodEpp,
        'estimation_panen_date':
            "${estimationPanenDate!.year.toString().padLeft(4, '0')}-${estimationPanenDate!.month.toString().padLeft(2, '0')}-${estimationPanenDate!.day.toString().padLeft(2, '0')}",
        'actual_panen_date': actualPanenDate,
        'estimation_panen_tonase': estimationPanenTonase,
        'actual_panen_tonase': actualPanenTonase,
        'panen_note': panenNote,
        'panen_attachment_json_array': panenAttachmentJsonArray == null
            ? []
            : List<dynamic>.from(panenAttachmentJsonArray!.map((x) => x)),
        'status': status,
        'create_datetime': createDatetime?.toIso8601String(),
        'create_by_id': createById,
        'create_by_type': createByType,
        'create_by_name': createByName,
        'fishseed_name': fishseedName,
        'member_code': memberCode,
        'member_name': memberName,
        'fishpond_name': fishpondName,
        'fishfood_total_sum': fishfoodTotalSum,
        'fishfood_json_object': fishfoodJsonObject?.toMap(),
      };
}

class FishfoodJsonObject {
  List<Finisher>? starter1;
  List<Finisher>? starter2;
  List<Finisher>? starter3;
  List<Finisher>? grower;
  List<Finisher>? finisher;

  FishfoodJsonObject({
    this.starter1,
    this.starter2,
    this.starter3,
    this.grower,
    this.finisher,
  });

  factory FishfoodJsonObject.fromJson(String str) =>
      FishfoodJsonObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FishfoodJsonObject.fromMap(Map<String, dynamic> json) =>
      FishfoodJsonObject(
        starter1: json['starter1'] == null
            ? []
            : List<Finisher>.from(
                json['starter1']!.map((x) => Finisher.fromMap(x)),
              ),
        starter2: json['starter2'] == null
            ? []
            : List<Finisher>.from(
                json['starter2']!.map((x) => Finisher.fromMap(x)),
              ),
        starter3: json['starter3'] == null
            ? []
            : List<Finisher>.from(
                json['starter3']!.map((x) => Finisher.fromMap(x)),
              ),
        grower: json['grower'] == null
            ? []
            : List<Finisher>.from(
                json['grower']!.map((x) => Finisher.fromMap(x)),
              ),
        finisher: json['finisher'] == null
            ? []
            : List<Finisher>.from(
                json['finisher']!.map((x) => Finisher.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'starter1': starter1 == null
            ? []
            : List<dynamic>.from(starter1!.map((x) => x.toMap())),
        'starter2': starter2 == null
            ? []
            : List<dynamic>.from(starter2!.map((x) => x.toMap())),
        'starter3': starter3 == null
            ? []
            : List<dynamic>.from(starter3!.map((x) => x.toMap())),
        'grower': grower == null
            ? []
            : List<dynamic>.from(grower!.map((x) => x.toMap())),
        'finisher': finisher == null
            ? []
            : List<dynamic>.from(finisher!.map((x) => x.toMap())),
      };
}

class Finisher {
  String? id;
  String? name;
  double? total;

  Finisher({
    this.id,
    this.name,
    this.total,
  });

  factory Finisher.fromJson(String str) => Finisher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Finisher.fromMap(Map<String, dynamic> json) => Finisher(
        id: json['id'],
        name: json['name'],
        total: json['total'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'total': total,
      };
}
