import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/views/activity_incident_detail_view.dart';

class ActivityIncidentDetailPage extends StatelessWidget {
  const ActivityIncidentDetailPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-incident-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Kejadian",
      ),
      backgroundColor: Colors.white,
      body: const ActivityIncidentDetailView(),
    );
  }
}
