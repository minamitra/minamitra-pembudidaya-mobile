import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/sampling_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/sampling/sampling_view.dart';

class SamplingResumeDetailPage extends StatelessWidget {
  const SamplingResumeDetailPage(
    this.fishPondID,
    this.fishPondCycleID, {
    super.key,
  });

  final int fishPondID;
  final int fishPondCycleID;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/sampling-resume-detail-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SamplingCubit(ActivitySamplingServiceImpl.create())
        ..initAllData(
          fishPondID,
          fishPondCycleID,
        ),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Data Sampling',
        ),
        body: SamplingView(
          fishPondID,
          fishPondCycleID,
          DateTime.now().toString(),
          tebarDate: DateTime.now(),
          isHistoricalData: true,
        ),
      ),
    );
  }
}
