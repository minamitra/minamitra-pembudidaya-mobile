import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/voucher_detail/view/voucher_detail_view.dart';

class VoucherDetailPage extends StatelessWidget {
  const VoucherDetailPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/voucher-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VoucherDetailView(),
    );
  }
}
