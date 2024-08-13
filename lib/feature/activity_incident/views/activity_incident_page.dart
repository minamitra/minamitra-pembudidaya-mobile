import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/views/activity_incident_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/views/activity_incident_add_page.dart';

class ActivityIncidentPage extends StatelessWidget {
  const ActivityIncidentPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-incident");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Kejadian",
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const ActivityIncidentAddPage(),
            ActivityIncidentAddPage.routeSettings(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: const ActivityIncidentView(),
    );
  }
}
