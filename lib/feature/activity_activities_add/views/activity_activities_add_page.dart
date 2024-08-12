import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_view.dart';

class ActivityActivitiesAddPage extends StatelessWidget {
  const ActivityActivitiesAddPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities-add");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Tambah Aktivitas",
      ),
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: const ActivityActivitiesAddView(),
    );
  }
}
