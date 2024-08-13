import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_page.dart';

class ActivityActivitiesPage extends StatelessWidget {
  const ActivityActivitiesPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Aktivitas",
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const ActivityActivitiesAddPage(),
            ActivityActivitiesAddPage.routeSettings(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: const ActivityActivitiesView(),
    );
  }
}
