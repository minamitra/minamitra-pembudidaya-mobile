import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market_detail/view/fish_market_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market_specific/view/fish_market_specific_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/search_sub_district/view/search_sub_district_view.dart';

class FishMarketView extends StatefulWidget {
  const FishMarketView({super.key});

  @override
  State<FishMarketView> createState() => _FishMarketViewState();
}

class _FishMarketViewState extends State<FishMarketView> {
  @override
  Widget build(BuildContext context) {
    Widget location() {
      return showSearchWidget(
        context: context,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 18.0,
          ),
          color: AppColor.primary[700],
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColor.primary[400],
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  'Sumatera Selatan',
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(color: AppColor.primary[100]),
                ),
              ),
              const SizedBox(width: 12.0),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.primary[400],
              ),
            ],
          ),
        ),
      );
    }

    Widget marketItem({bool isFirst = false}) {
      return Padding(
        padding: EdgeInsets.only(
          left: isFirst ? 18.0 : 0.0,
          right: 12.0,
        ),
        child: SizedBox(
          width: (MediaQuery.sizeOf(context).width / 2.8) + 20.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).width / 2.8,
                width: (MediaQuery.sizeOf(context).width / 2.8) + 20.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColor.primary,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://www.worldanimalprotection.ca/cdn-cgi/image/width=1280,format=auto/siteassets/shutterstock_1899421132.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '21 Sept 2024, 11:30',
                textAlign: TextAlign.start,
                style: appTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.neutral[400],
                    ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Patin 800gr',
                textAlign: TextAlign.start,
                style: appTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.neutral[600],
                    ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Rp 190.000',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.accent[900],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    Widget market(
      String marketName,
      String distance,
    ) {
      return Column(
        children: [
          const SizedBox(height: 14.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    marketName,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  distance,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.primary[500]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          SizedBox(
            width: double.infinity,
            height: (MediaQuery.sizeOf(context).width / 2.8) + 80.0,
            child: ListView.builder(
              itemCount: 6,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 5) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        AppTransition.pushTransition(
                          const FishMarketSpecificPage(),
                          FishMarketSpecificPage.route,
                        ),
                      );
                    },
                    child: Container(
                      height: (MediaQuery.sizeOf(context).width / 2.8) + 80.0,
                      width: (MediaQuery.sizeOf(context).width / 2.8) + 20.0,
                      margin: const EdgeInsets.only(right: 18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColor.white,
                        border: Border.all(color: AppColor.neutral[100]!),
                        boxShadow: AppBoxShadow().normal,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lihat Semua',
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).titleSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.primary[500],
                                ),
                          ),
                          const SizedBox(height: 12.0),
                          Icon(
                            Icons.arrow_circle_right_rounded,
                            color: AppColor.primary[500],
                            size: 26.0,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        const FishMarketDetailPage(),
                        FishMarketDetailPage.route,
                      ),
                    );
                  },
                  child: marketItem(isFirst: index == 0),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget listMarket() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          market('Pasar Ikan Palembang', '1.2 km'),
          const SizedBox(height: 18.0),
          AppDivider(
            thickness: 12.0,
            color: AppColor.neutral[100],
          ),
          const SizedBox(height: 18.0),
          market('Pasar Ikan Palembang', '1.2 km'),
          const SizedBox(height: 18.0),
          AppDivider(
            thickness: 12.0,
            color: AppColor.neutral[100],
          ),
        ],
      );
    }

    return Column(
      children: [
        location(),
        Expanded(child: listMarket()),
      ],
    );
  }
}
