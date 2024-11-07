import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification_detail/view/notification_detail_view.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage(
    this.title,
    this.time,
    this.description, {
    this.image,
    super.key,
  });

  final String title;
  final String time;
  final String description;
  final String? image;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/notification-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Detail Notifikasi',
      ),
      body: NotificationDetailView(
        title,
        time,
        description,
        image: image,
      ),
    );
  }
}
