import 'dart:convert';

class PointExchangeHistoryResponse {
  final List<PointExchangeHistoryResponseData>? data;
  final Pagination? pagination;

  PointExchangeHistoryResponse({
    this.data,
    this.pagination,
  });

  factory PointExchangeHistoryResponse.fromJson(String str) =>
      PointExchangeHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointExchangeHistoryResponse.fromMap(Map<String, dynamic> json) =>
      PointExchangeHistoryResponse(
        data: json['data'] == null
            ? []
            : List<PointExchangeHistoryResponseData>.from(
                json['data']!
                    .map((x) => PointExchangeHistoryResponseData.fromMap(x)),
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

class PointExchangeHistoryResponseData {
  final String? id;
  final String? memberId;
  final String? type;
  final int? nominalPoin;
  final int? nominalRp;
  final String? note;
  final List<dynamic>? attachmentJsonArray;
  final String? status;
  final DateTime? createDatetime;
  final String? createBy;
  final String? createById;
  final String? createByName;
  final DateTime? processDatetime;
  final String? processUserId;
  final String? processUserName;
  final DateTime? doneDatetime;
  final String? doneUserId;
  final String? doneUserName;
  final DateTime? rejectDatetime;
  final String? rejectUserId;
  final String? rejectUserName;

  PointExchangeHistoryResponseData({
    this.id,
    this.memberId,
    this.type,
    this.nominalPoin,
    this.nominalRp,
    this.note,
    this.attachmentJsonArray,
    this.status,
    this.createDatetime,
    this.createBy,
    this.createById,
    this.createByName,
    this.processDatetime,
    this.processUserId,
    this.processUserName,
    this.doneDatetime,
    this.doneUserId,
    this.doneUserName,
    this.rejectDatetime,
    this.rejectUserId,
    this.rejectUserName,
  });

  factory PointExchangeHistoryResponseData.fromJson(String str) =>
      PointExchangeHistoryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointExchangeHistoryResponseData.fromMap(Map<String, dynamic> json) =>
      PointExchangeHistoryResponseData(
        id: json['id'],
        memberId: json['member_id'],
        type: json['type'],
        nominalPoin: json['nominal_poin'],
        nominalRp: json['nominal_rp'],
        note: json['note'],
        attachmentJsonArray: json['attachment_json_array'] == null
            ? []
            : List<dynamic>.from(json['attachment_json_array']!.map((x) => x)),
        status: json['status'],
        createDatetime:
            json['create_datetime'] == null || json['create_datetime'] == ''
                ? null
                : DateTime.parse(json['create_datetime']),
        createBy: json['create_by'],
        createById: json['create_by_id'],
        createByName: json['create_by_name'],
        processDatetime:
            json['process_datetime'] == null || json['process_datetime'] == ''
                ? null
                : DateTime.parse(json['process_datetime']),
        processUserId: json['process_user_id'],
        processUserName: json['process_user_name'],
        doneDatetime:
            json['done_datetime'] == null || json['done_datetime'] == ''
                ? null
                : DateTime.parse(json['done_datetime']),
        doneUserId: json['done_user_id'],
        doneUserName: json['done_user_name'],
        rejectDatetime:
            json['reject_datetime'] == null || json['reject_datetime'] == ''
                ? null
                : DateTime.parse(json['reject_datetime']),
        rejectUserId: json['reject_user_id'],
        rejectUserName: json['reject_user_name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'type': type,
        'nominal_poin': nominalPoin,
        'nominal_rp': nominalRp,
        'note': note,
        'attachment_json_array': attachmentJsonArray == null
            ? []
            : List<dynamic>.from(attachmentJsonArray!.map((x) => x)),
        'status': status,
        'create_datetime': createDatetime?.toIso8601String(),
        'create_by': createBy,
        'create_by_id': createById,
        'create_by_name': createByName,
        'process_datetime': processDatetime?.toIso8601String(),
        'process_user_id': processUserId,
        'process_user_name': processUserName,
        'done_datetime': doneDatetime?.toIso8601String(),
        'done_user_id': doneUserId,
        'done_user_name': doneUserName,
        'reject_datetime': rejectDatetime,
        'reject_user_id': rejectUserId,
        'reject_user_name': rejectUserName,
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
