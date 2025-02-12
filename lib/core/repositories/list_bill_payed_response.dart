import 'dart:convert';

class ListBillPayedResponse {
  final List<ListBillPayedResponseData>? data;
  final Pagination? pagination;

  ListBillPayedResponse({
    this.data,
    this.pagination,
  });

  factory ListBillPayedResponse.fromJson(String str) =>
      ListBillPayedResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListBillPayedResponse.fromMap(Map<String, dynamic> json) =>
      ListBillPayedResponse(
        data: json['data'] == null
            ? []
            : List<ListBillPayedResponseData>.from(
                json['data']!.map((x) => ListBillPayedResponseData.fromMap(x)),
              ),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromMap(json['pagination']),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        'pagination': pagination?.toMap(),
      };
}

class ListBillPayedResponseData {
  final String? id;
  final String? plafonSubmissionId;
  final String? memberId;
  final String? fishpondId;
  final String? fishpondcycleId;
  final int? nominal;
  final String? method;
  final String? tfBankId;
  final String? tfBankImageUrl;
  final String? tfBankName;
  final String? tfBankAccName;
  final String? tfBankAccNumber;
  final String? proofImageUrl;
  final String? proofNote;
  final String? status;
  final DateTime? statusDatetime;
  final String? note;
  final DateTime? createDatetime;
  final String? createByType;
  final String? createById;
  final String? createByName;

  ListBillPayedResponseData({
    this.id,
    this.plafonSubmissionId,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.nominal,
    this.method,
    this.tfBankId,
    this.tfBankImageUrl,
    this.tfBankName,
    this.tfBankAccName,
    this.tfBankAccNumber,
    this.proofImageUrl,
    this.proofNote,
    this.status,
    this.statusDatetime,
    this.note,
    this.createDatetime,
    this.createByType,
    this.createById,
    this.createByName,
  });

  factory ListBillPayedResponseData.fromJson(String str) =>
      ListBillPayedResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListBillPayedResponseData.fromMap(Map<String, dynamic> json) =>
      ListBillPayedResponseData(
        id: json['id'],
        plafonSubmissionId: json['plafon_submission_id'],
        memberId: json['member_id'],
        fishpondId: json['fishpond_id'],
        fishpondcycleId: json['fishpondcycle_id'],
        nominal: json['nominal'],
        method: json['method'],
        tfBankId: json['tf_bank_id'],
        tfBankImageUrl: json['tf_bank_image_url'],
        tfBankName: json['tf_bank_name'],
        tfBankAccName: json['tf_bank_acc_name'],
        tfBankAccNumber: json['tf_bank_acc_number'],
        proofImageUrl: json['proof_image_url'],
        proofNote: json['proof_note'],
        status: json['status'],
        statusDatetime: json['status_datetime'] == null
            ? null
            : DateTime.parse(json['status_datetime']),
        note: json['note'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
        createByType: json['create_by_type'],
        createById: json['create_by_id'],
        createByName: json['create_by_name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'plafon_submission_id': plafonSubmissionId,
        'member_id': memberId,
        'fishpond_id': fishpondId,
        'fishpondcycle_id': fishpondcycleId,
        'nominal': nominal,
        'method': method,
        'tf_bank_id': tfBankId,
        'tf_bank_image_url': tfBankImageUrl,
        'tf_bank_name': tfBankName,
        'tf_bank_acc_name': tfBankAccName,
        'tf_bank_acc_number': tfBankAccNumber,
        'proof_image_url': proofImageUrl,
        'proof_note': proofNote,
        'status': status,
        'status_datetime': statusDatetime?.toIso8601String(),
        'note': note,
        'create_datetime': createDatetime?.toIso8601String(),
        'create_by_type': createByType,
        'create_by_id': createById,
        'create_by_name': createByName,
      };
}

class Pagination {
  final int? totalData;
  final int? totalPage;
  final int? totalDisplay;
  final bool? firstPage;
  final bool? lastPage;
  final int? prev;
  final int? current;
  final int? next;
  final List<dynamic>? detail;
  final int? start;
  final int? end;

  Pagination({
    this.totalData,
    this.totalPage,
    this.totalDisplay,
    this.firstPage,
    this.lastPage,
    this.prev,
    this.current,
    this.next,
    this.detail,
    this.start,
    this.end,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        totalData: json['total_data'],
        totalPage: json['total_page'],
        totalDisplay: json['total_display'],
        firstPage: json['first_page'],
        lastPage: json['last_page'],
        prev: json['prev'],
        current: json['current'],
        next: json['next'],
        detail: json['detail'] == null
            ? []
            : List<dynamic>.from(json['detail']!.map((x) => x)),
        start: json['start'],
        end: json['end'],
      );

  Map<String, dynamic> toMap() => {
        'total_data': totalData,
        'total_page': totalPage,
        'total_display': totalDisplay,
        'first_page': firstPage,
        'last_page': lastPage,
        'prev': prev,
        'current': current,
        'next': next,
        'detail':
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        'start': start,
        'end': end,
      };
}
