import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_detail/view/activity_treatment_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityTreatmentDetailPage extends StatelessWidget {
  final TreatmentResponseData data;

  const ActivityTreatmentDetailPage(this.data, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-treatment-detail-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Perlakuan",
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                ActivityTreatmentAddPage(
                  int.parse(data.fishpondId ?? "1"),
                  int.parse(data.fishpondcycleId ?? "1"),
                  isEdit: true,
                  data: data,
                ),
                ActivityTreatmentAddPage.routeSettings,
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
      body: ActivityTreatmentDetailView(data),
    );
  }
}
