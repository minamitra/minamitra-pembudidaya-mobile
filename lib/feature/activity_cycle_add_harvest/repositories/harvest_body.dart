import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/buyer_data.dart';

class HarvestBody {
  int? id;
  String? actualPanenDate;
  double? actualPanenBobot;
  double? actualPanenTonase;
  String? panenNote;
  List<dynamic>? panenAttachmentJsonArray;
  List<BuyerData>? buyerJsonArray;

  HarvestBody({
    this.id,
    this.actualPanenDate,
    this.actualPanenBobot,
    this.actualPanenTonase,
    this.panenNote,
    this.panenAttachmentJsonArray,
    this.buyerJsonArray,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "actual_panen_date": actualPanenDate,
        "actual_panen_bobot": actualPanenBobot,
        "actual_panen_tonase": actualPanenTonase,
        "panen_note": panenNote,
        "panen_attachment_json_array": panenAttachmentJsonArray == null
            ? []
            : List<dynamic>.from(panenAttachmentJsonArray!.map((x) => x)),
        "buyer_json_array": buyerJsonArray == null
            ? []
            : List<dynamic>.from(buyerJsonArray!.map((x) => x.toMap())),
      };
}
