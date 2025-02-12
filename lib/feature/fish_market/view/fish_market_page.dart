import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market/view/fish_market_view.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class FishMarketPage extends StatelessWidget {
  const FishMarketPage({super.key});

  static RouteSettings routeSettings =
      const RouteSettings(name: '/fish-market-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Pasar Ikan',
      ),
      body: const WidgetFeatureOnProgress(child: FishMarketView()),
    );
  }
}
