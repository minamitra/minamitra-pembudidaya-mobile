import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class WithdrawPointTab extends StatelessWidget {
  const WithdrawPointTab({super.key});

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return Row(
        children: [
          Expanded(child: AppSearchField()),
          const SizedBox(width: 20.0),
          Icon(
            Icons.shopping_bag_rounded,
            color: AppColor.primary[600],
          ),
        ],
      );
    }

    Widget listItem() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.product1Image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Super Patin",
                          style: appTextTheme(context)
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          "Pakan",
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(color: AppColor.neutral[400]),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "10 Poin",
                                style:
                                    appTextTheme(context).titleSmall?.copyWith(
                                          color: AppColor.accent[900],
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border:
                                    Border.all(color: AppColor.primary[500]!),
                              ),
                              child: Text(
                                "Tukar Poin",
                                style:
                                    appTextTheme(context).titleSmall?.copyWith(
                                          color: AppColor.primary[500],
                                          fontWeight: FontWeight.w700,
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
              const SizedBox(height: 18.0),
              AppDividerSmall(),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        searchField(),
        const SizedBox(height: 18.0),
        Expanded(child: listItem()),
      ],
    );
  }
}
