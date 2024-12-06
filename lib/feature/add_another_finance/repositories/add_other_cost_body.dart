import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';

class AddOtherCostBody {
  final int? id;
  final int? fishpondId;
  final int? fishpondcycleId;
  final DateTime? date;
  final String? type;
  final int? nominal;
  final String? note;
  final List<String>? attachmentJsonArray;

  AddOtherCostBody({
    this.id,
    this.fishpondId,
    this.fishpondcycleId,
    this.date,
    this.type,
    this.nominal,
    this.note,
    this.attachmentJsonArray,
  });

  factory AddOtherCostBody.fromJson(String str) =>
      AddOtherCostBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddOtherCostBody.fromMap(Map<String, dynamic> json) =>
      AddOtherCostBody(
        id: json['id'],
        fishpondId: json['fishpond_id'],
        fishpondcycleId: json['fishpondcycle_id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        type: json['type'],
        nominal: json['nominal'],
        note: json['note'],
        attachmentJsonArray: json['attachment_json_array'] == null
            ? []
            : List<String>.from(json['attachment_json_array']!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'fishpond_id': fishpondId,
        'fishpondcycle_id': fishpondcycleId,
        'date': AppConvertDateTime().ymdDash(date ?? DateTime.now()),
        'type': type,
        'nominal': nominal,
        'note': note,
        'attachment_json_array': attachmentJsonArray == null
            ? []
            : List<String>.from(attachmentJsonArray!.map((x) => x)),
      };
}
