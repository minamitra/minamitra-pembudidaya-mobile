import 'dart:convert';

class PlafonDistributionSummaryResponse {
  final PlafonDistributionSummaryResponseData? data;

  PlafonDistributionSummaryResponse({this.data});

  factory PlafonDistributionSummaryResponse.fromJson(String str) =>
      PlafonDistributionSummaryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonDistributionSummaryResponse.fromMap(
    Map<String, dynamic> json,
  ) =>
      PlafonDistributionSummaryResponse(
        data: json['data'] == null
            ? null
            : PlafonDistributionSummaryResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class PlafonDistributionSummaryResponseData {
  final int? totalPlafon;
  final int? totalCostUsed;
  final double? percentageCostUsed;
  final Cost? feedingCost;
  final Cost? treatmentCost;
  final Cost? seedCost;
  final Cost? otherCost;

  PlafonDistributionSummaryResponseData({
    this.totalPlafon,
    this.totalCostUsed,
    this.percentageCostUsed,
    this.feedingCost,
    this.treatmentCost,
    this.seedCost,
    this.otherCost,
  });

  factory PlafonDistributionSummaryResponseData.fromJson(String str) =>
      PlafonDistributionSummaryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlafonDistributionSummaryResponseData.fromMap(
    Map<String, dynamic> json,
  ) =>
      PlafonDistributionSummaryResponseData(
        totalPlafon: json['total_plafon'],
        totalCostUsed: json['total_cost_used'],
        percentageCostUsed: json['percentage_cost_used']?.toDouble(),
        feedingCost: json['feeding_cost'] == null
            ? null
            : Cost.fromMap(json['feeding_cost']),
        treatmentCost: json['treatment_cost'] == null
            ? null
            : Cost.fromMap(json['treatment_cost']),
        seedCost:
            json['seed_cost'] == null ? null : Cost.fromMap(json['seed_cost']),
        otherCost: json['other_cost'] == null
            ? null
            : Cost.fromMap(json['other_cost']),
      );

  Map<String, dynamic> toMap() => {
        'feeding_cost': feedingCost?.toMap(),
        'treatment_cost': treatmentCost?.toMap(),
        'seed_cost': seedCost?.toMap(),
        'other_cost': otherCost?.toMap(),
      };
}

class Cost {
  final int? costNominal;
  final double? percentage;

  Cost({
    this.costNominal,
    this.percentage,
  });

  factory Cost.fromJson(String str) => Cost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cost.fromMap(Map<String, dynamic> json) => Cost(
        costNominal: json['cost_nominal'],
        percentage: json['percentage']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'cost_nominal': costNominal,
        'percentage': percentage,
      };
}
