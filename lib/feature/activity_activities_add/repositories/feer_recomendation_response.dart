import 'dart:convert';

class FeedRecomendationResponse {
  FeedRecomendationResponseData? data;

  FeedRecomendationResponse({this.data});

  factory FeedRecomendationResponse.fromJson(String str) =>
      FeedRecomendationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedRecomendationResponse.fromMap(Map<String, dynamic> json) =>
      FeedRecomendationResponse(
        data: json['data'] == null
            ? null
            : FeedRecomendationResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class FeedRecomendationResponseData {
  double? mbwByFishAge;
  double? suggestFeed;
  double? accumulationTotalFeedBefore;
  String? fishAge;
  List<Fishfood>? fishfoods;

  FeedRecomendationResponseData({
    this.mbwByFishAge,
    this.suggestFeed,
    this.accumulationTotalFeedBefore,
    this.fishAge,
    this.fishfoods,
  });

  factory FeedRecomendationResponseData.fromJson(String str) =>
      FeedRecomendationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedRecomendationResponseData.fromMap(Map<String, dynamic> json) =>
      FeedRecomendationResponseData(
        mbwByFishAge: json['mbw_by_fish_age']?.toDouble(),
        suggestFeed: json['suggest_feed']?.toDouble(),
        accumulationTotalFeedBefore:
            json['accumulation_total_feed_before']?.toDouble(),
        fishAge: json['fish_age'].toString(),
        fishfoods: json['fishfoods'] == null
            ? []
            : List<Fishfood>.from(
                json['fishfoods']!.map((x) => Fishfood.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'mbw_by_fish_age': mbwByFishAge,
        'suggest_feed': suggestFeed,
        'accumulation_total_feed_before': accumulationTotalFeedBefore,
        'fish_age': fishAge,
        'fishfoods': fishfoods?.map((x) => x.toMap()).toList(),
      };
}

class Fishfood {
  final String? id;
  final String? type;
  final String? name;
  final String? weight;
  final String? proteinPercent;
  final String? eppEstimationPercent;
  final String? price;
  final String? unitId;
  final String? unitName;
  final String? supplierId;
  final String? supplierName;
  final String? supplierImageUrl;
  final String? note;

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
    this.supplierImageUrl,
    this.note,
  });

  factory Fishfood.fromJson(String str) => Fishfood.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fishfood.fromMap(Map<String, dynamic> json) => Fishfood(
        id: json['id'],
        type: json['type'],
        name: json['name'],
        weight: json['weight'],
        proteinPercent: json['protein_percent'],
        eppEstimationPercent: json['epp_estimation_percent'],
        price: json['price'],
        unitId: json['unit_id'],
        unitName: json['unit_name'],
        supplierId: json['supplier_id'],
        supplierName: json['supplier_name'],
        supplierImageUrl: json['supplier_image_url'],
        note: json['note'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'name': name,
        'weight': weight,
        'protein_percent': proteinPercent,
        'epp_estimation_percent': eppEstimationPercent,
        'price': price,
        'unit_id': unitId,
        'unit_name': unitName,
        'supplier_id': supplierId,
        'supplier_name': supplierName,
        'supplier_image_url': supplierImageUrl,
        'note': note,
      };
}
