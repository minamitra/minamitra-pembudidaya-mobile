import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/change_password/logic/change_password_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/change_password/view/change_password_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/change-password-page');
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => ChangePasswordCubit(ProfileServiceImpl.create()),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == "TOKEN_EXPIRED") {
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
            AppTopSnackBar(context).showSuccess("Berhasil mengganti password");
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Ganti Password",
          ),
          body: const ChangePasswordView(),
        ),
      ),
    );
  }
}
