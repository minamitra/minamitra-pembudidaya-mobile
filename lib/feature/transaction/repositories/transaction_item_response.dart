import 'dart:convert';

class TransactionItemResponse {
  final List<TransactionItemResponseData>? data;
  final Pagination? pagination;

  TransactionItemResponse({
    this.data,
    this.pagination,
  });

  factory TransactionItemResponse.fromJson(String str) =>
      TransactionItemResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionItemResponse.fromMap(Map<String, dynamic> json) =>
      TransactionItemResponse(
        data: json['data'] == null
            ? []
            : List<TransactionItemResponseData>.from(
                json['data']!
                    .map((x) => TransactionItemResponseData.fromMap(x)),
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

class TransactionItemResponseData {
  final String? id;
  final String? number;
  final DateTime? datetime;
  final String? status;
  final String? memberId;
  final String? memberCode;
  final String? memberName;
  final String? deliveryDatetime;
  final String? deliveryAddressId;
  final String? deliveryAddressTitle;
  final String? deliveryAddressName;
  final String? deliveryAddressPhone;
  final String? deliveryAddressProvinceId;
  final String? deliveryAddressProvinceName;
  final String? deliveryAddressCityId;
  final String? deliveryAddressCityName;
  final String? deliveryAddressSubdistrictId;
  final String? deliveryAddressSubdistrictName;
  final String? deliveryAddressVillageId;
  final String? deliveryAddressVillageName;
  final String? deliveryAddressAddress;
  final String? deliveryAddressLatitude;
  final String? deliveryAddressLongitude;
  final String? totalItemPrice;
  final List<dynamic>? serviceCostJsonArray;
  final String? totalServiceCost;
  final List<dynamic>? discountJsonArray;
  final String? totalDiscount;
  final String? grandTotal;
  final String? paymentMethod;
  final String? paymentTransferBankId;
  final String? paymentTransferBankImageUrl;
  final String? paymentTransferBankName;
  final String? paymentTransferBankAccountName;
  final String? paymentTransferBankAccountNumber;
  final DateTime? paymentDueDatetime;
  final String? paymentProofImageUrl;
  final String? paymentProofNote;
  final String? paymentStatus;
  final DateTime? createDatetime;
  final String? createById;
  final String? createByType;
  final String? createByName;
  final String? processDatetime;
  final String? processById;
  final String? processByName;
  final DateTime? doneDatetime;
  final String? doneById;
  final String? doneByName;
  final List<OrderDetail>? orderDetails;

  TransactionItemResponseData({
    this.id,
    this.number,
    this.datetime,
    this.status,
    this.memberId,
    this.memberCode,
    this.memberName,
    this.deliveryDatetime,
    this.deliveryAddressId,
    this.deliveryAddressTitle,
    this.deliveryAddressName,
    this.deliveryAddressPhone,
    this.deliveryAddressProvinceId,
    this.deliveryAddressProvinceName,
    this.deliveryAddressCityId,
    this.deliveryAddressCityName,
    this.deliveryAddressSubdistrictId,
    this.deliveryAddressSubdistrictName,
    this.deliveryAddressVillageId,
    this.deliveryAddressVillageName,
    this.deliveryAddressAddress,
    this.deliveryAddressLatitude,
    this.deliveryAddressLongitude,
    this.totalItemPrice,
    this.serviceCostJsonArray,
    this.totalServiceCost,
    this.discountJsonArray,
    this.totalDiscount,
    this.grandTotal,
    this.paymentMethod,
    this.paymentTransferBankId,
    this.paymentTransferBankImageUrl,
    this.paymentTransferBankName,
    this.paymentTransferBankAccountName,
    this.paymentTransferBankAccountNumber,
    this.paymentDueDatetime,
    this.paymentProofImageUrl,
    this.paymentProofNote,
    this.paymentStatus,
    this.createDatetime,
    this.createById,
    this.createByType,
    this.createByName,
    this.processDatetime,
    this.processById,
    this.processByName,
    this.doneDatetime,
    this.doneById,
    this.doneByName,
    this.orderDetails,
  });

  factory TransactionItemResponseData.fromJson(String str) =>
      TransactionItemResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionItemResponseData.fromMap(Map<String, dynamic> json) =>
      TransactionItemResponseData(
        id: json['id'],
        number: json['number'],
        datetime:
            json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        status: json['status'],
        memberId: json['member_id'],
        memberCode: json['member_code'],
        memberName: json['member_name'],
        deliveryDatetime: json['delivery_datetime'],
        deliveryAddressId: json['delivery_address_id'],
        deliveryAddressTitle: json['delivery_address_title'],
        deliveryAddressName: json['delivery_address_name'],
        deliveryAddressPhone: json['delivery_address_phone'],
        deliveryAddressProvinceId: json['delivery_address_province_id'],
        deliveryAddressProvinceName: json['delivery_address_province_name'],
        deliveryAddressCityId: json['delivery_address_city_id'],
        deliveryAddressCityName: json['delivery_address_city_name'],
        deliveryAddressSubdistrictId: json['delivery_address_subdistrict_id'],
        deliveryAddressSubdistrictName:
            json['delivery_address_subdistrict_name'],
        deliveryAddressVillageId: json['delivery_address_village_id'],
        deliveryAddressVillageName: json['delivery_address_village_name'],
        deliveryAddressAddress: json['delivery_address_address'],
        deliveryAddressLatitude: json['delivery_address_latitude'],
        deliveryAddressLongitude: json['delivery_address_longitude'],
        totalItemPrice: json['total_item_price'],
        serviceCostJsonArray: json['service_cost_json_array'] == null
            ? []
            : List<dynamic>.from(
                json['service_cost_json_array']!.map((x) => x),
              ),
        totalServiceCost: json['total_service_cost'],
        discountJsonArray: json['discount_json_array'] == null
            ? []
            : List<dynamic>.from(json['discount_json_array']!.map((x) => x)),
        totalDiscount: json['total_discount'],
        grandTotal: json['grand_total'],
        paymentMethod: json['payment_method'],
        paymentTransferBankId: json['payment_transfer_bank_id'],
        paymentTransferBankImageUrl: json['payment_transfer_bank_image_url'],
        paymentTransferBankName: json['payment_transfer_bank_name'],
        paymentTransferBankAccountName:
            json['payment_transfer_bank_account_name'],
        paymentTransferBankAccountNumber:
            json['payment_transfer_bank_account_number'],
        paymentDueDatetime: json['payment_due_datetime'] == null
            ? null
            : DateTime.parse(json['payment_due_datetime']),
        paymentProofImageUrl: json['payment_proof_image_url'],
        paymentProofNote: json['payment_proof_note'],
        paymentStatus: json['payment_status'],
        createDatetime: json['create_datetime'] == null
            ? null
            : DateTime.parse(json['create_datetime']),
        createById: json['create_by_id'],
        createByType: json['create_by_type'],
        createByName: json['create_by_name'],
        processDatetime: json['process_datetime'],
        processById: json['process_by_id'],
        processByName: json['process_by_name'],
        doneDatetime:
            json['done_datetime'] == null || json['done_datetime'].isEmpty
                ? null
                : DateTime.parse(json['done_datetime']),
        doneById: json['done_by_id'],
        doneByName: json['done_by_name'],
        orderDetails: json['order_details'] == null
            ? []
            : List<OrderDetail>.from(
                json['order_details']!.map((x) => OrderDetail.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'number': number,
        'datetime': datetime?.toIso8601String(),
        'status': status,
        'member_id': memberId,
        'member_code': memberCode,
        'member_name': memberName,
        'delivery_datetime': deliveryDatetime,
        'delivery_address_id': deliveryAddressId,
        'delivery_address_title': deliveryAddressTitle,
        'delivery_address_name': deliveryAddressName,
        'delivery_address_phone': deliveryAddressPhone,
        'delivery_address_province_id': deliveryAddressProvinceId,
        'delivery_address_province_name': deliveryAddressProvinceName,
        'delivery_address_city_id': deliveryAddressCityId,
        'delivery_address_city_name': deliveryAddressCityName,
        'delivery_address_subdistrict_id': deliveryAddressSubdistrictId,
        'delivery_address_subdistrict_name': deliveryAddressSubdistrictName,
        'delivery_address_village_id': deliveryAddressVillageId,
        'delivery_address_village_name': deliveryAddressVillageName,
        'delivery_address_address': deliveryAddressAddress,
        'delivery_address_latitude': deliveryAddressLatitude,
        'delivery_address_longitude': deliveryAddressLongitude,
        'total_item_price': totalItemPrice,
        'service_cost_json_array': serviceCostJsonArray == null
            ? []
            : List<dynamic>.from(serviceCostJsonArray!.map((x) => x)),
        'total_service_cost': totalServiceCost,
        'discount_json_array': discountJsonArray == null
            ? []
            : List<dynamic>.from(discountJsonArray!.map((x) => x)),
        'total_discount': totalDiscount,
        'grand_total': grandTotal,
        'payment_method': paymentMethod,
        'payment_transfer_bank_id': paymentTransferBankId,
        'payment_transfer_bank_image_url': paymentTransferBankImageUrl,
        'payment_transfer_bank_name': paymentTransferBankName,
        'payment_transfer_bank_account_name': paymentTransferBankAccountName,
        'payment_transfer_bank_account_number':
            paymentTransferBankAccountNumber,
        'payment_due_datetime': paymentDueDatetime?.toIso8601String(),
        'payment_proof_image_url': paymentProofImageUrl,
        'payment_proof_note': paymentProofNote,
        'payment_status': paymentStatus,
        'create_datetime': createDatetime?.toIso8601String(),
        'create_by_id': createById,
        'create_by_type': createByType,
        'create_by_name': createByName,
        'process_datetime': processDatetime,
        'process_by_id': processById,
        'process_by_name': processByName,
        'done_datetime': doneDatetime,
        'done_by_id': doneById,
        'done_by_name': doneByName,
        'order_details': orderDetails == null
            ? []
            : List<dynamic>.from(orderDetails!.map((x) => x.toMap())),
      };
}

class OrderDetail {
  final String? id;
  final String? orderId;
  final String? itemId;
  final String? itemCode;
  final String? itemName;
  final String? itemCategoryId;
  final String? itemCategoryName;
  final String? itemWarehouseId;
  final String? itemWarehouseName;
  final String? itemUnitId;
  final String? itemUnitName;
  final String? itemSellPrice;
  final String? itemBuyPrice;
  final String? itemSupplierId;
  final String? itemSupplierName;
  final String? itemProteinPercent;
  final String? itemLemakPercent;
  final String? itemSeratKasarPercent;
  final String? itemKadarAbuPercent;
  final String? itemKadarAirPercent;
  final String? itemNote;
  final String? itemImageUrl;
  final String? qty;

  OrderDetail({
    this.id,
    this.orderId,
    this.itemId,
    this.itemCode,
    this.itemName,
    this.itemCategoryId,
    this.itemCategoryName,
    this.itemWarehouseId,
    this.itemWarehouseName,
    this.itemUnitId,
    this.itemUnitName,
    this.itemSellPrice,
    this.itemBuyPrice,
    this.itemSupplierId,
    this.itemSupplierName,
    this.itemProteinPercent,
    this.itemLemakPercent,
    this.itemSeratKasarPercent,
    this.itemKadarAbuPercent,
    this.itemKadarAirPercent,
    this.itemNote,
    this.itemImageUrl,
    this.qty,
  });

  factory OrderDetail.fromJson(String str) =>
      OrderDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        id: json['id'],
        orderId: json['order_id'],
        itemId: json['item_id'],
        itemCode: json['item_code'],
        itemName: json['item_name'],
        itemCategoryId: json['item_category_id'],
        itemCategoryName: json['item_category_name'],
        itemWarehouseId: json['item_warehouse_id'],
        itemWarehouseName: json['item_warehouse_name'],
        itemUnitId: json['item_unit_id'],
        itemUnitName: json['item_unit_name'],
        itemSellPrice: json['item_sell_price'],
        itemBuyPrice: json['item_buy_price'],
        itemSupplierId: json['item_supplier_id'],
        itemSupplierName: json['item_supplier_name'],
        itemProteinPercent: json['item_protein_percent'],
        itemLemakPercent: json['item_lemak_percent'],
        itemSeratKasarPercent: json['item_serat_kasar_percent'],
        itemKadarAbuPercent: json['item_kadar_abu_percent'],
        itemKadarAirPercent: json['item_kadar_air_percent'],
        itemNote: json['item_note'],
        itemImageUrl: json['item_image_url'],
        qty: json['qty'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_id': orderId,
        'item_id': itemId,
        'item_code': itemCode,
        'item_name': itemName,
        'item_category_id': itemCategoryId,
        'item_category_name': itemCategoryName,
        'item_warehouse_id': itemWarehouseId,
        'item_warehouse_name': itemWarehouseName,
        'item_unit_id': itemUnitId,
        'item_unit_name': itemUnitName,
        'item_sell_price': itemSellPrice,
        'item_buy_price': itemBuyPrice,
        'item_supplier_id': itemSupplierId,
        'item_supplier_name': itemSupplierName,
        'item_protein_percent': itemProteinPercent,
        'item_lemak_percent': itemLemakPercent,
        'item_serat_kasar_percent': itemSeratKasarPercent,
        'item_kadar_abu_percent': itemKadarAbuPercent,
        'item_kadar_air_percent': itemKadarAirPercent,
        'item_note': itemNote,
        'item_image_url': itemImageUrl,
        'qty': qty,
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
