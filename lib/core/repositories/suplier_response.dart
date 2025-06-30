import 'dart:convert';

class SuplierResponse {
  final List<SuplierResponseData>? data;
  final Pagination? pagination;

  SuplierResponse({
    this.data,
    this.pagination,
  });

  factory SuplierResponse.fromJson(String str) =>
      SuplierResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuplierResponse.fromMap(Map<String, dynamic> json) => SuplierResponse(
        data: json['data'] == null
            ? []
            : List<SuplierResponseData>.from(
                json['data']!.map((x) => SuplierResponseData.fromMap(x)),
              ),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromMap(json['pagination']),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        'pagination': pagination?.toMap(),
      };
}

class SuplierResponseData {
  final String? id;
  final String? name;
  final String? address;
  final String? addressLatitude;
  final String? addressLongitude;
  final String? addressProvinceId;
  final String? addressProvinceName;
  final String? addressCityId;
  final String? addressCityName;
  final String? addressSubdistrictId;
  final String? addressSubdistrictName;
  final String? addressVillageId;
  final String? addressVillageName;
  final String? picName;
  final String? picMobilephone;
  final String? note;
  final String? imageUrl;
  final bool? activeBool;
  final String? productCount;

  SuplierResponseData({
    this.id,
    this.name,
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
    this.picName,
    this.picMobilephone,
    this.note,
    this.imageUrl,
    this.activeBool,
    this.productCount,
  });

  factory SuplierResponseData.fromJson(String str) =>
      SuplierResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuplierResponseData.fromMap(Map<String, dynamic> json) =>
      SuplierResponseData(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        addressLatitude: json['address_latitude'],
        addressLongitude: json['address_longitude'],
        addressProvinceId: json['address_province_id'],
        addressProvinceName: json['address_province_name'],
        addressCityId: json['address_city_id'],
        addressCityName: json['address_city_name'],
        addressSubdistrictId: json['address_subdistrict_id'],
        addressSubdistrictName: json['address_subdistrict_name'],
        addressVillageId: json['address_village_id'],
        addressVillageName: json['address_village_name'],
        picName: json['pic_name'],
        picMobilephone: json['pic_mobilephone'],
        note: json['note'],
        imageUrl: json['image_url'],
        activeBool: json['active_bool'],
        productCount: json['product_count'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'address_latitude': addressLatitude,
        'address_longitude': addressLongitude,
        'address_province_id': addressProvinceId,
        'address_province_name': addressProvinceName,
        'address_city_id': addressCityId,
        'address_city_name': addressCityName,
        'address_subdistrict_id': addressSubdistrictId,
        'address_subdistrict_name': addressSubdistrictName,
        'address_village_id': addressVillageId,
        'address_village_name': addressVillageName,
        'pic_name': picName,
        'pic_mobilephone': picMobilephone,
        'note': note,
        'image_url': imageUrl,
        'active_bool': activeBool,
        'product_count': productCount,
      };
}

class Pagination {
  final int? totalData;
  final int? totalPage;
  final int? totalDisplay;
  final bool? firstPage;
  final bool? lastPage;
  final int? prev;
  final int? current;
  final int? next;
  final List<dynamic>? detail;
  final int? start;
  final int? end;

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
        totalData: json['total_data'],
        totalPage: json['total_page'],
        totalDisplay: json['total_display'],
        firstPage: json['first_page'],
        lastPage: json['last_page'],
        prev: json['prev'],
        current: json['current'],
        next: json['next'],
        detail: json['detail'] == null
            ? []
            : List<dynamic>.from(json['detail']!.map((x) => x)),
        start: json['start'],
        end: json['end'],
      );

  Map<String, dynamic> toMap() => {
        'total_data': totalData,
        'total_page': totalPage,
        'total_display': totalDisplay,
        'first_page': firstPage,
        'last_page': lastPage,
        'prev': prev,
        'current': current,
        'next': next,
        'detail':
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        'start': start,
        'end': end,
      };
}
