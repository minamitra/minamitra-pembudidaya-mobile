import 'dart:convert';

class UpdateSamplingPayload {
  String? id;
  DateTime? datetime;
  double? mbw;
  double? sr;
  String? note;
  List<String>? attachmentJsonArray;

  UpdateSamplingPayload({
    this.id,
    this.datetime,
    this.mbw,
    this.sr,
    this.note,
    this.attachmentJsonArray,
  });

  factory UpdateSamplingPayload.fromJson(String str) =>
      UpdateSamplingPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateSamplingPayload.fromMap(Map<String, dynamic> json) =>
      UpdateSamplingPayload(
        id: json["id"],
        datetime: json["datetime"],
        mbw: json["mbw"],
        sr: json["sr"],
        note: json["note"],
        attachmentJsonArray: json["attachment_json_array"],
      );

  Map<String, String> toMap() => {
        "id": id.toString(),
        "datetime": datetime!.toIso8601String(),
        "mbw": mbw.toString(),
        "sr": sr.toString(),
        "note": note.toString(),
        "attachment_json_array": attachmentJsonArray.toString(),
      };
}
