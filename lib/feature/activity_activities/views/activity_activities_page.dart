import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/activity_activities_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/sampling_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/treatment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/water_quality_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/feed/activity_feed_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/view/activity_sampling_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/view/activity_water_quality_add_page.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ActivityActivitiesPage extends StatelessWidget {
  const ActivityActivitiesPage(
    this.pondID,
    this.pondCycleID,
    this.tebarDate, {
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final DateTime? tebarDate;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ActivityActivitiesCubit(FeedActivityServiceImpl.create())
                  ..init(pondCycleID)),
        BlocProvider(
            create: (context) =>
                ActivityFeedCubit(FeedActivityServiceImpl.create())),
        BlocProvider(
          create: (context) => TreatmentCubit(
            ActivityTreatmentServiceImpl.create(),
          )..init(
              int.parse(pondID),
              int.parse(pondCycleID),
              AppConvertDateTime().ymdDash(DateTime.now()),
            ),
        ),
        BlocProvider(
          create: (context) => SamplingCubit(
            ActivitySamplingServiceImpl.create(),
          )..init(
              int.parse(pondID),
              int.parse(pondCycleID),
              AppConvertDateTime().ymdDash(DateTime.now()),
            ),
        ),
        BlocProvider(
          create: (context) => WaterQualityCubit(
            ActivityWaterQualityServiceImpl.create(),
          )..init(
              int.parse(pondID),
              int.parse(pondCycleID),
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
                    Navigator.of(context)
                        .push(AppTransition.pushTransition(
                      ActivityActivitiesAddPage(
                        pondID,
                        pondCycleID,
                        tebarDate ?? DateTime.now(),
                      ),
                      ActivityActivitiesAddPage.routeSettings(),
                    ))
                        .then((value) {
                      if (value != null && value == "refresh") {
                        context.read<ActivityActivitiesCubit>().refreshData();
                      }
                    });
                    break;
                  case 1:
                    Navigator.of(context)
                        .push(AppTransition.pushTransition(
                      ActivityTreatmentAddPage(
                        int.parse(pondID),
                        int.parse(pondCycleID),
                        tebarDate ?? DateTime.now(),
                      ),
                      ActivityTreatmentAddPage.routeSettings,
                    ))
                        .then((value) {
                      if (value != null && value == "refresh") {
                        context.read<TreatmentCubit>().init(
                              int.parse(pondID),
                              int.parse(pondCycleID),
                              AppConvertDateTime().ymdDash(
                                  state.selectedDate ?? DateTime.now()),
                            );
                      }
                    });
                  case 2:
                    Navigator.of(context)
                        .push(AppTransition.pushTransition(
                      ActivitySamplingAddPage(
                        int.parse(pondID),
                        int.parse(pondCycleID),
                      ),
                      ActivitySamplingAddPage.routeSettings,
                    ))
                        .then((value) {
                      if (value != null && value == "refresh") {
                        context.read<SamplingCubit>().init(
                              int.parse(pondID),
                              int.parse(pondCycleID),
                              AppConvertDateTime().ymdDash(
                                state.selectedDate ?? DateTime.now(),
                              ),
                            );
                      }
                    });
                  case 3:
                    Navigator.of(context)
                        .push(AppTransition.pushTransition(
                      ActivityWaterQualityAddPage(
                        int.parse(pondID),
                        int.parse(pondCycleID),
                      ),
                      ActivityWaterQualityAddPage.routeSettings,
                    ))
                        .then((value) {
                      if (value != null && value == "refresh") {
                        context.read<WaterQualityCubit>().init(
                              int.parse(pondID),
                              int.parse(pondCycleID),
                              AppConvertDateTime().ymdDash(
                                state.selectedDate ?? DateTime.now(),
                              ),
                            );
                      }
                    });
                    break;
                  default:
                    Navigator.of(context).push(AppTransition.pushTransition(
                      ActivityActivitiesAddPage(
                        pondID,
                        pondCycleID,
                        tebarDate ?? DateTime.now(),
                      ),
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
          int.parse(pondID),
          int.parse(pondCycleID),
          tebarDate ?? DateTime.now(),
        ),
      ),
    );
  }
}
