import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/views/activity_incident_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityIncidentView extends StatefulWidget {
  const ActivityIncidentView({super.key});

  @override
  State<ActivityIncidentView> createState() => _ActivityIncidentViewState();
}

class _ActivityIncidentViewState extends State<ActivityIncidentView> {
  Widget statusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColor.primary[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Menampilkan Kejadian dari ',
            textAlign: TextAlign.center,
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary,
                ),
          ),
          Text(
            '1 Jan - 07 Jan 2024',
            textAlign: TextAlign.center,
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.primary,
                ),
          ),
        ],
      ),
    );
  }

  Row rowText(String icon, String text) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 20.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: appTextTheme(context).bodySmall!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget itemCard() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(AppTransition.pushTransition(
          const ActivityIncidentDetailPage(),
          ActivityIncidentDetailPage.routeSettings(),
        ));
      },
      child: AppDefaultCard(
        backgroundCardColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serangan Hama',
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '12-08-2024 17:00 WIB',
              textAlign: TextAlign.start,
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.black[500],
                  ),
            ),
            Divider(
              color: AppColor.neutral[100],
              thickness: 1.0,
              height: 32,
            ),
            rowText(AppAssets.galleryIcon, '5 foto'),
            const SizedBox(height: 16.0),
            rowText(AppAssets.documentIcon,
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
          ],
        ),
      ),
    );
  }

  Widget listCard(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return itemCard();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        statusBar(context),
        const SizedBox(height: 16.0),
        listCard(context),
      ],
    );
  }
}
