import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/logic/qrscan_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/view/section/barcode_label.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/view/section/button_scanner.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan_summary/view/qr_scan_summary_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> with WidgetsBindingObserver {
  final MobileScannerController controller =
      MobileScannerController(cameraResolution: const Size(480, 640));

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    List<Widget> qrScanner(bool isShow) {
      return isShow
          ? [
              Center(
                child: MobileScanner(
                  fit: BoxFit.cover,
                  controller: controller,
                  scanWindow: scanWindow,
                  errorBuilder: (context, error, child) {
                    return Center(
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                  overlayBuilder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child:
                            ScannedBarcodeLabel(barcodes: controller.barcodes),
                      ),
                    );
                  },
                  onDetect: (barcode) {
                    Navigator.of(context)
                        .pushReplacement(AppTransition.pushTransition(
                      const QrScanSummaryPage(),
                      QrScanSummaryPage.route(),
                    ));
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) {
                  if (!value.isInitialized ||
                      !value.isRunning ||
                      value.error != null) {
                    return const SizedBox();
                  }

                  return CustomPaint(
                    painter: ScannerOverlay(scanWindow: scanWindow),
                  );
                },
              ),
            ]
          : [];
    }

    Widget buildQrCode(bool isShow) {
      return isShow
          ? Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Silahkan Scan QR Code\nDibawah Ini",
                      textAlign: TextAlign.center,
                      style: appTextTheme(context).titleLarge?.copyWith(
                            color: AppColor.neutral[900],
                          ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    QrImageView(
                      padding: const EdgeInsets.all(8.0),
                      data: '3M1N4M1TR4-12000-210924',
                      version: QrVersions.auto,
                      backgroundColor: AppColor.neutral[200]!,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppColor.primary[700],
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColor.primary[800],
                      ),
                      size: 320,
                      gapless: false,
                      embeddedImage: AssetImage(AppAssets.newLogoIcon2),
                      embeddedImageStyle:
                          QrEmbeddedImageStyle(size: Size(547 / 3, 112 / 3)),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox();
    }

    return BlocBuilder<QrscanCubit, QrscanState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...qrScanner(state.qrScanType == QRScanType.scan),
            buildQrCode(state.qrScanType == QRScanType.generate),
            state.qrScanType == QRScanType.scan
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ToggleFlashlightButton(controller: controller),
                          SwitchCameraButton(controller: controller),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: AppColor.primary[500],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (state.qrScanType == QRScanType.generate) {
                                context
                                    .read<QrscanCubit>()
                                    .setQRScanType(QRScanType.scan);
                              }
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.document_scanner_outlined,
                                  color: AppColor.white,
                                  size: 28.0,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Bayar dengan QR',
                                  style: appTextTheme(context)
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppColor.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 55.0,
                          child: VerticalDivider(
                            color: AppColor.white,
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (state.qrScanType == QRScanType.scan) {
                                context
                                    .read<QrscanCubit>()
                                    .setQRScanType(QRScanType.generate);
                              }
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.qr_code_2,
                                  color: AppColor.white,
                                  size: 28.0,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Tampilkan QR Code',
                                  style: appTextTheme(context)
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppColor.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: use `Offset.zero & size` instead of Rect.largest
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
