import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information/views/literacy_information_view.dart';

class LiteracyInformationPage extends StatelessWidget {
  const LiteracyInformationPage({super.key});

  static RouteSettings settings =
      const RouteSettings(name: '/literacy-information-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Literasi dan Informasi',
      ),
      body: LiteracyInformationView(),
    );
  }
}
