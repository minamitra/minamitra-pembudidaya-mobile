import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/authentication/authentication_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/user/user_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_theme.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/views/dashboard_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login_register/view/login_register_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/splash/view/splash_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    return RefreshConfiguration(
      footerTriggerDistance: 75.0,
      dragSpeedRatio: 0.80,
      child: MaterialApp(
        title: 'Mina Mitra Mandiri',
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        home: const SplashView(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', 'ID'),
          Locale('en', 'US'),
        ],
        locale: const Locale('id', 'ID'),
        builder: (context, child) {
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  context.read<UserCubit>().refreshUser();
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
      ),
    );
  }
}
