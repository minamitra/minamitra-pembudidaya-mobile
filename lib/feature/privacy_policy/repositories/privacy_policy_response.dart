import 'dart:convert';

class PrivacyPolicyResponse {
  final PrivacyPolicyResponseData? data;

  PrivacyPolicyResponse({
    this.data,
  });

  factory PrivacyPolicyResponse.fromJson(String str) =>
      PrivacyPolicyResponse.fromMap(json.decode(str));

  factory PrivacyPolicyResponse.fromMap(Map<String, dynamic> json) =>
      PrivacyPolicyResponse(
        data: json["data"] == null
            ? null
            : PrivacyPolicyResponseData.fromMap(json["data"]),
      );
}

class PrivacyPolicyResponseData {
  String? id;
  String? key;
  String? value;

  PrivacyPolicyResponseData({
    this.id,
    this.key,
    this.value,
  });

  factory PrivacyPolicyResponseData.fromJson(String str) =>
      PrivacyPolicyResponseData.fromMap(json.decode(str));

  factory PrivacyPolicyResponseData.fromMap(Map<String, dynamic> json) =>
      PrivacyPolicyResponseData(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );
}
