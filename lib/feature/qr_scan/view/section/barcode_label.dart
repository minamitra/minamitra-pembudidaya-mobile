import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
        Image.asset(
          AppAssets.logoIcon,
          height: 55.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Pindai kode QR Mitra\nuntuk melakukan transaksi pembayaran',
          textAlign: TextAlign.center,
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.white,
              ),
        ),
      ],
    );
  }
}
