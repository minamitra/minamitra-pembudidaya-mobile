import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/views/transaction_view.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBarWithBucket(
        context,
        'Transaksi',
        isBackButton: false,
      ),
      body: const TransactionView(),
    );
  }
}
