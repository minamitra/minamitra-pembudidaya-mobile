import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/view/qr_scan_view.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  static RouteSettings route() => const RouteSettings(name: '/qr-scan-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(context, "QR Scan"),
      body: QrScanView(),
    );
  }
}
