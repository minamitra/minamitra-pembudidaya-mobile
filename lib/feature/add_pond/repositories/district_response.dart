import 'dart:convert';

class DistrictResponse {
  final List<DistrictResponseData>? data;

  DistrictResponse({this.data});

  factory DistrictResponse.fromJson(String str) =>
      DistrictResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictResponse.fromMap(Map<String, dynamic> json) =>
      DistrictResponse(
        data: json["data"] == null
            ? []
            : List<DistrictResponseData>.from(
                json["data"]!.map((x) => DistrictResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class DistrictResponseData {
  final String? id;
  final String? provinceId;
  final String? name;

  DistrictResponseData({
    this.id,
    this.provinceId,
    this.name,
  });

  factory DistrictResponseData.fromJson(String str) =>
      DistrictResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictResponseData.fromMap(Map<String, dynamic> json) =>
      DistrictResponseData(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
