import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_view.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/transaction-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Rincian Pesanan",
      ),
      body: const TransactionDetailView(),
    );
  }
}
