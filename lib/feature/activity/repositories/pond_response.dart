import 'dart:convert';

class PondResponse {
  List<PondResponseData>? data;
  Pagination? pagination;

  PondResponse({
    this.data,
    this.pagination,
  });

  factory PondResponse.fromJson(String str) =>
      PondResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PondResponse.fromMap(Map<String, dynamic> json) => PondResponse(
        data: json["data"] == null
            ? []
            : List<PondResponseData>.from(
                json["data"]!.map((x) => PondResponseData.fromMap(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "pagination": pagination?.toMap(),
      };
}

class PondResponseData {
  String? id;
  String? memberId;
  String? name;
  String? areaLength;
  String? areaWidth;
  String? areaDepth;
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
  bool? activeBool;
  String? imageUrl;
  String? status;
  DateTime? statusDatetime;
  String? statusUserId;
  String? statusUserName;
  String? statusNote;
  List<dynamic>? statusAttachmentJsonArray;
  DateTime? submissionDatetime;
  String? submissionById;
  String? submissionByType;
  String? submissionByName;
  String? memberCode;
  String? memberName;
  String? memberMobilephone;
  String? memberAddress;
  String? memberAddressLatitude;
  String? memberAddressLongitude;
  String? memberAddressProvinceId;
  String? memberAddressProvinceName;
  String? memberAddressCityId;
  String? memberAddressCityName;
  String? memberAddressSubdistrictId;
  String? memberAddressSubdistrictName;
  String? memberAddressVillageId;
  String? memberAddressVillageName;
  String? lastFishpondcycleStatus;
  String? totalFoodActual;
  String? totalFoodRecommendation;

  PondResponseData({
    this.id,
    this.memberId,
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
    this.activeBool,
    this.imageUrl,
    this.status,
    this.statusDatetime,
    this.statusUserId,
    this.statusUserName,
    this.statusNote,
    this.statusAttachmentJsonArray,
    this.submissionDatetime,
    this.submissionById,
    this.submissionByType,
    this.submissionByName,
    this.memberCode,
    this.memberName,
    this.memberMobilephone,
    this.memberAddress,
    this.memberAddressLatitude,
    this.memberAddressLongitude,
    this.memberAddressProvinceId,
    this.memberAddressProvinceName,
    this.memberAddressCityId,
    this.memberAddressCityName,
    this.memberAddressSubdistrictId,
    this.memberAddressSubdistrictName,
    this.memberAddressVillageId,
    this.memberAddressVillageName,
    this.lastFishpondcycleStatus,
    this.totalFoodActual,
    this.totalFoodRecommendation,
  });

  factory PondResponseData.fromJson(String str) =>
      PondResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PondResponseData.fromMap(Map<String, dynamic> json) =>
      PondResponseData(
        id: json["id"],
        memberId: json["member_id"],
        name: json["name"],
        areaLength: json["area_length"],
        areaWidth: json["area_width"],
        areaDepth: json["area_depth"],
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
        activeBool: json["active_bool"],
        imageUrl: json["image_url"],
        status: json["status"],
        statusDatetime: json["status_datetime"] == null
            ? null
            : DateTime.parse(json["status_datetime"]),
        statusUserId: json["status_user_id"],
        statusUserName: json["status_user_name"],
        statusNote: json["status_note"],
        statusAttachmentJsonArray: json["status_attachment_json_array"] == null
            ? []
            : List<dynamic>.from(
                json["status_attachment_json_array"]!.map((x) => x)),
        submissionDatetime: json["submission_datetime"] == null
            ? null
            : DateTime.parse(json["submission_datetime"]),
        submissionById: json["submission_by_id"],
        submissionByType: json["submission_by_type"],
        submissionByName: json["submission_by_name"],
        memberCode: json["member_code"],
        memberName: json["member_name"],
        memberMobilephone: json["member_mobilephone"],
        memberAddress: json["member_address"],
        memberAddressLatitude: json["member_address_latitude"],
        memberAddressLongitude: json["member_address_longitude"],
        memberAddressProvinceId: json["member_address_province_id"],
        memberAddressProvinceName: json["member_address_province_name"],
        memberAddressCityId: json["member_address_city_id"],
        memberAddressCityName: json["member_address_city_name"],
        memberAddressSubdistrictId: json["member_address_subdistrict_id"],
        memberAddressSubdistrictName: json["member_address_subdistrict_name"],
        memberAddressVillageId: json["member_address_village_id"],
        memberAddressVillageName: json["member_address_village_name"],
        lastFishpondcycleStatus: json["last_fishpondcycle_status"],
        totalFoodActual: json["total_food_actual"],
        totalFoodRecommendation: json["total_food_recommendation"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "area_length": areaLength,
        "area_width": areaWidth,
        "area_depth": areaDepth,
        "address": address,
        "address_latitude": addressLatitude,
        "address_longitude": addressLongitude,
        "address_province_id": addressProvinceId,
        "address_province_name": addressProvinceName,
        "address_city_id": addressCityId,
        "address_city_name": addressCityName,
        "address_subdistrict_id": addressSubdistrictId,
        "address_subdistrict_name": addressSubdistrictName,
        "address_village_id": addressVillageId,
        "address_village_name": addressVillageName,
        "active_bool": activeBool,
        "image_url": imageUrl,
        "status": status,
        "status_datetime": statusDatetime?.toIso8601String(),
        "status_user_id": statusUserId,
        "status_user_name": statusUserName,
        "status_note": statusNote,
        "status_attachment_json_array": statusAttachmentJsonArray == null
            ? []
            : List<dynamic>.from(statusAttachmentJsonArray!.map((x) => x)),
        "submission_datetime": submissionDatetime?.toIso8601String(),
        "submission_by_id": submissionById,
        "submission_by_type": submissionByType,
        "submission_by_name": submissionByName,
        "member_code": memberCode,
        "member_name": memberName,
        "member_mobilephone": memberMobilephone,
        "member_address": memberAddress,
        "member_address_latitude": memberAddressLatitude,
        "member_address_longitude": memberAddressLongitude,
        "member_address_province_id": memberAddressProvinceId,
        "member_address_province_name": memberAddressProvinceName,
        "member_address_city_id": memberAddressCityId,
        "member_address_city_name": memberAddressCityName,
        "member_address_subdistrict_id": memberAddressSubdistrictId,
        "member_address_subdistrict_name": memberAddressSubdistrictName,
        "member_address_village_id": memberAddressVillageId,
        "member_address_village_name": memberAddressVillageName,
        "last_fishpondcycle_status": lastFishpondcycleStatus,
      };
}

class Pagination {
  int? totalData;
  int? totalPage;
  int? totalDisplay;
  bool? firstPage;
  bool? lastPage;
  int? prev;
  int? current;
  int? next;
  List<dynamic>? detail;
  int? start;
  int? end;

  Pagination({
    this.totalData,
    this.totalPage,
    this.totalDisplay,
    this.firstPage,
    this.lastPage,
    this.prev,
    this.current,
    this.next,
    this.detail,
    this.start,
    this.end,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        totalData: json["total_data"],
        totalPage: json["total_page"],
        totalDisplay: json["total_display"],
        firstPage: json["first_page"],
        lastPage: json["last_page"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        detail: json["detail"] == null
            ? []
            : List<dynamic>.from(json["detail"]!.map((x) => x)),
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toMap() => {
        "total_data": totalData,
        "total_page": totalPage,
        "total_display": totalDisplay,
        "first_page": firstPage,
        "last_page": lastPage,
        "prev": prev,
        "current": current,
        "next": next,
        "detail":
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        "start": start,
        "end": end,
      };
}
