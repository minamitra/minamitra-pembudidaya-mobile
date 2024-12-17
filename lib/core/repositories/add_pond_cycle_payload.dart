import 'dart:convert';

class AddPondCyclePayload {
  int? fishpondId;
  String? tebarDate;
  int? tebarFishTotal;
  int? fishseedId;
  double? tebarBobot;
  double? targetPanenBobot;
  int? srTarget;
  FishfoodJsonObject? fishfoodJsonObject;
  int? estimationFishfoodEpp;
  int? commodityID;

  AddPondCyclePayload({
    this.fishpondId,
    this.tebarDate,
    this.tebarFishTotal,
    this.fishseedId,
    this.tebarBobot,
    this.targetPanenBobot,
    this.srTarget,
    this.fishfoodJsonObject,
    this.estimationFishfoodEpp,
    this.commodityID,
  });

  factory AddPondCyclePayload.fromJson(String str) =>
      AddPondCyclePayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPondCyclePayload.fromMap(Map<String, dynamic> json) =>
      AddPondCyclePayload(
        fishpondId: json['fishpond_id'],
        tebarDate: json['tebar_date'],
        tebarFishTotal: json['tebar_fish_total'],
        fishseedId: json['fishseed_id'],
        tebarBobot: json['tebar_bobot'],
        targetPanenBobot: json['target_panen_bobot'],
        srTarget: json['sr_target'],
        fishfoodJsonObject: json['fishfood_json_object'] == null
            ? null
            : FishfoodJsonObject.fromMap(json['fishfood_json_object']),
        estimationFishfoodEpp: json['estimation_fishfood_epp'],
        commodityID: json['commodity_id'],
      );

  AddPondCyclePayload copyWith({
    int? fishpondId,
    String? tebarDate,
    int? tebarFishTotal,
    int? fishseedId,
    double? tebarBobot,
    double? targetPanenBobot,
    int? srTarget,
    FishfoodJsonObject? fishfoodJsonObject,
    int? estimationFishfoodEpp,
    int? commodityID,
  }) {
    return AddPondCyclePayload(
      fishpondId: fishpondId,
      tebarDate: tebarDate,
      tebarFishTotal: tebarFishTotal,
      fishseedId: fishseedId,
      tebarBobot: tebarBobot,
      targetPanenBobot: targetPanenBobot,
      srTarget: srTarget,
      fishfoodJsonObject: fishfoodJsonObject,
      estimationFishfoodEpp: estimationFishfoodEpp,
      commodityID: commodityID,
    );
  }

  Map<String, dynamic> toMap() => {
        'fishpond_id': fishpondId,
        'tebar_date': tebarDate ?? '',
        'tebar_fish_total': tebarFishTotal,
        'fishseed_id': fishseedId,
        'tebar_bobot': tebarBobot,
        'target_panen_bobot': targetPanenBobot,
        'sr_target': srTarget,
        'fishfood_json_object': fishfoodJsonObject?.toMap() ?? '',
        'estimation_fishfood_epp': estimationFishfoodEpp,
        'commodity_id': commodityID,
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
  int? id;
  String? name;

  Finisher({
    this.id,
    this.name,
  });

  factory Finisher.fromJson(String str) => Finisher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Finisher.fromMap(Map<String, dynamic> json) => Finisher(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name ?? '',
      };
}
