import 'dart:convert';

class AddSamplingResponse {
  AddSamplingResponseData? data;

  AddSamplingResponse({this.data});

  factory AddSamplingResponse.fromJson(String str) =>
      AddSamplingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddSamplingResponse.fromMap(Map<String, dynamic> json) =>
      AddSamplingResponse(
        data: json["data"] == null
            ? null
            : AddSamplingResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class AddSamplingResponseData {
  int? activitySamplingId;

  AddSamplingResponseData({this.activitySamplingId});

  factory AddSamplingResponseData.fromJson(String str) =>
      AddSamplingResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddSamplingResponseData.fromMap(Map<String, dynamic> json) =>
      AddSamplingResponseData(
        activitySamplingId: json["activity_sampling_id"],
      );

  Map<String, dynamic> toMap() => {
        "activity_sampling_id": activitySamplingId,
      };
}
