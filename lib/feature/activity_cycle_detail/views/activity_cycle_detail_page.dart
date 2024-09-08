import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/cycle_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_detail/views/activity_cycle_detail_view.dart';

class ActivityCycleDetailPage extends StatelessWidget {
  final Cycle cycle;
  const ActivityCycleDetailPage(this.cycle, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Siklus",
      ),
      body: ActivityCycleDetailView(cycle),
    );
  }
}
