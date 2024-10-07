import 'dart:convert';

class UpdatePondResponse {
  UpdatePondResponseData? data;

  UpdatePondResponse({this.data});

  factory UpdatePondResponse.fromJson(String str) =>
      UpdatePondResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdatePondResponse.fromMap(Map<String, dynamic> json) =>
      UpdatePondResponse(
        data: json["data"] == null
            ? null
            : UpdatePondResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class UpdatePondResponseData {
  String? fishpondId;

  UpdatePondResponseData({this.fishpondId});

  factory UpdatePondResponseData.fromJson(String str) =>
      UpdatePondResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdatePondResponseData.fromMap(Map<String, dynamic> json) =>
      UpdatePondResponseData(
        fishpondId: json["fishpond_id"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
      };
}
