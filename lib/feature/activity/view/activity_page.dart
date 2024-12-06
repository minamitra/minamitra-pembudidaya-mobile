import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/resume_activity_cubit.dart';
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
        BlocProvider<ResumeActivityCubit>(
          create: (context) =>
              ResumeActivityCubit(PondServiceImpl.create())..init(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ActivityCubit, ActivityState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == 'TOKEN_EXPIRED') {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }
            },
          ),
          BlocListener<ResumeActivityCubit, ResumeActivityState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == 'TOKEN_EXPIRED') {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: appDefaultAppBarWithBucket(
            context,
            'Aktivitas',
          ),
          body: const ActivityView(),
        ),
      ),
    );
  }
}
