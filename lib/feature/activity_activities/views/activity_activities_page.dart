import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/activity_activities_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/sampling_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/treatment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/water_quality_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/view/activity_sampling_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/view/activity_water_quality_add_page.dart';

class ActivityActivitiesPage extends StatelessWidget {
  final int fishpondId;
  final int fishpondcycleId;

  const ActivityActivitiesPage(
    this.fishpondId,
    this.fishpondcycleId, {
    super.key,
  });

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ActivityActivitiesCubit()),
        BlocProvider(
          create: (context) => TreatmentCubit(
            ActivityTreatmentServiceImpl.create(),
          )..init(
              fishpondId,
              fishpondcycleId,
              AppConvertDateTime().ymdDash(DateTime.now()),
            ),
        ),
        BlocProvider(
          create: (context) => SamplingCubit(
            ActivitySamplingServiceImpl.create(),
          )..init(
              fishpondId,
              fishpondcycleId,
              AppConvertDateTime().ymdDash(DateTime.now()),
            ),
        ),
        BlocProvider(
          create: (context) => WaterQualityCubit(
            ActivityWaterQualityServiceImpl.create(),
          )..init(
              fishpondId,
              fishpondcycleId,
              AppConvertDateTime().ymdDash(DateTime.now()),
            ),
        ),
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
                switch (state.index) {
                  case 0:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityActivitiesAddPage(),
                      ActivityActivitiesAddPage.routeSettings(),
                    ));
                    break;
                  case 1:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityTreatmentAddPage(1, 1),
                      ActivityTreatmentAddPage.routeSettings,
                    ));
                  case 2:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivitySamplingAddPage(1, 1),
                      ActivitySamplingAddPage.routeSettings,
                    ));
                  case 3:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const ActivityWaterQualityAddPage(1, 1),
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
        body: ActivityActivitiesView(
          fishpondId,
          fishpondcycleId,
        ),
      ),
    );
  }
}
