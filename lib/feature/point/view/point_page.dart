import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point/view/point_view.dart';

class PointPage extends StatelessWidget {
  const PointPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/point-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Informasi Poin",
      ),
      body: PointView(),
    );
  }
}
