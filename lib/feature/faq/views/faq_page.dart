import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq/views/faq_view.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/faq-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, "Frequently Asked Questions"),
      body: const FaqView(),
    );
  }
}
