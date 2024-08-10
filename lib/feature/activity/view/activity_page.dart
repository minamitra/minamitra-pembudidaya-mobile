import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_view.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/activity-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBarWithBucket(context, "Aktifitas"),
      body: ActivityView(),
    );
  }
}
