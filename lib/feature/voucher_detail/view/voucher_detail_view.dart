import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class VoucherDetailView extends StatefulWidget {
  const VoucherDetailView({super.key});

  @override
  State<VoucherDetailView> createState() => _VoucherDetailViewState();
}

class _VoucherDetailViewState extends State<VoucherDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Stack(
        children: [
          Container(
            color: AppColor.primary[800],
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: Center(
                    child: Image.asset(
                      AppAssets.voucherBoxIcon,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  left: 18.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 18.0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget title(String title) {
      return Text(
        title,
        textAlign: TextAlign.start,
        style: appTextTheme(context)
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );
    }

    Widget titleAndValueSection(
      String title,
      String value,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context)
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      );
    }

    Widget subTitle(String title) {
      return Text(
        title,
        textAlign: TextAlign.start,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
      );
    }

    Widget descriptionVoucherItem(String text) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\u2022',
            style: TextStyle(
              fontSize: 16,
              height: 1,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              softWrap: true,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral[500],
                  ),
            ),
          ),
        ],
      );
    }

    List<Widget> listDescriptionVoucher() {
      List<String> descItem = [
        'Voucher hanya berlaku untuk pengguna yang telah mendaftarkan akun pada Mitra 3M',
        'Voucher hanya dapat digunakan selama masa berlaku yang telah ditentukan.',
        'Akun pengguna harus diverifikasi untuk menggunakan voucher.',
        'Voucher hanya dapat digunakan 1 kali per pengguna. Tidak dapat digabungkan dengan promo lain, termasuk voucher atau potongan harga lainnya.',
        'Voucher dapat digunakan untuk produk tertentu',
        'Voucher tidak dapat diuangkan atau dikembalikan dalam bentuk tunai.',
        'Jika transaksi dibatalkan, voucher dianggap hangus dan tidak dapat digunakan kembali.',
      ];

      return List.generate(
        descItem.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: descriptionVoucherItem(descItem[index]),
          );
        },
      );
    }

    Widget body() {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(18.0),
        children: [
          title('Black Friday 50% Off'),
          const SizedBox(height: 18.0),
          const AppDivider(thickness: 2.0),
          const SizedBox(height: 18.0),
          titleAndValueSection(
            'Periode',
            '02 Des 2024 00:00 - 08 Des 2024 23:59',
          ),
          const SizedBox(height: 18.0),
          titleAndValueSection(
            'Skema Diskon',
            'Produk Tertentu',
          ),
          const SizedBox(height: 18.0),
          titleAndValueSection(
            'Jumlah Diskon',
            '50% s/d Rp 100RB',
          ),
          const SizedBox(height: 18.0),
          subTitle('Deskripsi Voucher'),
          const SizedBox(height: 8.0),
          ...listDescriptionVoucher(),
          const SizedBox(height: 18.0),
        ],
      );
    }

    Widget applyButton() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        color: AppColor.white,
        child: AppPrimaryFullButton(
          'Pakai Sekarang',
          () {},
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              header(),
              WidgetFeatureOnProgressComponent(),
              body(),
            ],
          ),
        ),
        applyButton(),
      ],
    );
  }
}
