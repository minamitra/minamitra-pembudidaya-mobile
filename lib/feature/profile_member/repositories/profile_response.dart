import 'dart:convert';

class ProfileResponse {
  final ProfileResponseData? data;

  ProfileResponse({
    this.data,
  });

  factory ProfileResponse.fromJson(String str) =>
      ProfileResponse.fromMap(json.decode(str));

  factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
        data: json["data"] == null
            ? null
            : ProfileResponseData.fromMap(json["data"]),
      );
}

class ProfileResponseData {
  String? id;
  String? code;
  String? nik;
  String? name;
  String? email;
  String? mobilephone;
  String? birthPlace;
  DateTime? birthDate;
  String? gender;
  String? job;
  String? imageUrl;
  String? ktpUrl;
  String? ekusukaUrl;
  List<String>? otherAttachmentJsonArray;
  String? address;
  String? adrressLatitude;
  String? adrressLongitude;
  String? addressProvinceId;
  String? addressProvinceName;
  String? addressCityId;
  String? addressCityName;
  String? addressSubdistrictId;
  String? addressSubdistrictName;
  String? addressVillageId;
  String? addressVillageName;
  String? farmingGroup;

  ProfileResponseData({
    this.id,
    this.code,
    this.nik,
    this.name,
    this.email,
    this.mobilephone,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.job,
    this.imageUrl,
    this.ktpUrl,
    this.ekusukaUrl,
    this.otherAttachmentJsonArray,
    this.address,
    this.adrressLatitude,
    this.adrressLongitude,
    this.addressProvinceId,
    this.addressProvinceName,
    this.addressCityId,
    this.addressCityName,
    this.addressSubdistrictId,
    this.addressSubdistrictName,
    this.addressVillageId,
    this.addressVillageName,
    this.farmingGroup,
  });

  factory ProfileResponseData.fromJson(String str) =>
      ProfileResponseData.fromMap(json.decode(str));

  factory ProfileResponseData.fromMap(Map<String, dynamic> json) =>
      ProfileResponseData(
        id: json["id"],
        code: json["code"],
        nik: json["nik"],
        name: json["name"],
        email: json["email"],
        mobilephone: json["mobilephone"],
        birthPlace: json["birth_place"],
        birthDate: (json["birth_date"] == null || json["birth_date"] == "")
            ? null
            : DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        job: json["job"],
        imageUrl: json["image_url"],
        ktpUrl: json["ktp_url"],
        ekusukaUrl: json["ekusuka_url"],
        otherAttachmentJsonArray: json["other_attachment_json_array"] == null
            ? null
            : List<String>.from(
                json["other_attachment_json_array"].map((x) => x)),
        address: json["address"],
        adrressLatitude: json["adrress_latitude"],
        adrressLongitude: json["adrress_longitude"],
        addressProvinceId: json["address_province_id"],
        addressProvinceName: json["address_province_name"],
        addressCityId: json["address_city_id"],
        addressCityName: json["address_city_name"],
        addressSubdistrictId: json["address_subdistrict_dd"],
        addressSubdistrictName: json["address_subdistrict_name"],
        addressVillageId: json["address_village_id"],
        addressVillageName: json["address_village_name"],
        farmingGroup: json["farming_group"],
      );
}
