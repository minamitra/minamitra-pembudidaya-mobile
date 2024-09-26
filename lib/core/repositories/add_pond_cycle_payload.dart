import 'dart:convert';

class AddPondCyclePayload {
  int? fishpondId;
  DateTime? tebarDate;
  int? tebarFishTotal;
  int? fishseedId;
  int? tebarBobot;
  int? targetPanenBobot;
  int? srTarget;
  FishfoodJsonObject? fishfoodJsonObject;
  int? estimationFishfoodEpp;

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
  });

  factory AddPondCyclePayload.fromJson(String str) =>
      AddPondCyclePayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPondCyclePayload.fromMap(Map<String, dynamic> json) =>
      AddPondCyclePayload(
        fishpondId: json["fishpond_id"],
        tebarDate: json["tebar_date"] == null
            ? null
            : DateTime.parse(json["tebar_date"]),
        tebarFishTotal: json["tebar_fish_total"],
        fishseedId: json["fishseed_id"],
        tebarBobot: json["tebar_bobot"],
        targetPanenBobot: json["target_panen_bobot"],
        srTarget: json["sr_target"],
        fishfoodJsonObject: json["fishfood_json_object"] == null
            ? null
            : FishfoodJsonObject.fromMap(json["fishfood_json_object"]),
        estimationFishfoodEpp: json["estimation_fishfood_epp"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "tebar_date":
            "${tebarDate!.year.toString().padLeft(4, '0')}-${tebarDate!.month.toString().padLeft(2, '0')}-${tebarDate!.day.toString().padLeft(2, '0')}",
        "tebar_fish_total": tebarFishTotal,
        "fishseed_id": fishseedId,
        "tebar_bobot": tebarBobot,
        "target_panen_bobot": targetPanenBobot,
        "sr_target": srTarget,
        "fishfood_json_object": fishfoodJsonObject?.toMap(),
        "estimation_fishfood_epp": estimationFishfoodEpp,
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
  int? id;
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
