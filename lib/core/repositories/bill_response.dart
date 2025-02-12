import 'dart:convert';

class BillResponse {
  final List<BillResponseData>? data;
  final Pagination? pagination;

  BillResponse({
    this.data,
    this.pagination,
  });

  factory BillResponse.fromJson(String str) =>
      BillResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillResponse.fromMap(Map<String, dynamic> json) => BillResponse(
        data: json['data'] == null
            ? []
            : List<BillResponseData>.from(
                json['data']!.map((x) => BillResponseData.fromMap(x)),
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

class BillResponseData {
  final String? id;
  final DateTime? dueDate;
  final String? paymentStatus;
  final String? memberId;
  final String? fishpondId;
  final String? fishpondcycleId;
  final List<EmergencyContactJsonArray>? emergencyContactJsonArray;
  final String? fishpondName;
  final double? fishpondAreaLength;
  final double? fishpondAreaWidth;
  final double? fishpondAreaTotal;
  final double? fishpondAreaDepth;
  final String? fishpondcycleStatus;
  final DateTime? fishpondcycleTebarDate;
  final DateTime? fishpondcycleEstimationPanenDate;
  final int? countTransaction;
  final int? invoiceNominal;
  final int? paymentNominal;
  final int? remainingNominal;

  BillResponseData({
    this.id,
    this.dueDate,
    this.paymentStatus,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.emergencyContactJsonArray,
    this.fishpondName,
    this.fishpondAreaLength,
    this.fishpondAreaWidth,
    this.fishpondAreaTotal,
    this.fishpondAreaDepth,
    this.fishpondcycleStatus,
    this.fishpondcycleTebarDate,
    this.fishpondcycleEstimationPanenDate,
    this.countTransaction,
    this.invoiceNominal,
    this.paymentNominal,
    this.remainingNominal,
  });

  factory BillResponseData.fromJson(String str) =>
      BillResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillResponseData.fromMap(Map<String, dynamic> json) =>
      BillResponseData(
        id: json['id'],
        dueDate:
            json['due_date'] == null ? null : DateTime.parse(json['due_date']),
        paymentStatus: json['payment_status'],
        memberId: json['member_id'],
        fishpondId: json['fishpond_id'],
        fishpondcycleId: json['fishpondcycle_id'],
        emergencyContactJsonArray: json['emergency_contact_json_array'] == null
            ? []
            : List<EmergencyContactJsonArray>.from(
                json['emergency_contact_json_array']!
                    .map((x) => EmergencyContactJsonArray.fromMap(x))),
        fishpondName: json['fishpond_name'],
        fishpondAreaLength: json['fishpond_area_length'].toDouble(),
        fishpondAreaWidth: json['fishpond_area_width'].toDouble(),
        fishpondAreaTotal: json['fishpond_area_total'].toDouble(),
        fishpondAreaDepth: json['fishpond_area_depth'].toDouble(),
        fishpondcycleStatus: json['fishpondcycle_status'],
        fishpondcycleTebarDate: json['fishpondcycle_tebar_date'] == null
            ? null
            : DateTime.parse(json['fishpondcycle_tebar_date']),
        fishpondcycleEstimationPanenDate:
            json['fishpondcycle_estimation_panen_date'] == null
                ? null
                : DateTime.parse(json['fishpondcycle_estimation_panen_date']),
        countTransaction: json['count_transaction'],
        invoiceNominal: json['invoice_nominal'],
        paymentNominal: json['payment_nominal'],
        remainingNominal: json['remaining_nominal'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'due_date':
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        'payment_status': paymentStatus,
        'member_id': memberId,
        'fishpond_id': fishpondId,
        'fishpondcycle_id': fishpondcycleId,
        'emergency_contact_json_array': emergencyContactJsonArray == null
            ? []
            : List<dynamic>.from(
                emergencyContactJsonArray!.map((x) => x.toMap())),
        'fishpond_name': fishpondName,
        'fishpond_area_length': fishpondAreaLength,
        'fishpond_area_width': fishpondAreaWidth,
        'fishpond_area_total': fishpondAreaTotal,
        'fishpond_area_depth': fishpondAreaDepth,
        'fishpondcycle_status': fishpondcycleStatus,
        'fishpondcycle_tebar_date':
            "${fishpondcycleTebarDate!.year.toString().padLeft(4, '0')}-${fishpondcycleTebarDate!.month.toString().padLeft(2, '0')}-${fishpondcycleTebarDate!.day.toString().padLeft(2, '0')}",
        'fishpondcycle_estimation_panen_date':
            "${fishpondcycleEstimationPanenDate!.year.toString().padLeft(4, '0')}-${fishpondcycleEstimationPanenDate!.month.toString().padLeft(2, '0')}-${fishpondcycleEstimationPanenDate!.day.toString().padLeft(2, '0')}",
        'count_transaction': countTransaction,
        'invoice_nominal': invoiceNominal,
        'payment_nominal': paymentNominal,
        'remaining_nominal': remainingNominal,
      };
}

class EmergencyContactJsonArray {
  final String? name;
  final String? relation;
  final String? commentRelation;
  final String? mobilephone;

  EmergencyContactJsonArray({
    this.name,
    this.relation,
    this.commentRelation,
    this.mobilephone,
  });

  factory EmergencyContactJsonArray.fromJson(String str) =>
      EmergencyContactJsonArray.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmergencyContactJsonArray.fromMap(Map<String, dynamic> json) =>
      EmergencyContactJsonArray(
        name: json['name'],
        relation: json['relation'],
        commentRelation: json['_comment_relation'],
        mobilephone: json['mobilephone'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'relation': relation,
        '_comment_relation': commentRelation,
        'mobilephone': mobilephone,
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
