import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_view.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/activity-page');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(PondServiceImpl.create())..init(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBarWithBucket(
          context,
          "Aktifitas",
        ),
        body: ActivityView(),
      ),
    );
  }
}
