import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/logic/finance_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/views/finance_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';

class FinanceDetailPage extends StatelessWidget {
  const FinanceDetailPage(this.fishPondID, this.data, {super.key});

  final String fishPondID;
  final FinanceResponseData data;

  static RouteSettings route() =>
      const RouteSettings(name: '/finance-detail-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanceDetailCubit(
        FinanceServiceImpl.create(),
        CycleServiceImpl.create(),
      )..init(
          fishPondID,
          data,
        ),
      child: Scaffold(
        backgroundColor: AppColor.neutral[100],
        appBar: appDefaultAppBar(
          context,
          'Detail Keuangan',
        ),
        body: FinanceDetailView(fishPondID),
      ),
    );
  }
}
