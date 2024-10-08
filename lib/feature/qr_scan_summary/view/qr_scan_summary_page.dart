import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan_summary/view/qr_scan_summary_view.dart';

class QrScanSummaryPage extends StatelessWidget {
  const QrScanSummaryPage({super.key});

  static RouteSettings route() =>
      const RouteSettings(name: '/qr-scan-summary-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, "Pembayaran"),
      body: const QrScanSummaryView(),
    );
  }
}
