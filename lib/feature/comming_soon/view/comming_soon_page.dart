import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_view.dart';

class CommingSoonPage extends StatelessWidget {
  const CommingSoonPage(this.pageTitle, {super.key});

  final String pageTitle;

  static RouteSettings route() =>
      const RouteSettings(name: "/comming-soon-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        pageTitle,
      ),
      body: const CommingSoonView(),
    );
  }
}
