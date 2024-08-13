import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_detail/views/activity_activities_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesView extends StatefulWidget {
  const ActivityActivitiesView({super.key});

  @override
  State<ActivityActivitiesView> createState() => _ActivityActivitiesViewState();
}

class _ActivityActivitiesViewState extends State<ActivityActivitiesView> {
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
          const ActivityActivitiesDetailPage(),
          ActivityActivitiesDetailPage.routeSettings(),
        ));
      },
      child: AppDefaultCard(
        backgroundCardColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pakan Pagi',
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '05-08-2024 17:00 WIB',
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
            rowText(AppAssets.weigherIcon, '100 gram'),
            const SizedBox(height: 16.0),
            rowText(AppAssets.priceTagIcon, 'Merk ABC'),
            const SizedBox(height: 16.0),
            rowText(AppAssets.documentIcon,
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: EasyDateTimeLine(
            activeColor: AppColor.primary,
            initialDate: DateTime.now(),
            locale: 'in_ID',
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            dayProps: EasyDayProps(
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
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
        ),
      ],
    );
  }
}
