import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_bill_detail/view/transaction_bill_detail_view.dart';

class TransactionBillDetailPage extends StatelessWidget {
  const TransactionBillDetailPage({super.key});

  static RouteSettings routeSettings =
      const RouteSettings(name: '/transaction-bill-detail-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Detail Transaksi',
      ),
      body: TransactionBillDetailView(),
    );
  }
}
