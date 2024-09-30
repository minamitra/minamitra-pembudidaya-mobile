import 'dart:convert';

class AddPondPayload {
  String? name;
  double? areaLength;
  double? areaWidth;
  double? areaDepth;
  String? address;
  String? addressLatitude;
  String? addressLongitude;
  String? addressProvinceId;
  String? addressProvinceName;
  String? addressCityId;
  String? addressCityName;
  String? addressSubdistrictId;
  String? addressSubdistrictName;
  String? addressVillageId;
  String? addressVillageName;
  String? imageUrl;

  AddPondPayload({
    this.name,
    this.areaLength,
    this.areaWidth,
    this.areaDepth,
    this.address,
    this.addressLatitude,
    this.addressLongitude,
    this.addressProvinceId,
    this.addressProvinceName,
    this.addressCityId,
    this.addressCityName,
    this.addressSubdistrictId,
    this.addressSubdistrictName,
    this.addressVillageId,
    this.addressVillageName,
    this.imageUrl,
  });

  factory AddPondPayload.fromJson(String str) =>
      AddPondPayload.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPondPayload.fromMap(Map<String, dynamic> json) => AddPondPayload(
        name: json["name"],
        areaLength: json["area_length"],
        areaWidth: json["area_width"],
        areaDepth: json["area_depth"]?.toDouble(),
        address: json["address"],
        addressLatitude: json["address_latitude"],
        addressLongitude: json["address_longitude"],
        addressProvinceId: json["address_province_id"],
        addressProvinceName: json["address_province_name"],
        addressCityId: json["address_city_id"],
        addressCityName: json["address_city_name"],
        addressSubdistrictId: json["address_subdistrict_id"],
        addressSubdistrictName: json["address_subdistrict_name"],
        addressVillageId: json["address_village_id"],
        addressVillageName: json["address_village_name"],
        imageUrl: json["image_url"],
      );

  Map<String, String> toMap() => {
        "name": name ?? "",
        "area_length": areaLength.toString(),
        "area_width": areaWidth.toString(),
        "area_depth": areaDepth.toString(),
        "address": address.toString(),
        "address_latitude": addressLatitude ?? "",
        "address_longitude": addressLongitude ?? "",
        "address_province_id": addressProvinceId ?? "",
        "address_province_name": addressProvinceName ?? "",
        "address_city_id": addressCityId ?? "",
        "address_city_name": addressCityName ?? "",
        "address_subdistrict_id": addressSubdistrictId ?? "",
        "address_subdistrict_name": addressSubdistrictName ?? "",
        "address_village_id": addressVillageId ?? "",
        "address_village_name": addressVillageName ?? "",
        "image_url": imageUrl ?? "",
      };
}
