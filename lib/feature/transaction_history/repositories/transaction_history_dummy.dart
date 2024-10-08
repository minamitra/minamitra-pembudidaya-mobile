import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

enum TransactionHistoryStatus { income, expense }

class TransactionHistory {
  final DateTime date;
  final List<TransactionHistoryItem> items;

  TransactionHistory({
    required this.date,
    required this.items,
  });
}

class TransactionHistoryItem {
  final String icon;
  final String title;
  final String description;
  final double amount;
  final TransactionHistoryStatus status;

  TransactionHistoryItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.amount,
    required this.status,
  });
}

List<TransactionHistory> listTransactionHistoryDummy = [
  TransactionHistory(
    date: DateTime(2024, 09, 23),
    items: [
      TransactionHistoryItem(
        icon: AppAssets.qrCodeIcon,
        title: 'QR Bayar',
        description: 'Pembayaran QR ke Koperasi Mitra 3M',
        amount: 100000,
        status: TransactionHistoryStatus.expense,
      ),
      TransactionHistoryItem(
        icon: AppAssets.walletOutlineIcon,
        title: 'Top Up',
        description: 'Isi Ulang saldo Dompet3M dari Koperasi Mitra 3M',
        amount: 5000000,
        status: TransactionHistoryStatus.income,
      ),
    ],
  ),
  TransactionHistory(
    date: DateTime(2024, 09, 22),
    items: [
      TransactionHistoryItem(
        icon: AppAssets.walletOutlineIcon,
        title: 'Top Up',
        description: 'Isi Ulang saldo Dompet3M dari Koperasi Mitra 3M',
        amount: 2500000,
        status: TransactionHistoryStatus.income,
      ),
      TransactionHistoryItem(
        icon: AppAssets.qrCodeIcon,
        title: 'QR Bayar',
        description: 'Pembayaran QR ke Koperasi Mitra 3M',
        amount: 175000,
        status: TransactionHistoryStatus.expense,
      ),
    ],
  ),
];
