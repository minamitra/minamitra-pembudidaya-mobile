import 'dart:convert';

class FishpondCycleCostResponse {
  final List<FishpondCycleCostResponseData>? data;
  final Pagination? pagination;

  FishpondCycleCostResponse({
    this.data,
    this.pagination,
  });

  factory FishpondCycleCostResponse.fromJson(String str) =>
      FishpondCycleCostResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FishpondCycleCostResponse.fromMap(Map<String, dynamic> json) =>
      FishpondCycleCostResponse(
        data: json['data'] == null
            ? []
            : List<FishpondCycleCostResponseData>.from(
                json['data']!
                    .map((x) => FishpondCycleCostResponseData.fromMap(x)),
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

class FishpondCycleCostResponseData {
  final String? id;
  final String? memberId;
  final String? fishpondId;
  final String? fishpondcycleId;
  final DateTime? date;
  final String? type;
  final String? nominal;
  final String? note;
  final List<String>? attachmentJsonArray;
  final String? memberCode;
  final String? memberName;
  final String? fishpondName;

  FishpondCycleCostResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.date,
    this.type,
    this.nominal,
    this.note,
    this.attachmentJsonArray,
    this.memberCode,
    this.memberName,
    this.fishpondName,
  });

  factory FishpondCycleCostResponseData.fromJson(String str) =>
      FishpondCycleCostResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FishpondCycleCostResponseData.fromMap(Map<String, dynamic> json) =>
      FishpondCycleCostResponseData(
        id: json['id'],
        memberId: json['member_id'],
        fishpondId: json['fishpond_id'],
        fishpondcycleId: json['fishpondcycle_id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        type: json['type'],
        nominal: json['nominal'],
        note: json['note'],
        attachmentJsonArray: json['attachment_json_array'] == null
            ? []
            : List<String>.from(json['attachment_json_array']!.map((x) => x)),
        memberCode: json['member_code'],
        memberName: json['member_name'],
        fishpondName: json['fishpond_name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'fishpond_id': fishpondId,
        'fishpondcycle_id': fishpondcycleId,
        'date':
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        'type': type,
        'nominal': nominal,
        'note': note,
        'attachment_json_array': attachmentJsonArray == null
            ? []
            : List<dynamic>.from(attachmentJsonArray!.map((x) => x)),
        'member_code': memberCode,
        'member_name': memberName,
        'fishpond_name': fishpondName,
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
