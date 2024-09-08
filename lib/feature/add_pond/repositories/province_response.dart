import 'dart:convert';

class ProvinceResponse {
  final List<ProvinceResponseData>? data;

  ProvinceResponse({
    this.data,
  });

  factory ProvinceResponse.fromJson(String str) =>
      ProvinceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProvinceResponse.fromMap(Map<String, dynamic> json) =>
      ProvinceResponse(
        data: json["data"] == null
            ? []
            : List<ProvinceResponseData>.from(
                json["data"]!.map((x) => ProvinceResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ProvinceResponseData {
  final String? id;
  final String? name;

  ProvinceResponseData({
    this.id,
    this.name,
  });

  factory ProvinceResponseData.fromJson(String str) =>
      ProvinceResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProvinceResponseData.fromMap(Map<String, dynamic> json) =>
      ProvinceResponseData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
