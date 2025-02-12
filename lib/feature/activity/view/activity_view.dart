import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_lazy_load.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/resume_activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/activity_header_data_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/chart_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/view/add_bulk_feed_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final TextEditingController pondController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);
  final AppLazyLoad _lazyLoad = AppLazyLoad();
  final ScrollController headerHorizontalController = ScrollController();

  int page = 0;

  @override
  void initState() {
    super.initState();
    _lazyLoad.onListener(
      onLoadMore: () {
        if (context.read<ActivityCubit>().state.status.isLoadMore ||
            context.read<ActivityCubit>().state.status.isLoading) {
          return;
        } else {
          context.read<ActivityCubit>().loadMoreData();
        }
      },
    );
  }

  Function() bottomSheetShowModal(
    BuildContext context,
    String title,
    List<String> data,
  ) {
    return () {
      showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                title,
                height: MediaQuery.of(context).size.height * 0.5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: AppColor.neutral[100],
                              thickness: 1.0,
                              height: 0.0,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(data[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Text(
                                  data[index],
                                  textAlign: TextAlign.start,
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.black,
                                          ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then((value) {
        if (value != null) {
          if (value is String) {
            pondController.text = value;
            String pondId = context
                    .read<ResumeActivityCubit>()
                    .state
                    .fishpond
                    ?.firstWhere((element) => element.name == value)
                    .id ??
                '0';
            context.read<ResumeActivityCubit>().setDashboardWithPond(pondId);
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Widget chartSection() {
      return SizedBox(
        height: 260.0,
        child: Center(
          child: SfCircularChart(
            legend: const Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.wrap,
              isResponsive: true,
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              format: 'point.x : point.y %',
            ),
            series: <CircularSeries>[
              // Renders radial bar chart
              RadialBarSeries<ChartDummy, String>(
                dataSource: chartDummyData,
                xValueMapper: (ChartDummy data, _) => data.name,
                yValueMapper: (ChartDummy data, _) => data.value,
                legendIconType: LegendIconType.circle,
                cornerStyle: CornerStyle.endCurve,
                maximumValue: 100.0,
                name: 'Aktivitas',
                enableTooltip: true,
                dataLabelMapper: (ChartDummy data, _) => data.name,
              ),
            ],
          ),
        ),
      );
    }

    Widget dataItem(
      String title,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            style: appTextTheme(context).titleSmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            value,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      );
    }

    Widget data() {
      return Column(
        children: [
          dataItem('Total Plafon', 'Rp 120.000.000'),
          const SizedBox(height: 12.0),
          dataItem('Plafon Terpakai', 'Rp 50.000.000'),
          const SizedBox(height: 12.0),
          dataItem('Sisa Plafon', 'Rp 70.000.000'),
        ],
      );
    }

    Widget seeAllText() {
      return InkWell(
        onTap: () {},
        child: Text(
          'Selengkapnya',
          textAlign: TextAlign.center,
          style: appTextTheme(context).titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.primary[500],
              ),
        ),
      );
    }

    Widget activityItem({
      required String title,
      required String value,
      required String percentage,
      void Function()? onTap,
      required String pondStatus,
      required String imageAsset,
      required bool isLastStatusDone,
    }) {
      return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            Row(
              children: [
                Container(
                  width: 54.0,
                  height: 54.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.primary,
                    image: imageAsset.isEmpty
                        ? const DecorationImage(
                            image: AssetImage(AppAssets.dymmyActivityImage),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(imageAsset),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 2,
                              style: appTextTheme(context).titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            pondStatus.convertPondStatus(),
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: pondStatus.convertPondStatusColor(),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Icon(
                            Icons.assignment_turned_in_rounded,
                            color: AppColor.secondary[900],
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            isLastStatusDone ? '-' : '$value Kg',
                            style: appTextTheme(context).titleSmall?.copyWith(
                                  color: const Color(0xFF94A3B8),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          const SizedBox(width: 18.0),
                          Icon(
                            Icons.error,
                            color: AppColor.accent[900],
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            isLastStatusDone ? '-' : '$percentage Kg',
                            style: appTextTheme(context).titleSmall?.copyWith(
                                  color: const Color(0xFF94A3B8),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Text(
                //   percentage,
                //   style: appTextTheme(context).titleSmall?.copyWith(
                //         color: const Color(0xFF94A3B8),
                //         fontWeight: FontWeight.w500,
                //       ),
                // ),
                const SizedBox(width: 18.0),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            const Divider(
              color: Color(0xFFF3F6F9),
              height: 0,
              thickness: 1.0,
            ),
          ],
        ),
      );
    }

    Widget listActivityItem() {
      return BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const AppShimmer(
                  75,
                  double.infinity,
                  8.0,
                  margin: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 8.0,
                  ),
                );
              },
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.pondReponse?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: activityItem(
                  title: state.pondReponse?[index].name ?? '',
                  value: appConvert3Digits(
                    double.parse(
                          state.pondReponse?[index].totalFoodRecommendation
                                  .handleEmptyStringToZero() ??
                              '0.0',
                        ) /
                        1000,
                  ),
                  percentage: appConvert3Digits(
                    double.parse(
                          state.pondReponse?[index].totalFoodActual
                                  .handleEmptyStringToZero() ??
                              '0.0',
                        ) /
                        1000,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      AppTransition.pushTransition(
                        DetailActivityPage(
                          state.pondReponse![index],
                          isCanAccessFeature: state.pondReponse![index].status
                                  ?.isCanSeeDetail() ??
                              false,
                        ),
                        DetailActivityPage.routeSettings(),
                      ),
                    )
                        .then((value) {
                      if (value != null && value == 'refresh') {
                        context.read<ActivityCubit>().init();
                      }
                    });
                  },
                  pondStatus: state.pondReponse?[index].status ?? '',
                  imageAsset: state.pondReponse?[index].imageUrl ?? '',
                  isLastStatusDone: state
                          .pondReponse?[index].lastFishpondcycleStatus
                          ?.toLowerCase() ==
                      'done',
                ),
              );
            },
          );
        },
      );
    }

    Widget addButton() {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
            AppTransition.pushTransition(
              const AddPondPage(),
              AddPondPage.routeSettings(),
            ),
          )
              .then((value) {
            if (value != null && value is String) {
              if (value == 'refresh') {
                context.read<ActivityCubit>().init();
              }
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColor.primary[600]),
            const SizedBox(width: 8.0),
            Text(
              'Tambah Kolam',
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: AppColor.primary[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    }

    Widget headerItemData({
      required String title,
      required String value,
      required String imageAsset,
      required String allPondItemsLength,
      bool isShowingAllPonds = true,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(18.0),
        height: 120.0,
        width: MediaQuery.of(context).size.width * 0.64,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          color: AppColor.neutralBlueGrey[400],
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextTheme(context).headlineMedium,
                  ),
                  const Spacer(),
                  Text(
                    isShowingAllPonds
                        ? 'dari $allPondItemsLength kolam aktif'
                        : 'dari 1 kolam aktif',
                    style: appTextTheme(context)
                        .labelLarge
                        ?.copyWith(color: AppColor.neutralBlueGrey[400]),
                  ),
                ],
              ),
            ),
            Image.asset(
              imageAsset,
              height: 40.0,
              width: 40.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    }

    Widget wrappedHeaderItemData(
      ActivityHeaderDataWrapped data,
      bool isShowingAllPonds,
      String allPondItemsLength,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          headerItemData(
            title: data.listActivtyHeaderDataDummy[0].title,
            value: data.listActivtyHeaderDataDummy[0].value,
            imageAsset: data.listActivtyHeaderDataDummy[0].imageAsset,
            isShowingAllPonds: isShowingAllPonds,
            allPondItemsLength: allPondItemsLength,
          ),
          const SizedBox(height: 18.0),
          if (data.listActivtyHeaderDataDummy.length > 1)
            headerItemData(
              title: data.listActivtyHeaderDataDummy[1].title,
              value: data.listActivtyHeaderDataDummy[1].value,
              imageAsset: data.listActivtyHeaderDataDummy[1].imageAsset,
              isShowingAllPonds: isShowingAllPonds,
              allPondItemsLength: allPondItemsLength,
            ),
        ],
      );
    }

    Widget headerData() {
      return BlocBuilder<ResumeActivityCubit, ResumeActivityState>(
        builder: (context, state) {
          return Container(
            color: AppColor.neutral[100],
            child: Column(
              children: [
                const SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: state.status.isLoading
                      ? const AppShimmer(55, double.infinity, 8.0)
                      : AppValidatorTextField(
                          controller: pondController,
                          isMandatory: false,
                          withUpperLabel: false,
                          readOnly: true,
                          hintText: 'Semua kolam',
                          suffixWidget: const Padding(
                            padding: EdgeInsets.only(right: 18.0),
                            child: Icon(Icons.arrow_drop_down_rounded),
                          ),
                          suffixConstraints: const BoxConstraints(),
                          validator: (value) {
                            return null;
                          },
                          onTap: bottomSheetShowModal(
                            context,
                            'Pilih Kolam',
                            state.fishpond
                                    ?.map((element) => element.name ?? '-')
                                    .toList() ??
                                [],
                          ),
                        ),
                ),
                const SizedBox(height: 18.0),
                BlocConsumer<ResumeActivityCubit, ResumeActivityState>(
                  listener: (context, resumeState) async {
                    if (resumeState.status.isLoaded) {
                      await Future.delayed(const Duration(milliseconds: 400));
                      await headerHorizontalController.animateTo(
                        80.0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.linear,
                      );
                      await headerHorizontalController.animateTo(
                        -80.0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.linear,
                      );
                    }
                  },
                  builder: (context, resumeState) {
                    if (resumeState.status.isLoading) {
                      return const AppShimmer(
                        180,
                        double.infinity,
                        8.0,
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                      );
                    }

                    return SizedBox(
                      height: 258.0,
                      child: ListView.builder(
                        controller: headerHorizontalController,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: activityHeaderDataWrappedList(
                          biomassaValue: resumeState
                                  .pondDashboardResponse?.data?.totalBiomas ??
                              0.0,
                          srValue: resumeState.pondDashboardResponse?.data
                                  ?.avgSurvivalRate ??
                              0.0,
                          pakanValue: resumeState
                                  .pondDashboardResponse?.data?.totalFeeding ??
                              0.0,
                          estimasiJualValue: resumeState
                                  .pondDashboardResponse?.data?.totalCost ??
                              0.0,
                        ).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: activityHeaderDataWrappedList(
                                          biomassaValue: resumeState
                                                  .pondDashboardResponse
                                                  ?.data
                                                  ?.totalBiomas ??
                                              0.0,
                                          srValue: resumeState
                                                  .pondDashboardResponse
                                                  ?.data
                                                  ?.avgSurvivalRate ??
                                              0.0,
                                          pakanValue: resumeState
                                                  .pondDashboardResponse
                                                  ?.data
                                                  ?.totalFeeding ??
                                              0.0,
                                          estimasiJualValue: resumeState
                                                  .pondDashboardResponse
                                                  ?.data
                                                  ?.totalCost ??
                                              0.0,
                                        ).length -
                                        1 ==
                                    index
                                ? const EdgeInsets.only(right: 18.0)
                                : EdgeInsets.zero,
                            child: wrappedHeaderItemData(
                              activityHeaderDataWrappedList(
                                biomassaValue: resumeState.pondDashboardResponse
                                        ?.data?.totalBiomas ??
                                    0.0,
                                srValue: resumeState.pondDashboardResponse?.data
                                        ?.avgSurvivalRate ??
                                    0.0,
                                pakanValue: resumeState.pondDashboardResponse
                                        ?.data?.totalFeeding ??
                                    0.0,
                                estimasiJualValue: resumeState
                                        .pondDashboardResponse
                                        ?.data
                                        ?.totalCost ??
                                    0.0,
                              )[index],
                              (resumeState.selectedPondID ?? '0') == '0',
                              (resumeState.fishpond?.length ?? 1) == 1
                                  ? '0'
                                  : ((resumeState.fishpond?.length ?? 1) - 1)
                                      .toString(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 18.0),
              ],
            ),
          );
        },
      );
    }

    Widget addPond() {
      return BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.date_range_outlined,
                      color: AppColor.primary,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        AppConvertDateTime().edmy(DateTime.now()),
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    AppPrimaryGradientButton(
                      '+ Pakan',
                      () {
                        Navigator.of(context).push(
                          AppTransition.pushTransition(
                            AddBulkFeedPage(
                              state.pondReponse
                                      ?.map((element) => element.id)
                                      .toList()
                                      .join(',') ??
                                  '',
                            ),
                            AddBulkFeedPage.routeSettings(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                Divider(
                  color: AppColor.neutral[200],
                  thickness: 1.0,
                  height: 0.0,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget onLoadMore() {
      return BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          return AppLoadMoreWidget(status: state.status.isLoadMore);
        },
      );
    }

    return AppRefresher(
      onRefresh: () {
        context.read<ActivityCubit>().init();
      },
      child: ListView(
        controller: _lazyLoad.controller,
        children: [
          headerData(),
          addPond(),
          listActivityItem(),
          const SizedBox(height: 18.0),
          addButton(),
          onLoadMore(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
