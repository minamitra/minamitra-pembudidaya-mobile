import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

enum ProductType {
  unpaid,
  process,
  done,
  cancel,
}

class TransactionData {
  final String id;
  final String title;
  final String productType;
  final String image;
  final double price;
  final int amount;
  final String? status;

  TransactionData({
    required this.id,
    required this.title,
    required this.productType,
    required this.image,
    required this.price,
    required this.amount,
    this.status,
  });
}

List<TransactionData> listTransaction = [
  TransactionData(
    id: "1",
    title: "Pakan Siap Cetak (PSC) Mina Mitra Mandiri",
    productType: "Pakan",
    image: AppAssets.product1Image,
    price: 15000,
    amount: 2,
    status: "Sedang Dikirim",
  ),
  TransactionData(
    id: "2",
    title: "Bibit Siap Cetak (BSC) Mina Mitra Mandiri",
    productType: "Bibit",
    image: AppAssets.product1Image,
    price: 30000,
    amount: 5,
    status: "Sedang Dikirim",
  ),
  TransactionData(
    id: "3",
    title: "Alat Siap Cetak (ASC) Mina Mitra Mandiri",
    productType: "Alat",
    image: AppAssets.product1Image,
    price: 25000,
    amount: 3,
    status: "Sedang Dikirim",
  ),
];
