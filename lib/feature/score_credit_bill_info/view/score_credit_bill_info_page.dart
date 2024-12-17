import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/feature/score_credit_bill_info/logic/score_credit_bill_info_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/score_credit_bill_info/view/score_credit_bill_info_view.dart';

class ScoreCreditBillInfoPage extends StatelessWidget {
  const ScoreCreditBillInfoPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/score-credit-bill-info-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCreditBillInfoCubit(),
      child: Scaffold(
        body: ScoreCreditBillInfoView(),
      ),
    );
  }
}
