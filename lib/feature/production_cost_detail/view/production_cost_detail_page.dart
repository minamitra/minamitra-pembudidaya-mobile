import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/production_cost_detail/logic/production_cost_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/production_cost_detail/view/production_cost_detail_view.dart';

class ProductionCostDetailPage extends StatelessWidget {
  const ProductionCostDetailPage(
    this.fishPondID,
    this.financeResponseData,
    this.otherCostData,
    this.cycleDetail, {
    super.key,
  });

  final String fishPondID;
  final FinanceResponseData financeResponseData;
  final FishpondCycleCostResponse otherCostData;
  final FeedCycleHistoryResponseData cycleDetail;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/production-cost-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductionCostDetailCubit(FinanceServiceImpl.create())
            ..init(
              financeResponseData,
              otherCostData,
              fishPondID,
            ),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Detail Biaya Produksi',
        ),
        backgroundColor: AppColor.neutral[100],
        body: ProductionCostDetailView(
          fishPondID,
          financeResponseData,
          cycleDetail,
        ),
      ),
    );
  }
}
