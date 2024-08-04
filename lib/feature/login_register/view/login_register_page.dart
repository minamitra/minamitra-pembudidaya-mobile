import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login_register/view/login_register_view.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  static RouteSettings route = appRouteSettings('/login-register');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginRegisterView(),
    );
  }
}
