import 'dart:convert';

class TermConditionResponse {
  final TermConditionResponseData? data;

  TermConditionResponse({
    this.data,
  });

  factory TermConditionResponse.fromJson(String str) =>
      TermConditionResponse.fromMap(json.decode(str));

  factory TermConditionResponse.fromMap(Map<String, dynamic> json) =>
      TermConditionResponse(
        data: json["data"] == null
            ? null
            : TermConditionResponseData.fromMap(json["data"]),
      );
}

class TermConditionResponseData {
  String? id;
  String? key;
  String? value;

  TermConditionResponseData({
    this.id,
    this.key,
    this.value,
  });

  factory TermConditionResponseData.fromJson(String str) =>
      TermConditionResponseData.fromMap(json.decode(str));

  factory TermConditionResponseData.fromMap(Map<String, dynamic> json) =>
      TermConditionResponseData(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );
}
