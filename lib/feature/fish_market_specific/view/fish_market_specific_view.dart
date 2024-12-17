import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market_detail/view/fish_market_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class FishMarketSpecificView extends StatefulWidget {
  const FishMarketSpecificView({super.key});

  @override
  State<FishMarketSpecificView> createState() => _FishMarketSpecificViewState();
}

class _FishMarketSpecificViewState extends State<FishMarketSpecificView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width / 2.27;
    log(width.toString());

    Widget marketItem(
      String date,
      String title,
      String value, {
      bool isFirstItem = false,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: width - 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColor.primary[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            date,
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColor.neutral[400],
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.neutral[600],
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.accent[900],
                ),
          ),
        ],
      );
    }

    return ListView(
      children: [
        const SizedBox(height: 18.0),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: width / (width + 42.0),
          ),
          itemCount: 18,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  AppTransition.pushTransition(
                    const FishMarketDetailPage(),
                    FishMarketDetailPage.route,
                  ),
                );
              },
              child: marketItem(
                '21 Sept 2024, 11:30',
                'Patin 800gr',
                'Rp 190.000',
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
