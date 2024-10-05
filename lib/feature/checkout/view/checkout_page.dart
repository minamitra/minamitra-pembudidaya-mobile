import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';

class CheckoutPage extends StatelessWidget {
  final ProductsResponseData data;

  const CheckoutPage(this.data, {super.key});

  static const RouteSettings route = RouteSettings(name: '/checkout-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Checkout",
      ),
      backgroundColor: AppColor.neutral[100],
      body: CheckoutView(data),
    );
  }
}
