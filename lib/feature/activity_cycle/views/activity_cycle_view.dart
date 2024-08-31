import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/cycle_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_detail/views/activity_cycle_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleView extends StatefulWidget {
  const ActivityCycleView({super.key});

  @override
  State<ActivityCycleView> createState() => _ActivityCycleViewState();
}

class _ActivityCycleViewState extends State<ActivityCycleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget tabBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: AppColor.neutral[50]),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColor.primary,
        indicatorWeight: 2.5,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        labelColor: AppColor.primary,
        unselectedLabelColor: AppColor.neutral[400],
        labelStyle: appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
        unselectedLabelStyle:
            appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(text: 'Semua'),
          Tab(text: 'Aktif'),
          Tab(text: 'Selesai'),
        ],
      ),
    );
  }

  Widget bodyTab() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          listCard(listCycleAll),
          listCard(listCycleActive),
          listCard(listCycleDone),
        ],
      ),
    );
  }

  Widget itemCard(Cycle cycle) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(AppTransition.pushTransition(
          ActivityCycleDetailPage(cycle),
          ActivityCycleDetailPage.routeSettings(),
        ));
      },
      child: AppDefaultCard(
        backgroundCardColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cycle.title,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      cycle.date,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).labelLarge?.copyWith(
                            color: AppColor.black[500],
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: cycleTypeColor(cycle.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: cycleTypeColor(cycle.type),
                    ),
                  ),
                  child: Text(
                    cycleTypeToString(cycle.type),
                    style: appTextTheme(context).titleSmall?.copyWith(
                          color: cycleTypeColor(cycle.type),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${cycle.amount} kg",
                  style: appTextTheme(context).bodySmall!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cycle.price,
                  style: appTextTheme(context).bodySmall!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listCard(List<Cycle> listCycle) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: listCycle.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return itemCard(listCycle[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tabBar(),
        const SizedBox(height: 8.0),
        bodyTab(),
      ],
    );
  }
}
