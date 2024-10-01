import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/views/activity_incident_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/views/activity_incident_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityIncidentDetailPage extends StatelessWidget {
  final IncidentResponseData incident;
  const ActivityIncidentDetailPage(this.incident, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-incident-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Kejadian",
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                ActivityIncidentAddPage(
                  int.parse(incident.fishpondId!),
                  int.parse(incident.fishpondcycleId!),
                  isEdit: true,
                  data: incident,
                ),
                ActivityIncidentAddPage.routeSettings,
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
      body: ActivityIncidentDetailView(incident),
    );
  }
}
