import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq_detail/views/faq_detail_view.dart';

class FaqDetailPage extends StatelessWidget {
  final String title;

  const FaqDetailPage(this.title, {super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/faq-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, "Detail FAQ"),
      body: FaqDetailView(title),
    );
  }
}
