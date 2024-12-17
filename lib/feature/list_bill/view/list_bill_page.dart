import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/list_bill/logic/list_bill_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/list_bill/view/list_bill_view.dart';

class ListBillPage extends StatelessWidget {
  const ListBillPage({
    this.isHistoryTransaction = false,
    super.key,
  });

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/list-bill-page');

  final bool isHistoryTransaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListBillCubit(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Rincian Tagihan',
        ),
        body: ListBillView(isHistoryTransaction: isHistoryTransaction),
      ),
    );
  }
}
