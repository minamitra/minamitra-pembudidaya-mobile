import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_detail/views/activity_activities_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesDetailPage extends StatelessWidget {
  const ActivityActivitiesDetailPage(this.data, this.tebarDate, {super.key});

  final FeedActivityResponseData data;
  final DateTime tebarDate;

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
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                ActivityActivitiesAddPage(
                  data.fishpondId ?? "",
                  data.fishpondcycleId ?? "",
                  tebarDate,
                  editData: data,
                ),
                ActivityActivitiesAddPage.routeSettings(),
              ));
            },
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
