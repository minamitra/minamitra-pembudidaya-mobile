import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/logic/bill_payment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/view/bill_payment_view.dart';

class BillPaymentPage extends StatelessWidget {
  const BillPaymentPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/bill-payment-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillPaymentCubit(),
      child: Scaffold(
        body: BillPaymentView(),
      ),
    );
  }
}
