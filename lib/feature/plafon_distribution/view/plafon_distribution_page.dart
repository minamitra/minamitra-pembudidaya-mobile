import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/view/plafon_distribution_view.dart';

class PlafonDistributionPage extends StatelessWidget {
  const PlafonDistributionPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/plafon-distribution-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Distribusi Plafon",
      ),
      body: PlafonDistributionView(),
    );
  }
}
