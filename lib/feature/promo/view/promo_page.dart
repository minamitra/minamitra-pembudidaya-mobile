import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/promo/view/promo_view.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  static const RouteSettings route = RouteSettings(name: '/promo-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, 'Promo 3M'),
      body: PromoView(),
    );
  }
}
