import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_theme.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
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
      home: const LoginRegisterPage(),
      builder: (context, child) {
        // Future.delayed(
        //   const Duration(seconds: 3),
        //   () {
        //     _navigator.pushReplacement(AppTransition.pushTransition(
        //       const LoginRegisterPage(),
        //       LoginRegisterPage.route,
        //     ));
        //   },
        // );
        return child!;
      },
    );
  }
}
