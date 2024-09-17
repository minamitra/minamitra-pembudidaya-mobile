import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_detail/view/activity_treatment_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityTreatmentDetailPage extends StatelessWidget {
  const ActivityTreatmentDetailPage({super.key});

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
      body: ActivityTreatmentDetailView(),
    );
  }
}
