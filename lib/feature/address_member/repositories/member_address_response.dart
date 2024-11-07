import 'dart:convert';

class MemberAddressResponse {
  List<MemberAddressResponseData>? data;
  Pagination? pagination;

  MemberAddressResponse({
    this.data,
    this.pagination,
  });

  factory MemberAddressResponse.fromJson(String str) =>
      MemberAddressResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberAddressResponse.fromMap(Map<String, dynamic> json) =>
      MemberAddressResponse(
        data: json['data'] == null
            ? []
            : List<MemberAddressResponseData>.from(
                json['data']!.map((x) => MemberAddressResponseData.fromMap(x)),
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

class MemberAddressResponseData {
  String? id;
  String? memberId;
  String? title;
  String? name;
  String? phone;
  String? provinceId;
  String? provinceName;
  String? cityId;
  String? cityName;
  String? subdistrictId;
  String? subdistrictName;
  String? villageId;
  String? villageName;
  String? address;
  String? latitude;
  String? longitude;
  bool? isPrimaryBool;
  DateTime? createDatetime;

  MemberAddressResponseData({
    this.id,
    this.memberId,
    this.title,
    this.name,
    this.phone,
    this.provinceId,
    this.provinceName,
    this.cityId,
    this.cityName,
    this.subdistrictId,
    this.subdistrictName,
    this.villageId,
    this.villageName,
    this.address,
    this.latitude,
    this.longitude,
    this.isPrimaryBool,
    this.createDatetime,
  });

  factory MemberAddressResponseData.fromJson(String str) =>
      MemberAddressResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberAddressResponseData.fromMap(Map<String, dynamic> json) =>
      MemberAddressResponseData(
        id: json['id'],
        memberId: json['member_id'],
        title: json['title'],
        name: json['name'],
        phone: json['phone'],
        provinceId: json['province_id'],
        provinceName: json['province_name'],
        cityId: json['city_id'],
        cityName: json['city_name'],
        subdistrictId: json['subdistrict_id'],
        subdistrictName: json['subdistrict_name'],
        villageId: json['village_id'],
        villageName: json['village_name'],
        address: json['address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isPrimaryBool: json['is_primary_bool'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'title': title,
        'name': name,
        'phone': phone,
        'province_id': provinceId,
        'province_name': provinceName,
        'city_id': cityId,
        'city_name': cityName,
        'subdistrict_id': subdistrictId,
        'subdistrict_name': subdistrictName,
        'village_id': villageId,
        'village_name': villageName,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'is_primary_bool': isPrimaryBool,
        'create_datetime': createDatetime?.toIso8601String(),
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
