import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/logic/bill_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/view/bill_detail_view.dart';

class BillDetailPage extends StatelessWidget {
  const BillDetailPage({
    required this.billResponseData,
    this.isHistoryTransaction = false,
    super.key,
  });

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/bill-detail-page');
  }

  final BillResponseData billResponseData;
  final bool isHistoryTransaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillDetailCubit(
        PlafonDistributionServiceImpl.create(),
        BillServiceImpl.create(),
      )..init(
          billResponseData.fishpondId ?? '',
          billResponseData.id ?? '',
        ),
      child: Scaffold(
        body: BillDetailView(
          isHistoryTransaction: isHistoryTransaction,
          billResponseData: billResponseData,
        ),
      ),
    );
  }
}
