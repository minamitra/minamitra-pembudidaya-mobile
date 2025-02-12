import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_exchange_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_mission_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/point_v2_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PointV2Page extends StatelessWidget {
  const PointV2Page({super.key});

  static RouteSettings route() => const RouteSettings(name: '/point-v2-page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<PointV2Cubit>(
          create: (context) => PointV2Cubit(),
        ),
        BlocProvider<PointMissionV2Cubit>(
          create: (context) =>
              PointMissionV2Cubit(PointServiceImpl.create())..init(),
        ),
        BlocProvider<PointExchangeCubit>(
          create: (context) => PointExchangeCubit(PointServiceImpl.create()),
        ),
      ],
      child: BlocListener<PointExchangeCubit, PointExchangeState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == 'TOKEN_EXPIRED') {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
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
            AppTopSnackBar(context).showSuccess(
              'Berhasil menukarkan poin\nTunggu 1x24 jam untuk diproses',
            );
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
            elevation: 0.0,
          ),
          body: const PointV2View(),
        ),
      ),
    );
  }
}
