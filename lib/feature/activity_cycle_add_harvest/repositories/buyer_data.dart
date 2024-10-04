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

  toMap() {
    return {
      'buyerID': buyerID, // buyerID is null
      'buyerName': buyerName,
      'sellRequest': sellRequest,
      'sellUnitPrice': sellUnitPrice,
      'sellTotalPrice': sellRequest * sellUnitPrice,
      'sellerNotes': sellerNotes,
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
