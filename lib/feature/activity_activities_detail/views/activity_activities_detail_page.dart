import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_detail/views/activity_activities_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesDetailPage extends StatelessWidget {
  const ActivityActivitiesDetailPage(this.data, {super.key});

  final FeedActivityResponseData data;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Aktivitas",
        actions: [
          InkWell(
            onTap: () {},
            child: Text(
              "Edit",
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      backgroundColor: Colors.white,
      body: ActivityActivitiesDetailView(data),
    );
  }
}
