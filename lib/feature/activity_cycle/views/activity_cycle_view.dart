import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/logic/activity_cycle_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/cycle_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/views/activity_cycle_add_harvest_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_detail/views/activity_cycle_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleView extends StatefulWidget {
  const ActivityCycleView(this.pondID, {super.key});
  final String pondID;

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
        padding: EdgeInsets.zero,
        labelColor: AppColor.primary,
        unselectedLabelColor: AppColor.neutral[400],
        labelStyle: appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
        unselectedLabelStyle:
            appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
        labelPadding: const EdgeInsets.all(0),
        isScrollable: false,
        tabs: const [
          Tab(text: 'Aktif'),
          Tab(text: 'Lelang'),
          Tab(text: 'Riwayat'),
        ],
      ),
    );
  }

  Widget bodyTab() {
    return BlocBuilder<ActivityCycleCubit, ActivityCycleState>(
      builder: (context, state) {
        return Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              state.status.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        listCard(
                          state.activeData?.data ?? [],
                          false,
                        ),
                        listCard(
                          state.readyHarvestData?.data ?? [],
                          true,
                        ),
                      ],
                    ),
              state.status.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : listCard(
                      state.harvestData?.data ?? [],
                      false,
                    ),
              state.status.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : listCard(
                      state.doneData?.data ?? [],
                      false,
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget itemCard({
    required FeedCycleHistoryResponseData data,
    required String dateTime,
    required String status,
    required String fishCount,
    required String fishWeight,
    required String fishWeightTarget,
  }) {
    Widget itemDataCard(
      String asset,
      String value,
    ) {
      return Row(
        children: [
          Image.asset(asset, height: 20.0),
          const SizedBox(width: 12.0),
          Text(value, style: appTextTheme(context).titleSmall),
        ],
      );
    }

    return InkWell(
      onTap: () {
        if (status != "harvest") {
          Navigator.of(context)
              .push(AppTransition.pushTransition(
            ActivityCycleDetailPage(
              data,
              isReadyHarvest: status == "ready",
            ),
            ActivityCycleDetailPage.routeSettings(),
          ))
              .then((value) {
            context.read<ActivityCycleCubit>().init(widget.pondID);
          });
        } else {
          // Navigate to edit panen
          Navigator.of(context)
              .push(AppTransition.pushTransition(
            ActivityCycleAddHarvestPage(
              data.id ?? "",
              data: data,
            ),
            ActivityCycleAddHarvestPage.routeSettings(),
          ))
              .then((value) {
            context.read<ActivityCycleCubit>().init(widget.pondID);
          });
        }
      },
      child: AppDefaultCard(
        backgroundCardColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateTime,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                    ),
                    // const SizedBox(height: 12.0),
                    // Text(
                    //   "${cycle.amount} kg",
                    //   style: appTextTheme(context).titleSmall!.copyWith(
                    //         color: AppColor.neutral[400],
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColor.neutral[400],
                    size: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            itemDataCard(
              AppAssets.newFishIcon,
              "$fishCount Ekor",
            ),
            const SizedBox(height: 12.0),
            itemDataCard(
              AppAssets.weigherIconFill,
              "$fishWeight gram/ekor",
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   cycle.price,
                //   style: appTextTheme(context).bodySmall!,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
                itemDataCard(
                  AppAssets.targetIconFill,
                  "$fishWeightTarget gram/ekor",
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: cycleTypeColor(convertToCycleType(status))
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: cycleTypeColor(convertToCycleType(status)),
                    ),
                  ),
                  child: Text(
                    cycleTypeToString(convertToCycleType(status)),
                    style: appTextTheme(context).titleSmall?.copyWith(
                          color: cycleTypeColor(convertToCycleType(status)),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listCard(
    List<FeedCycleHistoryResponseData>? data,
    bool isReadyHarvest,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: data?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return itemCard(
          data: data![index],
          dateTime: AppConvertDateTime()
              .ddmmyyyyhhmm(data[index].tebarDate ?? DateTime.now()),
          status: isReadyHarvest ? "ready" : (data[index].status ?? "active"),
          fishCount: data[index].tebarFishTotal ?? "Unknown",
          fishWeight: data[index].actualPanenBobot ?? "Unknown",
          fishWeightTarget: data[index].targetPanenBobot ?? "Unknown",
        );
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
