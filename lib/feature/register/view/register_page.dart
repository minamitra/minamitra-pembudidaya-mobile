import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/secondary_active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/logic/login_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/logic/register_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/view/register_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static RouteSettings routeSettings = appRouteSettings("/register-page");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveCubit>(
          create: (context) => ActiveCubit(false),
        ),
        BlocProvider<SecondaryActiveCubit>(
          create: (context) => SecondaryActiveCubit(false),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) =>
              RegisterCubit(AuthenticationServiceImpl.create()),
        ),
      ],
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }

          if (state.status.isError) {
            if (state.errorMessage == "TOKEN_EXPIRED") {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }

          if (state.status.isSuccessSubmit) {
            AppTopSnackBar(context)
                .showSuccess("Berhasil mendaftar\nSilahkan Login !");
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: RegisterView(),
        ),
      ),
    );
  }
}
