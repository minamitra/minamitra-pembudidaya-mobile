import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/views/activity_cycle_view.dart';

class ActivityCyclePage extends StatelessWidget {
  const ActivityCyclePage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Siklus",
      ),
      body: const ActivityCycleView(),
    );
  }
}
