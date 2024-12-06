import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/view/event_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    Widget location() {
      return Container(
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
      );
    }

    Widget eventItem() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: AppColor.primary[100],
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppAssets.dummyEventListImage,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Workshop Pemilihan Pakan Tepat untuk Setiap Tahap Siklus Budidaya Patin',
                    maxLines: 2,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 14.0,
                        color: AppColor.neutral[400],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Senin, 19 Nov 2024',
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.neutral[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14.0,
                        color: AppColor.neutral[400],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '13:00 - Selesai',
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.neutral[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.0,
                        color: AppColor.neutral[400],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Kantor Solusi3M Cabang OKU Timur',
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.neutral[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        location(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      const EventDetailPage(),
                      EventDetailPage.routeSettings(),
                    ),
                  );
                },
                child: eventItem(),
              );
            },
          ),
        ),
      ],
    );
  }
}
