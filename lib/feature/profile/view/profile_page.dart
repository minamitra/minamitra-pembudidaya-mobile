import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/logic/profile_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/view/profile_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/profile-page');
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => ProfileCubit(AuthenticationServiceImpl.create()),
      child: BlocListener<ProfileCubit, ProfileState>(
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
            Navigator.of(context).pop();
            RepositoryProvider.of<AuthenticationRepository>(context)
                .logout(isRequestServiceAPI: false);
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBarWithBucket(context, "Profil"),
          body: const ProfileView(),
        ),
      ),
    );
  }
}
