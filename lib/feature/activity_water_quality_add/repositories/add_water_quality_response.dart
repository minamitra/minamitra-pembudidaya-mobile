import 'dart:convert';

class AddWaterQualityResponse {
  AddWaterQualityResponseData? data;

  AddWaterQualityResponse({this.data});

  factory AddWaterQualityResponse.fromJson(String str) =>
      AddWaterQualityResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddWaterQualityResponse.fromMap(Map<String, dynamic> json) =>
      AddWaterQualityResponse(
        data: json["data"] == null
            ? null
            : AddWaterQualityResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class AddWaterQualityResponseData {
  int? activityWaterQualityId;

  AddWaterQualityResponseData({this.activityWaterQualityId});

  factory AddWaterQualityResponseData.fromJson(String str) =>
      AddWaterQualityResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddWaterQualityResponseData.fromMap(Map<String, dynamic> json) =>
      AddWaterQualityResponseData(
        activityWaterQualityId: json["activity_water_quality_id"],
      );

  Map<String, dynamic> toMap() => {
        "activity_water_quality_id": activityWaterQualityId,
      };
}
