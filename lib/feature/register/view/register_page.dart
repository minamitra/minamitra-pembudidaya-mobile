import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/secondary_active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/view/register_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static RouteSettings routeSettings = appRouteSettings("/register-page");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveCubit>(
          create: (context) => ActiveCubit(false),
        ),
        BlocProvider<SecondaryActiveCubit>(
          create: (context) => SecondaryActiveCubit(false),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: RegisterView(),
      ),
    );
  }
}
