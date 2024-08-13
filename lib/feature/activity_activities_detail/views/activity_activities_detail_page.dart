import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_detail/views/activity_activities_detail_view.dart';

class ActivityActivitiesDetailPage extends StatelessWidget {
  const ActivityActivitiesDetailPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Aktivitas",
      ),
      backgroundColor: Colors.white,
      body: const ActivityActivitiesDetailView(),
    );
  }
}
