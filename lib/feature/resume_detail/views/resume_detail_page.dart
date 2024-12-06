import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';

import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/logic/resume_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/views/resume_detail_view.dart';

class ResumeDetailPage extends StatelessWidget {
  const ResumeDetailPage(
    this.pondID,
    this.pondCycleID,
    this.data, {
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final ResumePerCycleResponseData data;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/resume-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResumeDetailCubit(CycleServiceImpl.create())..init(pondCycleID),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Detail Resume',
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.file_download_outlined,
                color: AppColor.white,
              ),
            ),
            const SizedBox(width: 18.0),
          ],
        ),
        body: ResumeDetailView(
          pondID,
          pondCycleID,
          data,
        ),
      ),
    );
  }
}
