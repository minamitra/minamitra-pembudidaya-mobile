import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/view/register_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static RouteSettings routeSettings = appRouteSettings("/register-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RegisterView(),
    );
  }
}
