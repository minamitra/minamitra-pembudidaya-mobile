import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/views/activity_cycle_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_add_harvest_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/views/activity_cycle_add_harvest_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ActivityCycleAddHarvestPage extends StatelessWidget {
  const ActivityCycleAddHarvestPage(
    this.id, {
    this.isFromCycleDetail = true,
    this.data,
    super.key,
  });

  final String id;
  final bool isFromCycleDetail;
  final FeedCycleHistoryResponseData? data;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-cycle-add-harvest");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityCyclePictureCubit>(
          create: (BuildContext context) =>
              ActivityCyclePictureCubit(CdnServiceImpl.create())
                ..initImage(image: data?.panenAttachmentJsonArray),
        ),
        BlocProvider<ActivityCycleAddHarvestCubit>(
            create: (BuildContext context) => ActivityCycleAddHarvestCubit(
                  CycleServiceImpl.create(),
                )..init(data: data)),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ActivityCycleAddHarvestCubit,
              ActivityCycleAddHarvestState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == "TOKEN_EXPIRED") {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }

              if (state.status.isShowDialogLoading) {
                AppDialog().showLoadingDialog(context, dialog);
              }

              if (state.status.isHideDialogLoading) {
                dialog.hide();
              }

              if (state.status.isSuccessSubmit) {
                //! please correct the route
                AppTopSnackBar(context)
                    .showSuccess("Berhasil menambahkan panen");
                if (isFromCycleDetail) {
                  Navigator.of(context).popUntil(ModalRoute.withName(
                      ActivityCyclePage.routeSettings().name ?? ""));
                } else {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop("refresh");
                }
              }
            },
          ),
          BlocListener<ActivityCyclePictureCubit, ActivityCyclePictureState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == "TOKEN_EXPIRED") {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }

              if (state.status.isShowDialogLoading) {
                AppDialog().showLoadingDialog(context, dialog);
              }

              if (state.status.isHideDialogLoading) {
                dialog.hide();
              }
            },
          )
        ],
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Panen",
          ),
          backgroundColor: Colors.white,
          body: ActivityCycleAddHarvestView(
            id,
            data: data,
          ),
        ),
      ),
    );
  }
}
