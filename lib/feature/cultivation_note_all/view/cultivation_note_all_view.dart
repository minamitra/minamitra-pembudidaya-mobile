import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_chip.dart';

class CultivationNoteAllView extends StatefulWidget {
  const CultivationNoteAllView({super.key});

  @override
  State<CultivationNoteAllView> createState() => _CultivationNoteAllViewState();
}

class _CultivationNoteAllViewState extends State<CultivationNoteAllView> {
  @override
  Widget build(BuildContext context) {
    Widget filterSection() {
      return Container(
        color: AppColor.neutral[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: AppColor.neutral[200]!),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "12 Sep 2024 - 19 Sep 2024",
                              style: appTextTheme(context).bodySmall,
                            ),
                          ),
                          Icon(
                            Icons.date_range_outlined,
                            color: AppColor.neutral[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                      color: AppColor.primary[600],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 33.0,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(width: 18.0),
                  AppWidgetSecondaryChip(
                    text: "Semua (10)",
                    onTap: () {},
                  ),
                  const SizedBox(width: 16.0),
                  AppWidgetSecondaryChip(
                    text: "Belum Dibaca",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget itemNote() {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                child: Image.asset(
                  AppAssets.profileImageDummy,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
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
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: AppColor.secondary[50],
                  border: Border.all(color: AppColor.secondary[900]!),
                ),
                child: Text(
                  "Baru",
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.secondary[900],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            "Pada tanggal 12 September 2024, dilakukan pengecekan kualitas air di Kolam 1. Ditemukan bahwa tingkat pH air menunjukkan fluktuasi yang cukup signifikan, dengan penurunan di bawah batas optimal. Kondisi ini dapat mempengaruhi kesehatan ikan, terutama dalam hal pertumbuhan dan daya tahan mereka terhadap penyakit. Setelah berkonsultasi dengan tim teknis, dilakukan penambahan buffer pH untuk menstabilkan kondisi air. Selain itu, pendamping merekomendasikan pemantauan harian untuk memastikan bahwa kondisi air tetap stabil dan tidak memburuk. Langkah selanjutnya adalah melakukan pengecekan lanjutan dalam 3 hari ke depan guna memastikan efektivitas dari penambahan buffer pH.",
            maxLines: 3,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    Widget listNotes() {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const CultivationNoteDetailPage(),
                CultivationNoteDetailPage.routeSettings,
              ));
            },
            child: itemNote(),
          );
        },
      );
    }

    return Column(
      children: [
        filterSection(),
        Expanded(child: listNotes()),
      ],
    );
  }
}
