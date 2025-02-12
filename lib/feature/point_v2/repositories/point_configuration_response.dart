import 'dart:convert';

class PointConfigurationResponse {
  final List<PointConfigurationResponseData>? data;

  PointConfigurationResponse({this.data});

  factory PointConfigurationResponse.fromJson(String str) =>
      PointConfigurationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointConfigurationResponse.fromMap(Map<String, dynamic> json) =>
      PointConfigurationResponse(
        data: json['data'] == null
            ? []
            : List<PointConfigurationResponseData>.from(
                json['data']!
                    .map((x) => PointConfigurationResponseData.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class PointConfigurationResponseData {
  final String? id;
  final String? name;
  final int? minPoin;
  final int? maxPoin;
  final String? note;

  PointConfigurationResponseData({
    this.id,
    this.name,
    this.minPoin,
    this.maxPoin,
    this.note,
  });

  factory PointConfigurationResponseData.fromJson(String str) =>
      PointConfigurationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointConfigurationResponseData.fromMap(Map<String, dynamic> json) =>
      PointConfigurationResponseData(
        id: json['id'],
        name: json['name'],
        minPoin: json['min_poin'],
        maxPoin: json['max_poin'],
        note: json['note'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'min_poin': minPoin,
        'max_poin': maxPoin,
        'note': note,
      };
}
