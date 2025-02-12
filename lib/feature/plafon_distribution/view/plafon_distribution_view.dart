import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_double.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/logic/plafon_distribution_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/view/feed_tab/feed_tab_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PlafonDistributionView extends StatefulWidget {
  const PlafonDistributionView({super.key});

  @override
  State<PlafonDistributionView> createState() => _PlafonDistributionViewState();
}

class _PlafonDistributionViewState extends State<PlafonDistributionView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController pageController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    pageController.addListener(
      () {
        if (pageController.offset <=
            (pageController.position.maxScrollExtent - 75.0)) {
          context.read<PlafonDistributionCubit>().changeShowMore(true);
        } else {
          context.read<PlafonDistributionCubit>().changeShowMore(false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget filterDateSection() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.neutral[100],
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColor.neutral[200]!),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '12 Sep 2024 - 19 Sep 2024',
                  style: appTextTheme(context).bodySmall?.copyWith(),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColor.neutral[500],
              ),
            ],
          ),
        ),
      );
    }

    Widget balanceLegendItem(
      Color color,
      String pond,
      String balance,
      String percentage,
    ) {
      return Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '$pond ($percentage %)',
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.neutral[400],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            balance,
            style: appTextTheme(context)
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    List<Widget> linierIndicator(List<PlafonDistributionResponseData> data) {
      if (data.length > 3) {
        return [
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent: ((data[0].percentage ?? 0) +
                    (data[1].percentage ?? 0) +
                    context.read<PlafonDistributionCubit>().percentageOther) /
                100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.green[500],
            backgroundColor: AppColor.neutral[100],
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent:
                ((data[0].percentage ?? 0) + (data[1].percentage ?? 0)) / 100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.accent[900],
            backgroundColor: Colors.transparent,
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent: (data[0].percentage ?? 0) / 100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.primary[500],
            backgroundColor: Colors.transparent,
          ),
        ];
      } else {
        List<Widget> dataWidget = [];
        for (int index = data.length - 1; index >= 0; index--) {
          dataWidget = [
            ...dataWidget,
            LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              animation: true,
              lineHeight: 12.0,
              animationDuration: 1000,
              percent: index == 0
                  ? (data[0].percentage ?? 0) / 100
                  : index == 1
                      ? ((data[0].percentage ?? 0) / 100) +
                          ((data[1].percentage ?? 0) / 100)
                      : (((data[0].percentage ?? 0) / 100) +
                              ((data[1].percentage ?? 0) / 100) +
                              ((data[2].percentage ?? 0) / 100)) /
                          100,
              barRadius: const Radius.circular(8.0),
              progressColor: index == 0
                  ? AppColor.primary[500]
                  : index == 1
                      ? AppColor.accent[900]
                      : AppColor.green[500],
              backgroundColor: index == data.length - 1
                  ? AppColor.neutral[100]
                  : Colors.transparent,
            ),
          ];
        }
        return dataWidget;
      }
    }

    List<Widget> indicatorLegend(List<PlafonDistributionResponseData> data) {
      if (data.length > 3) {
        return [
          balanceLegendItem(
            AppColor.primary[500]!,
            data[0].name ?? '-',
            appConvertCurrency((data[0].sumCostNominal ?? 0).toDouble()),
            data[0].percentage.toString(),
          ),
          const SizedBox(height: 8.0),
          balanceLegendItem(
            AppColor.accent[900]!,
            data[1].name ?? '-',
            appConvertCurrency((data[1].sumCostNominal ?? 0).toDouble()),
            data[1].percentage.toString(),
          ),
          const SizedBox(height: 8.0),
          balanceLegendItem(
            AppColor.green[500]!,
            'Lainnya',
            appConvertCurrency(
              context
                  .read<PlafonDistributionCubit>()
                  .totalSumCostNominalOther
                  .toDouble(),
            ),
            context
                .read<PlafonDistributionCubit>()
                .percentageOther
                .toDouble()
                .toString(),
          ),
        ];
      } else {
        List<Widget> dataWidget = [];
        for (int index = 0; index < data.length; index++) {
          dataWidget.add(
            balanceLegendItem(
              index == 0
                  ? AppColor.primary[500]!
                  : index == 1
                      ? AppColor.accent[900]!
                      : AppColor.green[500]!,
              data[index].name ?? '-',
              appConvertCurrency((data[index].sumCostNominal ?? 0).toDouble()),
              data[index].percentage.toString(),
            ),
          );
          dataWidget.add(const SizedBox(height: 8.0));
        }
        return dataWidget;
      }
    }

    Widget chartData() {
      return BlocBuilder<PlafonDistributionCubit, PlafonDistributionState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distribusi Plafon',
                  style: appTextTheme(context).titleSmall,
                ),
                const SizedBox(height: 8.0),
                state.status.isLoading
                    ? const AppShimmer(
                        24.0,
                        75.0,
                        4.0,
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            appConvertCurrency(
                              (state.plafonSummaryResponse?.data?.totalCost ??
                                      0)
                                  .toDouble(),
                            ),
                            style: appTextTheme(context).bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'dari ${appConvertCurrency(
                              (state.plafonSummaryResponse?.data?.totalPlafon ??
                                      0)
                                  .toDouble(),
                            )}',
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  color: AppColor.neutral[400],
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                const SizedBox(height: 8.0),
                state.status.isLoading
                    ? const AppShimmer(
                        12.0,
                        double.infinity,
                        8.0,
                      )
                    : SizedBox(
                        height: 12.0,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ...linierIndicator(
                              state.plafonDistributionResponse?.data ?? [],
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 24.0),
                if (state.status.isLoading)
                  const AppShimmer(
                    150.0,
                    double.infinity,
                    8.0,
                  ),
                if (state.status.isLoaded)
                  ...indicatorLegend(
                    state.plafonDistributionResponse?.data ?? [],
                  ),
              ],
            ),
          );
        },
      );
    }

    Widget selectPondSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Detail Penggunaan',
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            BlocBuilder<PlafonDistributionCubit, PlafonDistributionState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const AppShimmer(
                    24.0,
                    50.0,
                    8.0,
                  );
                }

                return InkWell(
                  onTap: (state.plafonDistributionResponse?.data?.isEmpty ??
                          true)
                      ? () {
                          AppTopSnackBar(context).showInfo('Tidak ada kolam');
                        }
                      : appBottomSheetShowModal(
                          context,
                          'Pilih Kolam',
                          state.plafonDistributionResponse!.data!
                              .map((element) => element.name ?? '-')
                              .toList(),
                          (value) {
                            context
                                .read<PlafonDistributionCubit>()
                                .onChangeDetailUse(value);
                          },
                        ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColor.neutral[200]!),
                    ),
                    child: Row(
                      children: [
                        Text(
                          state.selectedPond,
                          style: appTextTheme(context).bodySmall,
                        ),
                        const SizedBox(width: 8.0),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColor.neutral[500],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget summaryItem(
      String title,
      String percentage,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(width: 4.0),
          Text(
            percentage,
            style: appTextTheme(context).labelLarge?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: appTextTheme(context).titleSmall,
          ),
        ],
      );
    }

    Widget summarySection() {
      return BlocBuilder<PlafonDistributionCubit, PlafonDistributionState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(
              200.0,
              double.infinity,
              16.0,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: AppColor.neutral[50],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColor.neutral[200]!),
            ),
            child: Column(
              children: [
                summaryItem(
                  'Pakan',
                  '${state.plafonUseSummaryResponse?.data?.feedingCost?.percentage?.toDouble() ?? '0'} %',
                  appConvertCurrency(
                    state.plafonUseSummaryResponse?.data?.feedingCost
                            ?.costNominal
                            ?.toDouble() ??
                        0.0,
                  ),
                ),
                const SizedBox(height: 18.0),
                summaryItem(
                  'Perlakuan',
                  '${state.plafonUseSummaryResponse?.data?.treatmentCost?.percentage?.toDouble() ?? '0'} %',
                  appConvertCurrency(
                    state.plafonUseSummaryResponse?.data?.treatmentCost
                            ?.costNominal
                            ?.toDouble() ??
                        0.0,
                  ),
                ),
                const SizedBox(height: 18.0),
                summaryItem(
                  'Bibit/Benih',
                  '${state.plafonUseSummaryResponse?.data?.seedCost?.percentage?.toDouble() ?? '0'} %',
                  appConvertCurrency(
                    state.plafonUseSummaryResponse?.data?.seedCost?.costNominal
                            ?.toDouble() ??
                        0.0,
                  ),
                ),
                const SizedBox(height: 18.0),
                summaryItem(
                  'Lainnya',
                  '${state.plafonUseSummaryResponse?.data?.otherCost?.percentage?.toDouble() ?? '0'} %',
                  appConvertCurrency(
                    state.plafonUseSummaryResponse?.data?.otherCost?.costNominal
                            ?.toDouble() ??
                        0.0,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget feedTabItem(
      String title,
      String time,
      String value,
    ) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextTheme(context).titleSmall,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      time,
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18.0),
              Text(
                '- $value',
                style: appTextTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColor.accent[900]),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    Widget historyData() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: AppColor.neutral[50]),
              child: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.start,
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
                labelPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Pakan'),
                  Tab(text: 'Perlakuan'),
                  Tab(text: 'Bibit/Benih'),
                  Tab(text: 'Lainnya'),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<PlafonDistributionCubit, PlafonDistributionState>(
                builder: (context, state) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      state.status.isLoading
                          ? const AppShimmer(
                              150.0,
                              double.infinity,
                              8.0,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: state.plafonFeedUseResponse?.data.data
                                          ?.isEmpty ??
                                      true
                                  ? const AppEmptyData(
                                      'Tidak ada data',
                                      isCenter: true,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: state.plafonFeedUseResponse
                                          ?.data.data?.length,
                                      itemBuilder: (context, index) {
                                        return feedTabItem(
                                          state.plafonFeedUseResponse?.data
                                                  .data?[index].fishfoodName ??
                                              '-',
                                          AppConvertDateTime().dmyName(
                                            state.plafonFeedUseResponse?.data
                                                    .data?[index].datetime ??
                                                DateTime.now(),
                                          ),
                                          appConvertCurrency(
                                            (state
                                                        .plafonFeedUseResponse
                                                        ?.data
                                                        .data?[index]
                                                        .fishfoodPrice ??
                                                    0)
                                                .toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                      state.status.isLoading
                          ? const AppShimmer(
                              150.0,
                              double.infinity,
                              8.0,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: state.plafonTreatmentUseResponse?.data.data
                                          ?.isEmpty ??
                                      true
                                  ? const AppEmptyData(
                                      'Tidak ada data',
                                      isCenter: true,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: state
                                          .plafonTreatmentUseResponse
                                          ?.data
                                          .data
                                          ?.length,
                                      itemBuilder: (context, index) {
                                        return feedTabItem(
                                          state.plafonTreatmentUseResponse?.data
                                                  .data?[index].name ??
                                              '-',
                                          AppConvertDateTime().dmyName(
                                            state
                                                    .plafonTreatmentUseResponse
                                                    ?.data
                                                    .data?[index]
                                                    .datetime ??
                                                DateTime.now(),
                                          ),
                                          appConvertCurrency(
                                            (state.plafonTreatmentUseResponse?.data
                                                        .data?[index].cost ??
                                                    0)
                                                .toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                      state.status.isLoading
                          ? const AppShimmer(
                              150.0,
                              double.infinity,
                              8.0,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: state.plafonSeedUseResponse?.data.data
                                          ?.isEmpty ??
                                      true
                                  ? const AppEmptyData(
                                      'Tidak ada data',
                                      isCenter: true,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: state.plafonSeedUseResponse
                                          ?.data.data?.length,
                                      itemBuilder: (context, index) {
                                        return feedTabItem(
                                          state.plafonSeedUseResponse?.data
                                                  .data?[index].fishseedName ??
                                              '-',
                                          AppConvertDateTime().dmyName(
                                            state.plafonSeedUseResponse?.data
                                                    .data?[index].tebarDate ??
                                                DateTime.now(),
                                          ),
                                          appConvertCurrency(
                                            (state.plafonSeedUseResponse?.data
                                                        .data?[index].cost ??
                                                    0)
                                                .toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                      state.status.isLoading
                          ? const AppShimmer(
                              150.0,
                              double.infinity,
                              8.0,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: state.plafonAnotherUseResponse?.data.data
                                          ?.isEmpty ??
                                      true
                                  ? const AppEmptyData(
                                      'Tidak ada data',
                                      isCenter: true,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: state.plafonAnotherUseResponse
                                          ?.data.data?.length,
                                      itemBuilder: (context, index) {
                                        return feedTabItem(
                                          state.plafonAnotherUseResponse?.data
                                                  .data?[index].type ??
                                              '-',
                                          AppConvertDateTime().dmyName(
                                            state.plafonAnotherUseResponse?.data
                                                    .data?[index].date ??
                                                DateTime.now(),
                                          ),
                                          appConvertCurrency(
                                            (state.plafonAnotherUseResponse?.data
                                                        .data?[index].cost ??
                                                    0)
                                                .toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget distributionBody() {
      return ListView(
        controller: pageController,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          chartData(),
          const SizedBox(height: 18.0),
          AppDividerLarge(),
          const SizedBox(height: 18.0),
          selectPondSection(),
          const SizedBox(height: 18.0),
          summarySection(),
          const SizedBox(height: 18.0),
          historyData(),
        ],
      );
    }

    Widget showMore() {
      return BlocBuilder<PlafonDistributionCubit, PlafonDistributionState>(
        builder: (context, state) {
          return AppAnimatedSize(
            isShow: state.showingShowMore,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  pageController.animateTo(
                    pageController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  margin: const EdgeInsets.only(bottom: 18.0),
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: AppColor.primary[500]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        AppAssets.downLottie,
                        height: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Lihat lebih banyak',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.primary[500],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        // filterDateSection(),
        distributionBody(),
        showMore(),
      ],
    );
  }
}
