import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_detail/views/activity_water_quality_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityWaterQualityDetailPage extends StatelessWidget {
  final WaterQualityResponseData data;

  const ActivityWaterQualityDetailPage(this.data, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-water-quality-detail-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Perlakuan",
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
      body: ActivityWaterQualityDetailView(data),
    );
  }
}
