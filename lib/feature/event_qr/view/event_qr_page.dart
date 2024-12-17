import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_list_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventQrPage extends StatefulWidget {
  const EventQrPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/event-qr-page');
  }

  @override
  State<EventQrPage> createState() => _EventQrPageState();
}

class _EventQrPageState extends State<EventQrPage> {
  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          top: 55.0,
          bottom: 18.0,
        ),
        child: Row(
          children: [
            InkWell(
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
            Expanded(
              child: Text(
                'Tiket Saya',
                textAlign: TextAlign.center,
                style: appTextTheme(context).headlineMedium?.copyWith(
                      color: AppColor.white,
                    ),
              ),
            ),
            InkWell(
              onTap: () {
                appBottomSheetShowModalCustom(
                  context,
                  'Langkah Melakukan Presensi',
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          children: [
                            AppListText(
                              Text(
                                '1.',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.neutral[600],
                                        ),
                              ),
                              'Pastikan anda sudah terdaftar pada acara yang akan diikuti dengan melihat status daftar: “Sudah Terdaftar”.',
                            ),
                            const SizedBox(height: 18.0),
                            AppListText(
                              Text(
                                '2.',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.neutral[600],
                                        ),
                              ),
                              'Datang ke meja registrasi di lokasi acara.',
                            ),
                            const SizedBox(height: 18.0),
                            AppListText(
                              Text(
                                '3.',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.neutral[600],
                                        ),
                              ),
                              'Akses tiket anda dengan menekan tombol “Tampilkan QR”.',
                            ),
                            const SizedBox(height: 18.0),
                            AppListText(
                              Text(
                                '4.',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.neutral[600],
                                        ),
                              ),
                              'Tunjukkan tiket anda pada petugas registrasi untuk dipindai.',
                            ),
                            const SizedBox(height: 18.0),
                            AppListText(
                              Text(
                                '5.',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.neutral[600],
                                        ),
                              ),
                              'Setelah berhasil dipindai, pastikan status pada detail acara telah berubah menjadi “Hadir”.',
                            ),
                            const SizedBox(height: 18.0),
                          ],
                        ),
                      ),
                      AppDividerSmall(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: AppPrimaryFullButton(
                          'Tutup',
                          () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.55,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget dividerTicket() {
      return Row(
        children: [
          Container(
            width: 18.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: AppColor.primary[900],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(1000.0),
                bottomRight: Radius.circular(1000.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          const Expanded(child: AppDottedLine()),
          const SizedBox(width: 8.0),
          Container(
            width: 18.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: AppColor.primary[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1000.0),
                bottomLeft: Radius.circular(1000.0),
              ),
            ),
          ),
        ],
      );
    }

    Widget ticketItemData(
      String title,
      String value,
    ) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context)
                .labelSmall
                ?.copyWith(color: AppColor.neutral[400]),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
          ),
        ],
      );
    }

    Widget ticket() {
      return Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 36.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 120.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg/640px-Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Workshop Pemilihan Pakan Tepat untuk Setiap Tahap Siklus Budidaya Patin',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context)
                              .titleSmall
                              ?.copyWith(color: const Color(0xFF155ED0)),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: ticketItemData(
                                'Tanggal',
                                'Sabtu, 12 Des 2021',
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: ticketItemData(
                                'Waktu',
                                '09.00 - 12.00 WIB',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        ticketItemData(
                          'ALAMAT',
                          'Jl. Raya Ciputat Parung No. 1, Ciputat, Tangerang Selatan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            dividerTicket(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 18.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: QrImageView(
                        padding: const EdgeInsets.all(8.0),
                        data: '3M1N4M1TR4-12000-210924',
                        version: QrVersions.auto,
                        backgroundColor: AppColor.white,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: AppColor.primary[700],
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: AppColor.primary[800],
                        ),
                        gapless: false,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '3M1N4M1TR4-12000-210924',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColor.white,
        ),
        child: Text(
          'Download',
          textAlign: TextAlign.center,
          style: appTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.primary[500],
              ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00317E),
              Color(0xFF002155),
            ],
          ),
        ),
        child: Column(
          children: [
            appBar(),
            Expanded(child: ticket()),
            button(),
          ],
        ),
      ),
    );
  }
}
