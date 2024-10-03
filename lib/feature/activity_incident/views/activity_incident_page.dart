import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_incident/activity_incident_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/logics/incident_data_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/logics/incident_history_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/views/activity_incident_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/views/activity_incident_add_page.dart';

class ActivityIncidentPage extends StatelessWidget {
  final String fishpondId;
  final String fishpondcycleId;

  const ActivityIncidentPage(
    this.fishpondId,
    this.fishpondcycleId, {
    super.key,
  });

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-incident");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IncidentDataCubit(
            ActivityIncidentServiceImpl.create(),
          )..getIncidentData(),
        ),
        BlocProvider(
          create: (context) => IncidentHistoryCubit(
            ActivityIncidentServiceImpl.create(),
          )..getIncidentHistory(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Kejadian",
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context)
                  .push(AppTransition.pushTransition(
                ActivityIncidentAddPage(
                  int.parse(fishpondId),
                  int.parse(fishpondcycleId),
                ),
                ActivityIncidentAddPage.routeSettings,
              ))
                  .then((value) {
                if (value != null && value == "refresh") {
                  context.read<IncidentDataCubit>().getIncidentData();
                  context.read<IncidentHistoryCubit>().getIncidentHistory();
                }
              });
            },
            child: const Icon(Icons.add),
          );
        }),
        body: const ActivityIncidentView(),
      ),
    );
  }
}
