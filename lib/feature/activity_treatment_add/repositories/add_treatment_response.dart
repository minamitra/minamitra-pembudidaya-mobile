import 'dart:convert';

class AddTreatmentResponse {
  AddTreatmentResponseData? data;

  AddTreatmentResponse({this.data});

  factory AddTreatmentResponse.fromJson(String str) =>
      AddTreatmentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTreatmentResponse.fromMap(Map<String, dynamic> json) =>
      AddTreatmentResponse(
        data: json["data"] == null
            ? null
            : AddTreatmentResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class AddTreatmentResponseData {
  int? activityTreatmentId;

  AddTreatmentResponseData({this.activityTreatmentId});

  factory AddTreatmentResponseData.fromJson(String str) =>
      AddTreatmentResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTreatmentResponseData.fromMap(Map<String, dynamic> json) =>
      AddTreatmentResponseData(
        activityTreatmentId: json["activity_treatment_id"],
      );

  Map<String, dynamic> toMap() => {
        "activity_treatment_id": activityTreatmentId,
      };
}
