import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/views/activity_cycle_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add/views/activity_cycle_add_page.dart';

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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const ActivityCycleAddPage(),
            ActivityCycleAddPage.routeSettings(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: const ActivityCycleView(),
    );
  }
}
