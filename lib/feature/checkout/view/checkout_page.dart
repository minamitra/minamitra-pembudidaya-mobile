import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static const RouteSettings route = RouteSettings(name: '/checkout-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Checkout",
      ),
      body: CheckoutView(),
    );
  }
}
