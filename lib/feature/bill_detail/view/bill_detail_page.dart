import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/logic/bill_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/view/bill_detail_view.dart';

class BillDetailPage extends StatelessWidget {
  const BillDetailPage({
    this.isHistoryTransaction = false,
    super.key,
  });

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/bill-detail-page');
  }

  final bool isHistoryTransaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillDetailCubit(),
      child: Scaffold(
        body: BillDetailView(
          isHistoryTransaction: isHistoryTransaction,
        ),
      ),
    );
  }
}
