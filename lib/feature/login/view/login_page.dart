import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/view/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static RouteSettings route = appRouteSettings('/login-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginView(),
    );
  }
}
