import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    Text aboutMitra3M() {
      return Text(
        """Mitra3M adalah aplikasi inovatif yang dirancang khusus untuk mendukung peternak ikan dalam mengelola budidaya mereka secara lebih efektif dan efisien. Kami memahami bahwa industri perikanan membutuhkan solusi yang mudah diakses dan dapat membantu peternak dalam berbagai aspek budidaya, mulai dari pencatatan aktivitas harian hingga pemantauan kesehatan kolam dan hasil panen.

Dengan Mitra3M, kami ingin mempermudah proses ini dan membantu peternak meningkatkan produktivitas mereka melalui teknologi yang cerdas dan praktis.""",
        style: appTextTheme(context).titleSmall,
      );
    }

    List<Widget> ourTeam() {
      return [
        Text(
          "Tim Kami",
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.primary[600],
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12.0),
        Text(
          """Mitra3M didirikan oleh sekelompok individu yang berdedikasi di bidang perikanan dan teknologi. Kami percaya bahwa dengan memadukan pengalaman di lapangan dan kecanggihan teknologi, kami dapat membantu peternak mencapai potensi terbaik mereka.""",
          style: appTextTheme(context).titleSmall,
        )
      ];
    }

    List<Widget> vision() {
      return [
        Text(
          "Visi",
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.primary[600],
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12.0),
        Text(
          """Menjadi mitra terpercaya bagi para peternak dengan menyediakan platform teknologi yang memberdayakan dan meningkatkan kualitas budidaya ikan secara berkelanjutan.""",
          style: appTextTheme(context).titleSmall,
        )
      ];
    }

    Widget missionItem(String number, String text) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: appTextTheme(context).titleSmall,
          ),
          Expanded(
            child: Text(
              text,
              style: appTextTheme(context).titleSmall,
            ),
          )
        ],
      );
    }

    List<Widget> mission() {
      return [
        Text(
          "Mission",
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.primary[600],
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12.0),
        missionItem(
          "1. ",
          "Menyederhanakan proses budidaya melalui pencatatan dan pemantauan yang mudah digunakan.",
        ),
        const SizedBox(height: 18.0),
        missionItem(
          "2. ",
          "Meningkatkan produktivitas peternak dengan memberikan data dan analisis yang akurat tentang pertumbuhan ikan, pakan, dan kesehatan kolam.",
        ),
        const SizedBox(height: 18.0),
        missionItem(
          "3. ",
          "Menyediakan solusi berbasis data untuk membantu peternak membuat keputusan yang lebih baik dan cepat dalam pengelolaan kolam mereka.",
        ),
        const SizedBox(height: 18.0),
        missionItem(
          "4. ",
          "Menghubungkan peternak dengan ekosistem perikanan untuk mempermudah akses ke produk, layanan, dan informasi penting.",
        ),
      ];
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        aboutMitra3M(),
        const SizedBox(height: 36.0),
        ...ourTeam(),
        const SizedBox(height: 36.0),
        ...vision(),
        const SizedBox(height: 36.0),
        ...mission(),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
