import 'package:flutter/material.dart';

class BuyerData {
  final bool isBuyerFrom3m;
  final String? buyerID;
  final String buyerName;
  final int sellRequest;
  final int sellUnitPrice;
  final int sellTotalPrice;
  final String? sellerNotes;

  final TextEditingController buyerNameController;
  final TextEditingController sellRequestController;
  final TextEditingController sellUnitPriceController;
  final TextEditingController sellerNotesController;
  final TextEditingController sellTotalPriceController;

  BuyerData({
    this.isBuyerFrom3m = true,
    this.buyerID,
    required this.buyerName,
    required this.sellRequest,
    required this.sellUnitPrice,
    required this.sellTotalPrice,
    this.sellerNotes,
    required this.buyerNameController,
    required this.sellRequestController,
    required this.sellUnitPriceController,
    required this.sellerNotesController,
    required this.sellTotalPriceController,
  });

  factory BuyerData.fromMap(Map<String, dynamic> json) => BuyerData(
        isBuyerFrom3m: json["buyer_id"] != 0,
        buyerID: json["buyer_id"].toString(),
        buyerName: json["buyer_name"],
        sellRequest: json["buyer_sell_request"],
        sellUnitPrice: json["buyer_sell_unit_price"],
        sellTotalPrice: json["buyer_sell_total_price"],
        sellerNotes: json["buyer_notes"],
        buyerNameController: TextEditingController(text: json["buyer_name"]),
        sellRequestController:
            TextEditingController(text: json["buyer_sell_request"].toString()),
        sellUnitPriceController: TextEditingController(
            text: json["buyer_sell_unit_price"].toString()),
        sellTotalPriceController: TextEditingController(
            text: json["buyer_sell_total_price"].toString()),
        sellerNotesController:
            TextEditingController(text: json["buyer_notes"].toString()),
      );

  toMap() {
    return {
      'buyer_id': int.parse(buyerID ?? "0"), // buyerID is null
      'buyer_name': buyerName,
      'buyer_sell_request': sellRequest,
      'buyer_sell_unit_price': sellUnitPrice,
      'buyer_sell_total_price': sellRequest * sellUnitPrice,
      'buyer_notes': sellerNotes ?? "",
    };
  }

  copyWith({
    bool? isBuyerFrom3m,
    String? buyerID,
    String? buyerName,
    int? sellRequest,
    int? sellUnitPrice,
    String? sellerNotes,
    int? sellTotalPrice,
    TextEditingController? buyerNameController,
    TextEditingController? sellRequestController,
    TextEditingController? sellUnitPriceController,
    TextEditingController? sellerNotesController,
    TextEditingController? sellTotalPriceController,
  }) {
    return BuyerData(
      isBuyerFrom3m: isBuyerFrom3m ?? this.isBuyerFrom3m,
      buyerID: buyerID ?? this.buyerID,
      buyerName: buyerName ?? this.buyerName,
      sellRequest: sellRequest ?? this.sellRequest,
      sellUnitPrice: sellUnitPrice ?? this.sellUnitPrice,
      sellTotalPrice: sellTotalPrice ?? this.sellTotalPrice,
      buyerNameController: buyerNameController ?? this.buyerNameController,
      sellRequestController:
          sellRequestController ?? this.sellRequestController,
      sellUnitPriceController:
          sellUnitPriceController ?? this.sellUnitPriceController,
      sellerNotesController:
          sellerNotesController ?? this.sellerNotesController,
      sellTotalPriceController:
          sellTotalPriceController ?? this.sellTotalPriceController,
      // sellerNotes: sellerNotes ?? this.sellerNotes,
    );
  }
}
