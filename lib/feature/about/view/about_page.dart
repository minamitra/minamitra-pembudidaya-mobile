import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/about/view/about_view.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/about-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Tentang Kami",
      ),
      body: AboutView(),
    );
  }
}
