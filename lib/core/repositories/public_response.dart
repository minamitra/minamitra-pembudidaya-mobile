import 'dart:convert';

class PublicResponse {
  final PublicResponseData? data;

  PublicResponse({this.data});

  factory PublicResponse.fromJson(String str) =>
      PublicResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicResponse.fromMap(Map<String, dynamic> json) => PublicResponse(
        data: json['data'] == null
            ? null
            : PublicResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class PublicResponseData {
  final String? id;
  final String? key;
  final String? value;

  PublicResponseData({
    this.id,
    this.key,
    this.value,
  });

  factory PublicResponseData.fromJson(String str) =>
      PublicResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicResponseData.fromMap(Map<String, dynamic> json) =>
      PublicResponseData(
        id: json['id'],
        key: json['key'],
        value: json['value'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'key': key,
        'value': value,
      };
}
