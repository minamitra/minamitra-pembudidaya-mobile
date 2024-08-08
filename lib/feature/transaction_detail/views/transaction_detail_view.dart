import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key});

  Widget statusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.accent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Menunggu Konfirmasi Pesanan',
        textAlign: TextAlign.center,
        style: appTextTheme(context).bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
      ),
    );
  }

  Widget paymentMethod(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primary[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  AppAssets.walletIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plafon",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                    ),
                    Text(
                      "Bayar menggunakan plafon",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black[400],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget address(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alamat Pesanan',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              Row(
                children: [
                  Text(
                    'ID Pesanan',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black[500],
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '782784991',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  Image.asset(
                    AppAssets.copyIcon,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColor.neutral[200]!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.primary[900],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppAssets.mapPinIcon,
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alamat Pengiriman",
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                            ),
                      ),
                      Text(
                        "Jl. Raya Bunga Matahari",
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.black[500],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderItems(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan Kamu',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 8.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  AppAssets.product1Image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pakan Siap Cetak (PSC) Mina Mitra Mandiri",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Pakan",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black[400],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appConvertCurrency(200000),
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "x1",
                            textAlign: TextAlign.end,
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowText(
    BuildContext context,
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.black[500],
              ),
        ),
        Text(
          value,
          textAlign: TextAlign.end,
          style: appTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
        ),
      ],
    );
  }

  Widget orderDetail(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pesanan',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          rowText(
            context,
            "No Pesanan",
            "XD-89100-B",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Tanggal Pesanan",
            "15 Nov 2024, 16.08",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Atas Nama",
            "John Doe",
          ),
        ],
      ),
    );
  }

  Widget feeDetail(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rincian Biaya',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          rowText(
            context,
            "Harga",
            "200.000",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Potongan Harga",
            "10.000",
          ),
          const SizedBox(height: 16.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Pembayaran",
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              Text(
                "Rp 190.000",
                textAlign: TextAlign.end,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.accent,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          AppPrimaryFullButton(
            "Tutup Halaman",
            () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 16.0),
          AppPrimaryOutlineFullButton("Laporkan", () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16.0),
        statusBar(context),
        const SizedBox(height: 16.0),
        paymentMethod(context),
        const SizedBox(height: 16.0),
        address(context),
        const SizedBox(height: 16.0),
        orderItems(context),
        const SizedBox(height: 16.0),
        orderDetail(context),
        const SizedBox(height: 16.0),
        feeDetail(context),
        const SizedBox(height: 32.0),
        button(context),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
