import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/call_center/view/call_center_view.dart';

class CallCenterPage extends StatelessWidget {
  const CallCenterPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/call-center-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Pusat Bantuan",
      ),
      body: CallCenterView(),
    );
  }
}
