import 'dart:convert';

class SubDistrictResponse {
  final List<SubDistrictResponseData>? data;

  SubDistrictResponse({this.data});

  factory SubDistrictResponse.fromJson(String str) =>
      SubDistrictResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubDistrictResponse.fromMap(Map<String, dynamic> json) =>
      SubDistrictResponse(
        data: json["data"] == null
            ? []
            : List<SubDistrictResponseData>.from(
                json["data"]!.map((x) => SubDistrictResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class SubDistrictResponseData {
  final String? id;
  final String? cityId;
  final String? name;

  SubDistrictResponseData({
    this.id,
    this.cityId,
    this.name,
  });

  factory SubDistrictResponseData.fromJson(String str) =>
      SubDistrictResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubDistrictResponseData.fromMap(Map<String, dynamic> json) =>
      SubDistrictResponseData(
        id: json["id"],
        cityId: json["city_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "city_id": cityId,
        "name": name,
      };
}
