import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_income/logic/detail_income_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_income/view/detail_income_view.dart';

class DetailIncomePage extends StatelessWidget {
  const DetailIncomePage(
    this.fishPondCycleID,
    this.totalIncome, {
    super.key,
  });

  final String fishPondCycleID;
  final double totalIncome;

  static RouteSettings route() =>
      const RouteSettings(name: '/detail-income-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailIncomeCubit(CycleServiceImpl.create())..init(fishPondCycleID),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Detail Pendapatan',
        ),
        backgroundColor: AppColor.neutral[100],
        body: DetailIncomeView(totalIncome),
      ),
    );
  }
}
