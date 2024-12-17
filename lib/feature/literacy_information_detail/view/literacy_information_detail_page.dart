import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LiteracyInformationDetailPage extends StatefulWidget {
  const LiteracyInformationDetailPage({super.key});

  static RouteSettings settings =
      const RouteSettings(name: '/literacy-information-detail-page');

  @override
  State<LiteracyInformationDetailPage> createState() =>
      _LiteracyInformationDetailPageState();
}

class _LiteracyInformationDetailPageState
    extends State<LiteracyInformationDetailPage> {
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
                Center(
                  child: Image.network(
                    'https://www.worldanimalprotection.ca/cdn-cgi/image/width=1280,format=auto/siteassets/shutterstock_1899421132.jpg',
                    height: 250.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
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

    Widget titleHeader(
      String title,
      String writer,
      String date,
    ) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                writer,
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary[600],
                    ),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.circle,
                color: AppColor.neutral[500],
                size: 2,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  date,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.neutral[500],
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
        ],
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            children: [
              titleHeader(
                'Cara Mengelola Kualitas Air untuk Hasil Panen Optimal',
                'Budi Santoso',
                '12 September 2024',
              ),
              Text(
                '''Kualitas air merupakan salah satu faktor krusial dalam budidaya ikan patin. Pengelolaan yang baik dapat mencegah terjadinya penyakit, mempercepat pertumbuhan ikan, dan meningkatkan hasil panen. Artikel ini akan mengulas langkah-langkah penting untuk menjaga kualitas air kolam secara optimal.''',
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall,
              ),
              const SizedBox(height: 18.0),
              Text(
                '''1. Menjaga pH Air
 Tingkat keasaman (pH) air harus berada pada kisaran yang sesuai untuk ikan patin, yaitu antara 6,5 hingga 8,0. pH yang terlalu rendah atau terlalu tinggi dapat menyebabkan stres pada ikan, yang pada akhirnya menghambat pertumbuhan. Gunakan alat ukur pH untuk memantau kualitas air secara berkala.

2. Mengontrol Suhu Air  Suhu air ideal untuk budidaya ikan patin berkisar antara 26°C hingga 30°C. Suhu yang terlalu rendah atau terlalu tinggi dapat mempengaruhi metabolisme dan daya tahan tubuh ikan. Pemasangan alat pengatur suhu (thermostat) dapat membantu menjaga suhu air kolam tetap stabil.

3. Meningkatkan Oksigen Terlarut
 Oksigen terlarut adalah faktor penting dalam menjaga kesehatan ikan. Gunakan aerator untuk memastikan pasokan oksigen yang cukup di dalam kolam, terutama saat padat tebar ikan tinggi atau cuaca sangat panas.

4. Mengelola Limbah dan Kualitas Air
 Sisa pakan dan kotoran ikan bisa mencemari air kolam dan menyebabkan amonia naik. Oleh karena itu, rutinlah membersihkan dasar kolam serta lakukan pergantian air sebagian (water exchange) secara teratur untuk menjaga kualitas air tetap baik.

Kesimpulan: Pengelolaan kualitas air yang baik dapat meningkatkan produktivitas budidaya ikan patin. Dengan menjaga pH, suhu, dan oksigen terlarut pada tingkat yang tepat, serta membersihkan kolam secara rutin, pembudidaya dapat memperoleh hasil panen yang optimal.''',
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
