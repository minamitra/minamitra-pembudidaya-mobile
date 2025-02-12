import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bank/bank_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_pay/logic/bill_payment_pay_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_pay/view/bill_payment_pay_view.dart';

class BillPaymentPayPage extends StatelessWidget {
  const BillPaymentPayPage(this.totalBill, this.billResponseData, {super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/bill-payment-pay-page');
  }

  final int totalBill;
  final BillResponseData billResponseData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BillPaymentPayCubit(BankServiceImpl.create())..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Bayar Tagihan',
        ),
        backgroundColor: AppColor.neutral[100],
        body: BillPaymentPayView(
          totalBill: totalBill,
          billResponseData: billResponseData,
        ),
      ),
    );
  }
}
