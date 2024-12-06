import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/repositories/event_type.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView(this.eventType, {super.key});

  final EventType eventType;

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final List<String> materialData = [
    'Jenis-jenis pakan dan fungsinya.',
    'Kapan dan bagaimana memberikan pakan starter, grower, dan finisher.',
    'Teknik evaluasi performa pakan pada setiap tahap budidaya.',
    'Studi kasus sukses peternak patin dalam pemilihan pakan yang optimal.',
  ];

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
                AspectRatio(
                  aspectRatio: 375 / 262,
                  child: InkWell(
                    onTap: () {
                      showImageViewer(
                        context,
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg/640px-Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg',
                        ).image,
                        immersive: false,
                        useSafeArea: true,
                        swipeDismissible: true,
                        doubleTapZoomable: true,
                        backgroundColor: Colors.black.withOpacity(0.7),
                      );
                    },
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg/640px-Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssets.dummyDetailActivityBannerImage,
                        );
                      },
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

    Widget title() {
      return Text(
        'Workshop Pemilihan Pakan Tepat untuk Setiap Tahap Siklus Budidaya Patin',
        textAlign: TextAlign.start,
        style: appTextTheme(context)
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );
    }

    Widget uploader() {
      return Text(
        'oleh Admin Mitra 3M',
        textAlign: TextAlign.start,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColor.neutral[500],
            ),
      );
    }

    Widget description() {
      return Text(
        'Workshop ini bertujuan untuk memberikan wawasan mendalam mengenai pemilihan pakan yang sesuai pada setiap tahap siklus budidaya ikan patin. Para peserta akan mempelajari teknik dan strategi untuk meningkatkan efisiensi pemberian pakan, mengoptimalkan pertumbuhan ikan, serta meminimalkan biaya operasional melalui praktik terbaik. Acara ini dirancang untuk membantu petani ikan patin mengelola pakan dengan lebih efektif dan meningkatkan hasil panen.',
        textAlign: TextAlign.start,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColor.neutral[500],
            ),
      );
    }

    Widget materialItem(String text) {
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

    Widget materialTitle() {
      return Text(
        'Apa yang akan dipelajari:',
        textAlign: TextAlign.start,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColor.neutral[500],
            ),
      );
    }

    List<Widget> listMaterial() {
      return List.generate(
        materialData.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: materialItem(materialData[index]),
          );
        },
      );
    }

    Widget eventItem(
      IconData icon,
      String text,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> eventDetail() {
      return [
        Text(
          'Detail Event',
          textAlign: TextAlign.start,
          style: appTextTheme(context)
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 24.0),
        eventItem(
          Icons.calendar_month_outlined,
          'Senin, 19 November 2024',
        ),
        const SizedBox(height: 8.0),
        eventItem(
          Icons.access_time_outlined,
          '13:00 - Selesai',
        ),
        const SizedBox(height: 8.0),
        eventItem(
          Icons.location_on_outlined,
          'Kantor Solusi3M Cabang OKU Timur',
        ),
        const SizedBox(height: 8.0),
        eventItem(
          Icons.confirmation_number_outlined,
          widget.eventType == EventType.unregistered
              ? 'Belum Terdaftar'
              : widget.eventType == EventType.upcoming
                  ? 'Sudah Daftar'
                  : 'Selesai',
        ),
      ];
    }

    Widget button() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: AppColor.white,
          margin: const EdgeInsets.all(18.0),
          child: widget.eventType == EventType.unregistered
              ? AppPrimaryFullButton(
                  'Daftar Sekarang',
                  () {},
                )
              : widget.eventType == EventType.upcoming
                  ? AppPrimaryOutlineFullButton(
                      'Tampilkan QR',
                      () {},
                      prefixIcon: Icon(
                        Icons.qr_code,
                      ),
                    )
                  : SizedBox(),
        ),
      );
    }

    return Stack(
      children: [
        ListView(
          children: [
            header(),
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(),
                  const SizedBox(height: 8.0),
                  uploader(),
                  const SizedBox(height: 18.0),
                  description(),
                  const SizedBox(height: 18.0),
                  materialTitle(),
                  const SizedBox(height: 4.0),
                  ...listMaterial(),
                  const SizedBox(height: 24.0),
                  AppDividerSmall(),
                  const SizedBox(height: 24.0),
                  ...eventDetail(),
                  const SizedBox(height: 24.0),
                  AppDividerSmall(),
                  const SizedBox(height: 70.0),
                ],
              ),
            ),
          ],
        ),
        button(),
      ],
    );
  }
}
