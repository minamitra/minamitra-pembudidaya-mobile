import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/resume/resume_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/finance_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/monitoring_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/resume_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/monitoring_view.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage(
    this.pondID,
    this.pondCycleID, {
    required this.isCycleDone,
    required this.tebarDate,
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final bool isCycleDone;
  final DateTime tebarDate;

  static RouteSettings route = const RouteSettings(name: '/monitoring-page');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CultivationCubit(
            CycleServiceImpl.create(),
            tebarDate: tebarDate,
          )..init(
              pondID,
              pondCycleID,
              'mbw',
            ),
        ),
        BlocProvider(create: (context) => MonitoringCubit()),
        BlocProvider(
          create: (context) => FinanceCubit(
            FinanceServiceImpl.create(),
          )..init(pondID),
        ),
        BlocProvider(
          create: (context) =>
              ResumeCubit(ResumeServiceImpl.create())..init(pondID),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ResumeCubit, ResumeState>(
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
          appBar: appDefaultAppBar(context, 'Analisa'),
          floatingActionButton: BlocBuilder<MonitoringCubit, int>(
            builder: (context, state) {
              return const SizedBox();
              // return AppAnimatedSize(
              //   isShow: state == 1,
              //   child: Container(
              //     margin: const EdgeInsets.only(
              //       right: 6.0,
              //       bottom: 6.0,
              //     ),
              //     child: FloatingActionButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           AppTransition.pushTransition(
              //             const AddAnotherFinancePage(),
              //             AddAnotherFinancePage.route(),
              //           ),
              //         );
              //       },
              //       shape: const CircleBorder(),
              //       child: const Icon(Icons.add),
              //     ),
              //   ),
              // );
            },
          ),
          body: MonitoringView(
            pondID,
            pondCycleID,
            isCycleDone: isCycleDone,
          ),
        ),
      ),
    );
  }
}
