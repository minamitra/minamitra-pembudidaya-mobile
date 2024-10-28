import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/monitoring_view.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage(this.pondCycleID, {super.key});

  final String pondCycleID;

  static RouteSettings route = const RouteSettings(name: '/monitoring-page');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CultivationCubit(CycleServiceImpl.create())
              ..init(
                pondCycleID,
                "mbw",
              ))
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(context, "Analisa"),
        body: MonitoringView(),
      ),
    );
  }
}
