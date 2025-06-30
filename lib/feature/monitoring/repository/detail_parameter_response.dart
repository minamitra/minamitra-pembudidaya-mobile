import 'dart:convert';

class DetailParameterResponse {
  final DetailParameterResponseData? data;

  DetailParameterResponse({
    this.data,
  });

  factory DetailParameterResponse.fromJson(String str) =>
      DetailParameterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailParameterResponse.fromMap(Map<String, dynamic> json) =>
      DetailParameterResponse(
        data: json['data'] == null
            ? null
            : DetailParameterResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class DetailParameterResponseData {
  final List<Parameter>? parameters;

  DetailParameterResponseData({
    this.parameters,
  });

  factory DetailParameterResponseData.fromJson(String str) =>
      DetailParameterResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailParameterResponseData.fromMap(Map<String, dynamic> json) =>
      DetailParameterResponseData(
        parameters: json['parameters'] == null
            ? []
            : List<Parameter>.from(
                json['parameters']!.map((x) => Parameter.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'parameters': parameters == null
            ? []
            : List<dynamic>.from(parameters!.map((x) => x.toMap())),
      };
}

class Parameter {
  final String? parameter;
  final String? key;
  final double? estimasi;
  final double? standard;
  final double? aktual;

  Parameter({
    this.parameter,
    this.key,
    this.estimasi,
    this.standard,
    this.aktual,
  });

  factory Parameter.fromJson(String str) => Parameter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Parameter.fromMap(Map<String, dynamic> json) => Parameter(
        parameter: json['parameter'],
        key: json['key'],
        estimasi: json['estimasi']?.toDouble(),
        standard: json['standard']?.toDouble(),
        aktual: json['aktual']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'parameter': parameter,
        'key': key,
        'estimasi': estimasi,
        'standard': standard,
        'aktual': aktual,
      };
}
