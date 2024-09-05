import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/authentication/authentication_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_theme.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/views/dashboard_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login_register/view/login_register_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/splash/view/splash_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mina Mitra Mandiri',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: const SplashView(),
      builder: (context, child) {
        return BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                // context.read<UserCubit>().refreshUser();
                _navigator.pushAndRemoveUntil(
                  AppTransition.pushAndRemoveUntilTransition(
                    DashboardPage(),
                    DashboardPage.routeSettings(),
                  ),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.initial:
              case AuthenticationStatus.error:
              case AuthenticationStatus.loading:
              case AuthenticationStatus.success:
              case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.unknown:
              case AuthenticationStatus.unverifiedEKYC:
              case AuthenticationStatus.waitingEKYC:
                Future.delayed(
                  Duration(milliseconds: 1000),
                  () {
                    _navigator.pushAndRemoveUntil(
                      AppTransition.pushAndRemoveUntilTransition(
                        const LoginRegisterPage(),
                        LoginRegisterPage.route,
                      ),
                      (route) => false,
                    );
                  },
                );

                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
