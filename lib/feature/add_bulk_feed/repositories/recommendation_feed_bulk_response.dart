import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecommendationFeedBulk {
  List<RecommendationFeedBulkData>? data;

  RecommendationFeedBulk({
    this.data,
  });

  factory RecommendationFeedBulk.fromJson(String str) =>
      RecommendationFeedBulk.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  RecommendationFeedBulk copyWith({
    List<RecommendationFeedBulkData>? data,
  }) {
    return RecommendationFeedBulk(
      data: data ?? this.data,
    );
  }

  factory RecommendationFeedBulk.fromMap(Map<String, dynamic> json) =>
      RecommendationFeedBulk(
        data: json["data"] == null
            ? []
            : List<RecommendationFeedBulkData>.from(json["data"]!
                .map((x) => RecommendationFeedBulkData.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //       "data":
  //           data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  //     };
}

class RecommendationFeedBulkData {
  String? fishpondId;
  double? mbwByFishAge;
  double? suggestFeed;
  double? accumulationTotalFeedBefore;
  bool? isShow;
  double? feedAmount;
  TextEditingController? feedValuecontroller;
  String? fishpondName;
  List<Fishfood>? fishfoods;
  TextEditingController? fishFeedIDController;
  Fishfood? selectedFishfood;

  RecommendationFeedBulkData({
    this.fishpondId,
    this.mbwByFishAge,
    this.suggestFeed,
    this.accumulationTotalFeedBefore,
    this.isShow = false,
    this.feedAmount,
    this.feedValuecontroller,
    this.fishpondName,
    this.fishfoods,
    this.fishFeedIDController,
    this.selectedFishfood,
  });

  factory RecommendationFeedBulkData.fromJson(String str) =>
      RecommendationFeedBulkData.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory RecommendationFeedBulkData.fromMap(Map<String, dynamic> json) =>
      RecommendationFeedBulkData(
        fishpondId: json["fishpond_id"],
        mbwByFishAge: json["mbw_by_fish_age"].toDouble(),
        suggestFeed: json["suggest_feed"].toDouble(),
        accumulationTotalFeedBefore:
            json["accumulation_total_feed_before"].toDouble(),
        feedValuecontroller: TextEditingController(),
        fishFeedIDController: TextEditingController(),
        fishfoods: json["fishfoods"] == null
            ? []
            : List<Fishfood>.from(
                json["fishfoods"]!.map((x) => Fishfood.fromMap(x))),
        fishpondName: json["fishpond_name"],
      );

  RecommendationFeedBulkData copyWith({
    String? fishpondId,
    double? mbwByFishAge,
    double? suggestFeed,
    double? accumulationTotalFeedBefore,
    bool? isShow,
    double? feedAmount,
    TextEditingController? feedValuecontroller,
    TextEditingController? fishFeedIDController,
    String? fishpondName,
    List<Fishfood>? fishfoods,
    Fishfood? selectedFishfood,
  }) {
    return RecommendationFeedBulkData(
      fishpondId: fishpondId ?? this.fishpondId,
      mbwByFishAge: mbwByFishAge ?? this.mbwByFishAge,
      suggestFeed: suggestFeed ?? this.suggestFeed,
      accumulationTotalFeedBefore:
          accumulationTotalFeedBefore ?? this.accumulationTotalFeedBefore,
      isShow: isShow ?? this.isShow,
      feedAmount: feedAmount ?? this.feedAmount,
      feedValuecontroller: feedValuecontroller ?? this.feedValuecontroller,
      fishFeedIDController: fishFeedIDController ?? this.fishFeedIDController,
      fishpondName: fishpondName ?? this.fishpondName,
      fishfoods: fishfoods ?? this.fishfoods,
      selectedFishfood: selectedFishfood ?? this.selectedFishfood,
    );
  }

  Map<String, dynamic> submitBulkMap() => {
        "fishpond_id": fishpondId,
        "recommendation": suggestFeed,
        "actual": feedAmount,
        "fishfood_id": selectedFishfood!.id,
        "note": "Tidak ada catatan",
        // "mbw_by_fish_age": mbwByFishAge,
        // "suggest_feed": suggestFeed,
        // "accumulation_total_feed_before": accumulationTotalFeedBefore,
      };
}

class Fishfood {
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

  Fishfood({
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
  });

  factory Fishfood.fromJson(String str) => Fishfood.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fishfood.fromMap(Map<String, dynamic> json) => Fishfood(
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
      };
}
