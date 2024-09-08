import 'dart:convert';

class VillageResponse {
  final List<VillageResponseData>? data;

  VillageResponse({this.data});

  factory VillageResponse.fromJson(String str) =>
      VillageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VillageResponse.fromMap(Map<String, dynamic> json) => VillageResponse(
        data: json["data"] == null
            ? []
            : List<VillageResponseData>.from(
                json["data"]!.map((x) => VillageResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class VillageResponseData {
  final String? id;
  final String? subdistrictId;
  final String? name;

  VillageResponseData({
    this.id,
    this.subdistrictId,
    this.name,
  });

  factory VillageResponseData.fromJson(String str) =>
      VillageResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VillageResponseData.fromMap(Map<String, dynamic> json) =>
      VillageResponseData(
        id: json["id"],
        subdistrictId: json["subdistrict_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subdistrict_id": subdistrictId,
        "name": name,
      };
}
