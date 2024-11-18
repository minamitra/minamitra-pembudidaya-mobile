import 'dart:convert';

class CheckoutBody {
  final int? deliveryAddressId;
  final double? totalItemPrice; // wihtout discount
  final List<ServiceCostJsonArray>? serviceCostJsonArray;
  final int? totalServiceCost;
  final List<dynamic>? discountJsonArray;
  final int? totalDiscount;
  final double?
      grandTotal; // "total_item_price + total_service_cost - total_discount"
  final String? paymentMethod; // "Dompet3M,Tunai,Transfer"
  final int? paymentTransferBankId;

  final List<ItemsJsonArray>? itemsJsonArray;

  CheckoutBody({
    this.deliveryAddressId,
    this.totalItemPrice,
    this.serviceCostJsonArray,
    this.totalServiceCost,
    this.discountJsonArray,
    this.totalDiscount,
    this.grandTotal,
    this.paymentMethod,
    this.paymentTransferBankId,
    this.itemsJsonArray,
  });

  factory CheckoutBody.fromJson(String str) =>
      CheckoutBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckoutBody.fromMap(Map<String, dynamic> json) => CheckoutBody(
        deliveryAddressId: json['delivery_address_id'],
        totalItemPrice: json['total_item_price'],
        serviceCostJsonArray: json['service_cost_json_array'] == null
            ? []
            : List<ServiceCostJsonArray>.from(
                json['service_cost_json_array']!
                    .map((x) => ServiceCostJsonArray.fromMap(x)),
              ),
        totalServiceCost: json['total_service_cost'],
        discountJsonArray: json['discount_json_array'] == null
            ? []
            : List<dynamic>.from(json['discount_json_array']!.map((x) => x)),
        totalDiscount: json['total_discount'],
        grandTotal: json['grand_total'],
        paymentMethod: json['payment_method'],
        paymentTransferBankId: json['payment_transfer_bank_id'],
        itemsJsonArray: json['items_json_array'] == null
            ? []
            : List<ItemsJsonArray>.from(json['items_json_array']!
                .map((x) => ItemsJsonArray.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'delivery_address_id': deliveryAddressId,
        'total_item_price': totalItemPrice,
        'service_cost_json_array': serviceCostJsonArray == null
            ? []
            : List<dynamic>.from(serviceCostJsonArray!.map((x) => x.toMap())),
        'total_service_cost': totalServiceCost,
        'discount_json_array': discountJsonArray == null
            ? []
            : List<dynamic>.from(discountJsonArray!.map((x) => x)),
        'total_discount': totalDiscount,
        'grand_total': grandTotal,
        'payment_method': paymentMethod,
        'payment_transfer_bank_id': paymentTransferBankId,
        'items_json_array': itemsJsonArray == null
            ? []
            : List<dynamic>.from(itemsJsonArray!.map((x) => x.toMap())),
      };
}

class ItemsJsonArray {
  final int? id;
  final int? itemId;
  final String? itemName;
  final int? qty;
  final int? sellPrice;

  ItemsJsonArray({
    this.id,
    this.itemId,
    this.itemName,
    this.qty,
    this.sellPrice,
  });

  factory ItemsJsonArray.fromJson(String str) =>
      ItemsJsonArray.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemsJsonArray.fromMap(Map<String, dynamic> json) => ItemsJsonArray(
        id: json['id'],
        itemId: json['item_id'],
        itemName: json['item_name'],
        qty: json['qty'],
        sellPrice: json['sell_price'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'item_id': itemId,
        'item_name': itemName,
        'qty': qty,
        'sell_price': sellPrice,
      };
}

class ServiceCostJsonArray {
  final String? key;
  final String? name;
  final int? amount;

  ServiceCostJsonArray({
    this.key,
    this.name,
    this.amount,
  });

  factory ServiceCostJsonArray.fromJson(String str) =>
      ServiceCostJsonArray.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceCostJsonArray.fromMap(Map<String, dynamic> json) =>
      ServiceCostJsonArray(
        key: json['key'],
        name: json['name'],
        amount: json['amount'],
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'name': name,
        'amount': amount,
      };
}
