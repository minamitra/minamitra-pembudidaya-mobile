import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/balance/balance_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/logic/transaction_history_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/views/transaction_history_view.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  static RouteSettings route() =>
      const RouteSettings(name: '/history-transaction-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionHistoryCubit(BalanceServiceImpl.create())..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(context, 'Riwayat Transaksi'),
        body: const TransactionHistoryView(),
      ),
    );
  }
}
