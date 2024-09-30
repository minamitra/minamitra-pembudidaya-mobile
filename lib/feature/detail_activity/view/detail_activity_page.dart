import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/logic/detail_activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_view.dart';

class DetailActivityPage extends StatelessWidget {
  const DetailActivityPage(this.pondData, {super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/detail-activity-page');
  }

  final PondResponseData pondData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailActivityCubit(CycleServiceImpl.create())
        ..init(pondData.id ?? "0"),
      child: BlocBuilder<DetailActivityCubit, DetailActivityState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
            ),
            body: state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : DetailActivityView(pondData),
          );
        },
      ),
    );
  }
}
