import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_another_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_feed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_seed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_treatment_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_bill_detail/view/transaction_bill_detail_view.dart';

class TransactionBillDetailPage extends StatelessWidget {
  const TransactionBillDetailPage({
    super.key,
    this.plafonUseSummary,
    this.plafonFeedUse,
    this.plafonTreatmentUse,
    this.plafonSeedUse,
    this.plafonAnotherUse,
  });

  static RouteSettings routeSettings =
      const RouteSettings(name: '/transaction-bill-detail-page');

  final PlafonDistributionSummaryResponse? plafonUseSummary;
  final DetailFeedUseResponse? plafonFeedUse;
  final DetailTreatmentUseResponse? plafonTreatmentUse;
  final DetailSeedUseResponse? plafonSeedUse;
  final DetailAnotherUseResponse? plafonAnotherUse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Detail Transaksi',
      ),
      body: TransactionBillDetailView(
        plafonUseSummary: plafonUseSummary,
        plafonFeedUse: plafonFeedUse,
        plafonTreatmentUse: plafonTreatmentUse,
        plafonSeedUse: plafonSeedUse,
        plafonAnotherUse: plafonAnotherUse,
      ),
    );
  }
}
