import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/views/activity_cycle_add_harvest_view.dart';

class ActivityCycleAddHarvestPage extends StatelessWidget {
  const ActivityCycleAddHarvestPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle-add-harvest");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityCyclePictureCubit>(
          create: (BuildContext context) => ActivityCyclePictureCubit(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Panen",
        ),
        backgroundColor: Colors.white,
        body: const ActivityCycleAddHarvestView(),
      ),
    );
  }
}
