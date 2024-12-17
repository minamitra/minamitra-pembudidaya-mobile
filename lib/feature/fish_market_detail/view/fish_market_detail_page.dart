import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market_detail/view/fish_market_detail_view.dart';

class FishMarketDetailPage extends StatelessWidget {
  const FishMarketDetailPage({super.key});

  static const RouteSettings route =
      RouteSettings(name: '/fish-market-detail-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FishMarketDetailView(),
    );
  }
}
