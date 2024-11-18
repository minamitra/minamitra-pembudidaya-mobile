import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';

class BankResponse {
  List<BankResponseData>? data;
  Pagination? pagination;

  BankResponse({
    this.data,
    this.pagination,
  });

  factory BankResponse.fromJson(String str) =>
      BankResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankResponse.fromMap(Map<String, dynamic> json) => BankResponse(
        data: json['data'] == null
            ? []
            : List<BankResponseData>.from(
                json['data']!.map((x) => BankResponseData.fromMap(x)),
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

class BankResponseData {
  String? id;
  String? imageUrl;
  String? name;
  String? accountName;
  String? accountNumber;
  bool? activeBool;
  DateTime? createDatetime;
  String? updateDatetime;

  BankResponseData({
    this.id,
    this.imageUrl,
    this.name,
    this.accountName,
    this.accountNumber,
    this.activeBool,
    this.createDatetime,
    this.updateDatetime,
  });

  factory BankResponseData.fromJson(String str) =>
      BankResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankResponseData.fromMap(Map<String, dynamic> json) =>
      BankResponseData(
        id: json['id'],
        imageUrl: json['image_url'],
        name: json['name'],
        accountName: json['account_name'],
        accountNumber: json['account_number'],
        activeBool: json['active_bool'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
        updateDatetime: json['update_datetime'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image_url': imageUrl,
        'name': name,
        'account_name': accountName,
        'account_number': accountNumber,
        'active_bool': activeBool,
        'create_datetime': createDatetime?.toIso8601String(),
        'update_datetime': updateDatetime,
      };

  SelectedPayment convertToSelectedPayment() {
    return SelectedPayment(
      id: id,
      imageUrl: imageUrl,
      name: name,
      accountName: accountName,
      accountNumber: accountNumber,
      activeBool: activeBool,
      createDatetime: createDatetime,
      updateDatetime: updateDatetime,
      paymentMethod: 'Transfer',
    );
  }
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
