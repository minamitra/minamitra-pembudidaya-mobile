import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class SamplingView extends StatefulWidget {
  const SamplingView({super.key});

  @override
  State<SamplingView> createState() => _SamplingViewState();
}

class _SamplingViewState extends State<SamplingView> {
  @override
  Widget build(BuildContext context) {
    Widget itemCard() {
      return InkWell(
        onTap: () {
          // Navigator.of(context).push(AppTransition.pushTransition(
          //   const ActivityActivitiesDetailPage(),
          //   ActivityActivitiesDetailPage.routeSettings(),
          // ));
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MBW 100 Gram',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '05-08-2024 17:00 WIB',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: AppColor.black[500],
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.delete_outline_rounded,
                    color: AppColor.neutral[400],
                  )
                ],
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Image.asset(AppAssets.rupiahIcon, height: 20.0),
                  const SizedBox(width: 12.0),
                  Text("SR: 90%", style: appTextTheme(context).titleSmall),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 16.0,
        ),
        color: AppColor.neutralBlueGrey[50],
        child: Text(
          "Hari ini",
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.neutral[400],
              ),
        ),
      ),
      itemBuilder: (context, index) {
        return itemCard();
      },
    );
  }
}
