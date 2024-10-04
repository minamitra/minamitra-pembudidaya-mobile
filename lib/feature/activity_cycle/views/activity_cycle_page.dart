import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/logic/activity_cycle_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/views/activity_cycle_view.dart';

class ActivityCyclePage extends StatelessWidget {
  const ActivityCyclePage(this.pondID, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle");

  final String pondID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActivityCycleCubit(CycleServiceImpl.create())..init(pondID),
      child: BlocListener<ActivityCycleCubit, ActivityCycleState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == "TOKEN_EXPIRED") {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Siklus",
          ),
          body: ActivityCycleView(pondID),
        ),
      ),
    );
  }
}
