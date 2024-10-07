import 'dart:convert';

class AddSamplingPayload {
  int? fishpondId;
  int? fishpondcycleId;
  DateTime? datetime;
  double? mbw;
  double? sr;
  String? note;
  List<String>? attachmentJsonArray;

  AddSamplingPayload({
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.mbw,
    this.sr,
    this.note,
    this.attachmentJsonArray,
  });

  factory AddSamplingPayload.fromJson(String str) =>
      AddSamplingPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddSamplingPayload.fromMap(Map<String, dynamic> json) =>
      AddSamplingPayload(
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime: json["datetime"],
        mbw: json["mbw"],
        sr: json["sr"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
        "fishpondcycle_id": fishpondcycleId,
        "datetime": datetime!.toIso8601String(),
        "mbw": mbw,
        "sr": sr,
        "note": note,
        "attachment_json_array": attachmentJsonArray,
      };
}
