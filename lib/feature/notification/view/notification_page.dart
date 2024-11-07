import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/view/notification_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/notification-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Notifikasi',
      ),
      body: const NotificationView(),
    );
  }
}
