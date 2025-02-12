import 'dart:convert';

class WaterWeatherResponse {
  final List<WaterWeatherResponseData>? data;

  WaterWeatherResponse({this.data});

  factory WaterWeatherResponse.fromJson(String str) =>
      WaterWeatherResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WaterWeatherResponse.fromMap(Map<String, dynamic> json) =>
      WaterWeatherResponse(
        data: json['data'] == null
            ? []
            : List<WaterWeatherResponseData>.from(
                json['data']!.map((x) => WaterWeatherResponseData.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class WaterWeatherResponseData {
  final String? id;
  final String? name;

  WaterWeatherResponseData({
    this.id,
    this.name,
  });

  factory WaterWeatherResponseData.fromJson(String str) =>
      WaterWeatherResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WaterWeatherResponseData.fromMap(Map<String, dynamic> json) =>
      WaterWeatherResponseData(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}
