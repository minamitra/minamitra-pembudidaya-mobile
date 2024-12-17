import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_confirmation_payed/view/bill_payment_confirmation_payed_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';

class BillPaymentConfirmationPayedPage extends StatelessWidget {
  const BillPaymentConfirmationPayedPage(this.selectedPayment, {super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/bill-payment-confirmation-payed-page');
  }

  final SelectedPayment selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Konfirmasi Pembayaran',
      ),
      body: BillPaymentConfirmationPayedView(selectedPayment),
    );
  }
}
