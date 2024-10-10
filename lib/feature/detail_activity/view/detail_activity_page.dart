import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_padding.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/logic/detail_activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DetailActivityPage extends StatelessWidget {
  const DetailActivityPage(
    this.pondData, {
    this.isCanAccessFeature = true,
    super.key,
  });

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/detail-activity-page');
  }

  final PondResponseData pondData;
  final bool isCanAccessFeature;

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    Widget shimmerLoading() {
      return ListView(
        children: [
          AppShimmer(
            MediaQuery.sizeOf(context).height * 0.35,
            double.infinity,
            0,
          ),
          const SizedBox(height: 18.0),
          AppShimmer(
            30.0,
            MediaQuery.sizeOf(context).width * 0.2,
            12.0,
            margin: EdgeInsets.only(
              left: 18.0,
              right: MediaQuery.sizeOf(context).width * 0.6,
            ),
          ),
          const SizedBox(height: 8.0),
          AppShimmer(
            30.0,
            double.infinity,
            12.0,
            margin: AppPadding.horizontal18(),
          ),
          const SizedBox(height: 18.0),
          const AppShimmer(
            120.0,
            double.infinity,
            0,
          ),
          const SizedBox(height: 18.0),
          ...List.generate(
            9,
            (index) {
              return const AppShimmer(
                55.0,
                double.infinity,
                12.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
              );
            },
          ),
        ],
      );
    }

    return BlocProvider(
      create: (context) => DetailActivityCubit(
        CycleServiceImpl.create(),
        PondServiceImpl.create(),
      )..init(
          pondData.id ?? "0",
          pondData.lastFishpondcycleId ?? "",
        ),
      child: BlocBuilder<DetailActivityCubit, DetailActivityState>(
        builder: (context, state) {
          return BlocListener<DetailActivityCubit, DetailActivityState>(
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
                Navigator.of(context).pop("refresh");
              }
            },
            child: Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                elevation: 0,
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
              ),
              body: state.status.isLoading
                  ? shimmerLoading()
                  : DetailActivityView(pondData, isCanAccessFeature),
            ),
          );
        },
      ),
    );
  }
}
