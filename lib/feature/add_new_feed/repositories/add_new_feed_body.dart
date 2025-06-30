import 'dart:convert';

class AddNewFeedBody {
  final int? fishpondId;
  final String? type;
  final String? name;
  final double? weight;
  final int? proteinPercent;
  final int? eppEstimationPercent;
  final int? price;
  final int? unitId;
  final int? supplierId;
  final String? note;

  AddNewFeedBody({
    this.fishpondId,
    this.type,
    this.name,
    this.weight,
    this.proteinPercent,
    this.eppEstimationPercent,
    this.price,
    this.unitId,
    this.supplierId,
    this.note,
  });

  factory AddNewFeedBody.fromJson(String str) =>
      AddNewFeedBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddNewFeedBody.fromMap(Map<String, dynamic> json) => AddNewFeedBody(
        fishpondId: json['fishpond_id'],
        type: json['type'],
        name: json['name'],
        weight: json['weight']?.toDouble(),
        proteinPercent: json['protein_percent'],
        eppEstimationPercent: json['epp_estimation_percent'],
        price: json['price'],
        unitId: json['unit_id'],
        supplierId: json['supplier_id'],
        note: json['note'],
      );

  Map<String, dynamic> toMap() => {
        'fishpond_id': fishpondId,
        'type': type,
        'name': name,
        'weight': weight,
        'protein_percent': proteinPercent,
        'epp_estimation_percent': eppEstimationPercent,
        'price': price,
        'unit_id': unitId,
        'supplier_id': supplierId,
        'note': note,
      };
}
