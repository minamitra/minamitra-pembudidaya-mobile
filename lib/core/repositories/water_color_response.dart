import 'dart:convert';

class WaterColorResponse {
  final List<WaterColorResponseData>? data;

  WaterColorResponse({this.data});

  factory WaterColorResponse.fromJson(String str) =>
      WaterColorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WaterColorResponse.fromMap(Map<String, dynamic> json) =>
      WaterColorResponse(
        data: json['data'] == null
            ? []
            : List<WaterColorResponseData>.from(
                json['data']!.map((x) => WaterColorResponseData.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class WaterColorResponseData {
  final String? id;
  final String? name;

  WaterColorResponseData({
    this.id,
    this.name,
  });

  factory WaterColorResponseData.fromJson(String str) =>
      WaterColorResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WaterColorResponseData.fromMap(Map<String, dynamic> json) =>
      WaterColorResponseData(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}
