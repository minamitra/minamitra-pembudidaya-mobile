import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/sampling_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/view/activity_sampling_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_detail/views/activity_sampling_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivitySamplingDetailPage extends StatelessWidget {
  final SamplingResponseData data;

  const ActivitySamplingDetailPage(this.data, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-sampling-detail-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Sampling",
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                ActivitySamplingAddPage(
                  int.parse(data.fishpondId ?? "1"),
                  int.parse(data.fishpondcycleId ?? "1"),
                  isEdit: true,
                  data: data,
                ),
                ActivitySamplingAddPage.routeSettings,
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
      body: ActivitySamplingDetailView(data),
    );
  }
}
