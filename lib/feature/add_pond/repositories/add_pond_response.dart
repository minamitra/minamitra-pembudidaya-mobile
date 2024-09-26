import 'dart:convert';

class AddPondResponse {
  AddPondResponseData? data;

  AddPondResponse({this.data});

  factory AddPondResponse.fromJson(String str) =>
      AddPondResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPondResponse.fromMap(Map<String, dynamic> json) => AddPondResponse(
        data: json["data"] == null
            ? null
            : AddPondResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class AddPondResponseData {
  int? fishpondId;

  AddPondResponseData({this.fishpondId});

  factory AddPondResponseData.fromJson(String str) =>
      AddPondResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPondResponseData.fromMap(Map<String, dynamic> json) =>
      AddPondResponseData(
        fishpondId: json["fishpond_id"],
      );

  Map<String, dynamic> toMap() => {
        "fishpond_id": fishpondId,
      };
}
