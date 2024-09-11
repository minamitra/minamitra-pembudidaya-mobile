import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/activity_activities_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/view/activity_sampling_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/view/activity_water_quality_add_page.dart';

class ActivityActivitiesPage extends StatelessWidget {
  const ActivityActivitiesPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ActivityActivitiesCubit()),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Aktivitas",
        ),
        floatingActionButton:
            BlocBuilder<ActivityActivitiesCubit, ActivityActivitiesState>(
          builder: (context, state) {
            return FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                log("index: ${state.index}");
                switch (state.index) {
                  case 0:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityActivitiesAddPage(),
                      ActivityActivitiesAddPage.routeSettings(),
                    ));
                    break;
                  case 1:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityTreatmentAddPage(),
                      ActivityTreatmentAddPage.routeSettings,
                    ));
                  case 2:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivitySamplingAddPage(),
                      ActivitySamplingAddPage.routeSettings,
                    ));
                  case 3:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityWaterQualityAddPage(),
                      ActivityWaterQualityAddPage.routeSettings,
                    ));
                    break;
                  default:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityActivitiesAddPage(),
                      ActivityActivitiesAddPage.routeSettings(),
                    ));
                    break;
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        body: const ActivityActivitiesView(),
      ),
    );
  }
}
