import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/view/activity_water_quality_add_page.dart';
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
        "Detail Kualitas Air",
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                ActivityWaterQualityAddPage(
                  int.parse(data.fishpondId ?? "1"),
                  int.parse(data.fishpondcycleId ?? "1"),
                  isEdit: true,
                  data: data,
                ),
                ActivityWaterQualityAddPage.routeSettings,
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
      body: ActivityWaterQualityDetailView(data),
    );
  }
}
