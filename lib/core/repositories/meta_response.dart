import 'dart:convert';

class MetaResponse {
  final int? status;
  final String? message;
  final String? errorCode;
  final Map<String, dynamic>? result;

  MetaResponse({
    this.status,
    this.message,
    this.errorCode,
    this.result,
  });

  factory MetaResponse.fromJson(String str) =>
      MetaResponse.fromMap(json.decode(str));

  factory MetaResponse.fromMap(Map<String, dynamic> json) => MetaResponse(
        status: json["status"],
        message: json["message"],
        errorCode: json["error_code"],
        result: json["results"] ?? json["data"],
      );
}

class BaseResponse<T> {
  final MetaResponse meta;
  final T data;

  BaseResponse({
    required this.meta,
    required this.data,
  });
}
