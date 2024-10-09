import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_detail/views/activity_cycle_detail_view.dart';

class ActivityCycleDetailPage extends StatelessWidget {
  const ActivityCycleDetailPage(
    this.data, {
    this.isReadyHarvest = false,
    super.key,
  });

  final FeedCycleHistoryResponseData data;
  final bool isReadyHarvest;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Siklus",
      ),
      backgroundColor: AppColor.neutral[100],
      body: ActivityCycleDetailView(
        data,
        isReadyHarvest: isReadyHarvest,
      ),
    );
  }
}
