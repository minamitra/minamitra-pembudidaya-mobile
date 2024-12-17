import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/view/bill_payment_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class WaitingPaymentPage extends StatelessWidget {
  const WaitingPaymentPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/waiting-payment-page');
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(
      bytes,
      filePicker: (files) {
        return files.firstWhere(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget background() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        color: const Color(0xFF00317E),
      );
    }

    Widget bodyItem(
      String title,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.neutral[500]),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              style: appTextTheme(context)
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    }

    Widget body() {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight + 48.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColor.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    AppAssets.waitingPaymentLottieNew,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18.0),
                Center(
                  child: Text(
                    'Menunggu Verifikasi',
                    textAlign: TextAlign.center,
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                  ),
                ),
                const SizedBox(height: 36.0),
                bodyItem('Tanggal, Waktu', '11 Des 2024, 19:00'),
                const SizedBox(height: 18.0),
                bodyItem('Metode Pembayaran', 'Transfer'),
                const SizedBox(height: 18.0),
                bodyItem('Penerima', 'Mitra 3M'),
                const SizedBox(height: 18.0),
                bodyItem('Catatan', 'Transfer tagihan kolam 1 Desember 2024'),
                const SizedBox(height: 36.0),
                Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColor.primary[50],
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Total Transaksi',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(color: AppColor.primary[600]),
                      ),
                      Expanded(
                        child: Text(
                          'Rp 100.000',
                          textAlign: TextAlign.end,
                          style: appTextTheme(context).titleSmall?.copyWith(
                                color: AppColor.primary[600],
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '* Verifikasi dilakukan dalam waktu 1x24 jam',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.neutral[400],
                      ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AppPrimaryFullButton(
              'Kembali',
              () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(height: 18.0),
        ],
      );
    }

    Widget appBar() {
      return Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight - 18.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: AppColor.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.neutral[100],
      body: Stack(
        children: [
          background(),
          body(),
          appBar(),
        ],
      ),
    );
  }
}
