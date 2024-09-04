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
            Row(
              children: [
                Column(
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
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.delete_outline_rounded,
                  color: AppColor.neutral[400],
                )
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 8.0,
                //     vertical: 4.0,
                //   ),
                //   decoration: BoxDecoration(
                //     color: AppColor.primary[50],
                //     borderRadius: BorderRadius.circular(4.0),
                //     border: Border.all(
                //       color: AppColor.secondary[900]!,
                //     ),
                //   ),
                //   child: Text(
                //     'Aktual',
                //     style: appTextTheme(context).titleSmall?.copyWith(
                //           color: AppColor.secondary[900]!,
                //         ),
                //   ),
                // ),
              ],
            ),
            // Divider(
            //   color: AppColor.neutral[100],
            //   thickness: 1.0,
            //   height: 32,
            // ),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Image.asset(AppAssets.weigherIcon, height: 20.0),
                const SizedBox(width: 12.0),
                Text("500 Gram", style: appTextTheme(context).titleSmall),
              ],
            ),
            // Text(
            //   "Merk ABC [1000 gram]",
            //   style: appTextTheme(context).bodySmall!,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            // const SizedBox(height: 8.0),
            // Text(
            //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            //   style: appTextTheme(context).bodySmall!,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }

  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: EasyDateTimeLine(
        activeColor: AppColor.primary,
        initialDate: DateTime.now(),
        locale: 'in_ID',
        onDateChange: (selectedDate) {
          //`selectedDate` the new date selected.
        },
        headerProps: const EasyHeaderProps(
          dateFormatter: DateFormatter.monthOnly(),
        ),
        dayProps: EasyDayProps(
          height: 76,
          dayStructure: DayStructure.dayNumDayStr,
          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget listCard() {
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
        calendar(),
        const SizedBox(height: 16.0),
        listCard(),
      ],
    );
  }
}
