import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market_specific/view/fish_market_specific_view.dart';

class FishMarketSpecificPage extends StatelessWidget {
  const FishMarketSpecificPage({super.key});

  static const RouteSettings route =
      RouteSettings(name: '/fish-market-specific-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Pasar X',
      ),
      body: FishMarketSpecificView(),
    );
  }
}
