import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

enum IncidentStatus {
  waiting,
  processed,
  rejected,
  failed,
  canceled,
  done,
  unknown
}

String incidentStatusToString(IncidentStatus? type) {
  switch (type) {
    case IncidentStatus.waiting:
      return 'Menunggu';
    case IncidentStatus.processed:
      return 'Proses';
    case IncidentStatus.rejected:
      return 'Ditolak';
    case IncidentStatus.failed:
      return 'Gagal';
    case IncidentStatus.canceled:
      return 'Dibatalkan';
    case IncidentStatus.done:
      return 'Selesai';
    default:
      return '-';
  }
}

IncidentStatus incidentStatusToEnum(String? type) {
  switch (type) {
    case 'waiting':
      return IncidentStatus.waiting;
    case 'processed':
      return IncidentStatus.processed;
    case 'rejected':
      return IncidentStatus.rejected;
    case 'failed':
      return IncidentStatus.failed;
    case 'canceled':
      return IncidentStatus.canceled;
    case 'done':
      return IncidentStatus.done;
    default:
      return IncidentStatus.unknown;
  }
}

Color incidentStatusColor(IncidentStatus type) {
  switch (type) {
    case IncidentStatus.processed:
      return AppColor.secondary[900]!;
    case IncidentStatus.waiting:
      return AppColor.accent[900]!;
    case IncidentStatus.done:
      return AppColor.green[500]!;
    case IncidentStatus.rejected:
    case IncidentStatus.failed:
    case IncidentStatus.canceled:
      return AppColor.red;
    case IncidentStatus.unknown:
      return AppColor.neutral[400]!;
  }
}

class IncidentResponse {
  final List<IncidentResponseData>? data;

  IncidentResponse({
    this.data,
  });

  factory IncidentResponse.fromJson(String str) =>
      IncidentResponse.fromMap(json.decode(str));

  factory IncidentResponse.fromMap(Map<String, dynamic> json) =>
      IncidentResponse(
        data: json["data"] == null
            ? []
            : List<IncidentResponseData>.from(
                json["data"]!.map((x) => IncidentResponseData.fromMap(x))),
      );
}

class IncidentResponseData {
  String? id;
  String? memberId;
  String? fishpondId;
  String? fishpondcycleId;
  DateTime? datetime;
  String? incident;
  String? note;
  IncidentStatus? status;
  List<String>? attachmentJsonArray;

  IncidentResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime,
    this.incident,
    this.note,
    this.status,
    this.attachmentJsonArray,
  });

  factory IncidentResponseData.fromJson(String str) =>
      IncidentResponseData.fromMap(json.decode(str));

  factory IncidentResponseData.fromMap(Map<String, dynamic> json) =>
      IncidentResponseData(
        id: json["id"],
        memberId: json["member_id"],
        fishpondId: json["fishpond_id"],
        fishpondcycleId: json["fishpondcycle_id"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        incident: json["incident"],
        note: json["note"],
        status: incidentStatusToEnum(json["status"]),
        attachmentJsonArray: json["attachment_json_array"] == null
            ? []
            : List<String>.from(json["attachment_json_array"].map((x) => x)),
      );
}
