import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_view.dart';

class DetailActivityPage extends StatelessWidget {
  const DetailActivityPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/detail-activity-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: DetailActivityView(),
    );
  }
}
