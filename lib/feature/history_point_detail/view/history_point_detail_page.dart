import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point_detail/view/history_point_detail_view.dart';

class HistoryPointDetailPage extends StatelessWidget {
  const HistoryPointDetailPage({super.key});

  static const RouteSettings route =
      RouteSettings(name: '/history-point-detail-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        '',
        customLeading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          color: Colors.white,
        ),
      ),
      body: const HistoryPointDetailView(),
    );
  }
}
