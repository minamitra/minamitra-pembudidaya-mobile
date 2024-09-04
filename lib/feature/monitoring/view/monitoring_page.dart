import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/monitoring_view.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  static RouteSettings route = const RouteSettings(name: '/monitoring-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, "Analisa"),
      body: MonitoringView(),
    );
  }
}
