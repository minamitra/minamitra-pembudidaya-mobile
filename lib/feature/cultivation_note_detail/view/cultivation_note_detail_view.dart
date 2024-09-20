import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CultivationNoteDetailView extends StatefulWidget {
  const CultivationNoteDetailView({super.key});

  @override
  State<CultivationNoteDetailView> createState() =>
      _CultivationNoteDetailViewState();
}

class _CultivationNoteDetailViewState extends State<CultivationNoteDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            child: Image.asset(
              AppAssets.profileImageDummy,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jacob Jones",
                style: appTextTheme(context).titleSmall,
              ),
              const SizedBox(height: 4.0),
              Text(
                "Senin, 12 Sept 2024, 14:30",
                style: appTextTheme(context)
                    .labelLarge
                    ?.copyWith(color: AppColor.neutral[400]),
              )
            ],
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        header(),
        const SizedBox(height: 18.0),
        Text(
          "PIC: Margareth",
          style: appTextTheme(context).bodySmall,
        ),
        const SizedBox(height: 18.0),
        AppDividerSmall(),
        const SizedBox(height: 18.0),
        Text(
          "Pada tanggal 12 September 2024, dilakukan pengecekan kualitas air di Kolam 1. Ditemukan bahwa tingkat pH air menunjukkan fluktuasi yang cukup signifikan, dengan penurunan di bawah batas optimal. Kondisi ini dapat mempengaruhi kesehatan ikan, terutama dalam hal pertumbuhan dan daya tahan mereka terhadap penyakit. Setelah berkonsultasi dengan tim teknis, dilakukan penambahan buffer pH untuk menstabilkan kondisi air. Selain itu, pendamping merekomendasikan pemantauan harian untuk memastikan bahwa kondisi air tetap stabil dan tidak memburuk. Langkah selanjutnya adalah melakukan pengecekan lanjutan dalam 3 hari ke depan guna memastikan efektivitas dari penambahan buffer pH.",
          style: appTextTheme(context).bodySmall,
        ),
      ],
    );
  }
}
