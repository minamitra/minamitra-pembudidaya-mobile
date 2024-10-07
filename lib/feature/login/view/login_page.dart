import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/logic/login_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/view/login_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static RouteSettings route = appRouteSettings('/login-page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveCubit>(
          create: (context) => ActiveCubit(false),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
              RepositoryProvider.of<AuthenticationRepository>(context)),
        ),
      ],
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoaded) {
            dialog.hide();
          }

          if (state is LoginFailed) {
            dialog.hide();
            AppTopSnackBar(context).showDanger(state.message);
          }

          if (state is LoginLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }
        },
        child: Scaffold(
          body: LoginView(),
        ),
      ),
    );
  }
}
