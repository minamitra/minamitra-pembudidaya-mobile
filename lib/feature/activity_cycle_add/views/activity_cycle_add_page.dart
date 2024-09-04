import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add/views/activity_cycle_add_view.dart';

class ActivityCycleAddPage extends StatelessWidget {
  const ActivityCycleAddPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle-add");

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
          "Tambah Aktivitas",
        ),
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
        body: const ActivityCycleAddView(),
      ),
    );
  }
}
