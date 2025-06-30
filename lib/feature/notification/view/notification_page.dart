import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/notification/notification_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/logic/notification_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/view/notification_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/notification-page');
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => NotificationCubit(
        context,
        NotificationServiceImpl.create(),
      )..getNotificationList(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Notifikasi',
        ),
        body: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state.status.isError) {
              if (state.errorMessage == 'TOKEN_EXPIRED') {
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
          child: const NotificationView(),
        ),
      ),
    );
  }
}
