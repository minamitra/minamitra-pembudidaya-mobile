import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/repositories/event_type.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/view/event_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class EventHistoryView extends StatefulWidget {
  const EventHistoryView({super.key});

  @override
  State<EventHistoryView> createState() => _EventHistoryViewState();
}

class _EventHistoryViewState extends State<EventHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar() {
      return Container(
        height: 60,
        decoration: const BoxDecoration(color: AppColor.white),
        child: TabBar(
          controller: tabController,
          dividerColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColor.primary,
          indicatorWeight: 2.5,
          padding: EdgeInsets.zero,
          labelColor: AppColor.primary,
          unselectedLabelColor: AppColor.neutral[400],
          labelStyle:
              appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
          unselectedLabelStyle:
              appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
          labelPadding: const EdgeInsets.all(0),
          isScrollable: false,
          tabs: const [
            Tab(text: 'Akan Datang'),
            Tab(text: 'Selesai'),
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

    Widget upCommingEvent() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const EventDetailPage(eventType: EventType.upcoming),
                  EventDetailPage.routeSettings(),
                ),
              );
            },
            child: eventItem(),
          );
        },
      );
    }

    Widget bodyTab() {
      return TabBarView(
        controller: tabController,
        children: [
          upCommingEvent(),
          const AppEmptyData(
            'Data tidak ditemukan',
            isCenter: true,
            descriptions: 'Silahkan daftar acara terlebih dahulu',
          ),
        ],
      );
    }

    return Column(
      children: [
        tabBar(),
        Expanded(child: bodyTab()),
      ],
    );
  }
}
