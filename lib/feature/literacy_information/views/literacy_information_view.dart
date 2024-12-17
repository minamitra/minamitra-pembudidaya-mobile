import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/view/literacy_information_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LiteracyInformationView extends StatefulWidget {
  const LiteracyInformationView({super.key});

  @override
  State<LiteracyInformationView> createState() =>
      _LiteracyInformationViewState();
}

class _LiteracyInformationViewState extends State<LiteracyInformationView> {
  @override
  Widget build(BuildContext context) {
    Widget item(
      String imageUrl,
      String title,
      String description,
      String writer,
      String date,
    ) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            AppTransition.pushTransition(
              const LiteracyInformationDetailPage(),
              LiteracyInformationDetailPage.settings,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error,
                      color: AppColor.red[500],
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const AppShimmer(
                      100.0,
                      100.0,
                      8.0,
                    );
                  },
                ),
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: SizedBox(
                  height: 110.0,
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          description,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: appTextTheme(context)
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Row(
                        children: [
                          Text(
                            writer,
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.neutral[500],
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(
                            Icons.circle,
                            size: 2.0,
                            color: AppColor.neutral[500],
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              date,
                              textAlign: TextAlign.start,
                              style: appTextTheme(context).labelLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.neutral[500],
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: AppDividerSmall(),
        );
      },
      itemBuilder: (context, index) {
        return item(
          'https://www.worldanimalprotection.ca/cdn-cgi/image/width=1280,format=auto/siteassets/shutterstock_1899421132.jpg',
          'Cara Mengelola Kualitas Air untuk Hasil Panen Optimal',
          'Kualitas air merupakan faktor penting dalam budidaya ikan patin. Dalam artikel ini, kami akan membahas cara menjaga tingkat pH, suhu, dan oksigen yang optimal untuk meningkatkan produktivitas kolam.',
          'Budi Santoso',
          '12 Sept 2024',
        );
      },
    );
  }
}
