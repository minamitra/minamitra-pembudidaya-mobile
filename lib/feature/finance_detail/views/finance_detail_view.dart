import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_income/view/detail_income_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/logic/finance_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/repositories/sample_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/production_cost_detail/view/production_cost_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinanceDetailView extends StatefulWidget {
  const FinanceDetailView(this.fishPondID, {super.key});

  final String fishPondID;

  @override
  State<FinanceDetailView> createState() => _FinanceDetailViewState();
}

class _FinanceDetailViewState extends State<FinanceDetailView> {
  @override
  Widget build(BuildContext context) {
    List<DoughnutSeries<ChartSampleData, String>> getDefaultDoughnutSeries(
      FinanceDetailState state,
    ) {
      final double totalAnotherCost = state.otherCost!.data!.isEmpty
          ? 0.0
          : state.otherCost!.data!
              .map((e) => double.parse(e.nominal ?? '0.0'))
              .reduce(
                (value, element) => value + element,
              );

      return <DoughnutSeries<ChartSampleData, String>>[
        DoughnutSeries<ChartSampleData, String>(
          explode: true,
          radius: '100%',
          innerRadius: '68%',
          explodeOffset: '8%',
          pointRenderMode: PointRenderMode.segment,
          groupMode: CircularChartGroupMode.value,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          selectionBehavior: SelectionBehavior(enable: true),
          // sortingOrder: SortingOrder.descending,
          legendIconType: LegendIconType.circle,
          cornerStyle: CornerStyle.bothFlat,
          // pointRadiusMapper: (datum, index) => '10%',

          dataSource: <ChartSampleData>[
            ChartSampleData(
              x: 'Pakan',
              y: state.data?.totalBiayaPakan ?? 0,
              text: appConvertCurrency(state.data?.totalBiayaPakan ?? 0),
            ),
            ChartSampleData(
              x: 'Perlakuan',
              y: state.data?.totalBiayaThreatment ?? 0,
              text: appConvertCurrency(state.data?.totalBiayaThreatment ?? 0),
            ),
            ChartSampleData(
              x: 'Benih/Bibit',
              y: state.data?.totalBiayaBenih ?? 0,
              text: appConvertCurrency(state.data?.totalBiayaBenih ?? 0),
            ),
            ChartSampleData(
              x: 'Biaya lainnya',
              y: totalAnotherCost,
              text: appConvertCurrency(totalAnotherCost),
            ),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
        ),
      ];
    }

    Widget buildDefaultDoughnutChart() {
      return BlocBuilder<FinanceDetailCubit, FinanceDetailState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return AppShimmer(
              MediaQuery.sizeOf(context).height * 0.4,
              double.infinity,
              1000.0,
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
            );
          }

          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: SfCircularChart(
              legend: const Legend(
                padding: 10.0,
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.bottom,
                alignment: ChartAlignment.center,
                orientation: LegendItemOrientation.horizontal,
                isResponsive: true,
              ),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Biaya',
                        textAlign: TextAlign.center,
                        style: appTextTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.neutral[500],
                            ),
                      ),
                      Text(
                        appConvertCurrency(
                          state.data?.totalBiayaProduksi?.toDouble() ?? 0.0,
                        ),
                        textAlign: TextAlign.center,
                        style: appTextTheme(context)
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
              series: getDefaultDoughnutSeries(state),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y%',
                builder: (
                  dynamic data,
                  ChartPoint<dynamic> point,
                  ChartSeries<dynamic, dynamic> series,
                  int x,
                  int y,
                ) {
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColor.neutralBlueGrey[800],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: AppBoxShadow().medium,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                color: AppColor.green[500],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              data.x.toString(),
                              style: appTextTheme(context).labelLarge?.copyWith(
                                    color: AppColor.neutral[400],
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${data.text} ',
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    Widget textRow(
      String title,
      String value, {
      bool isWithActionDetail = false,
      void Function()? onTap,
      Color? titleColor,
      FontWeight? titleFontWeight,
      Color? valueColor,
      FontWeight? valueFontWeight,
    }) {
      return InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: titleColor ?? AppColor.neutral[500],
                      fontWeight: titleFontWeight,
                    ),
              ),
            ),
            Text(
              value,
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: valueColor,
                    fontWeight: valueFontWeight ?? FontWeight.w500,
                  ),
              textAlign: TextAlign.end,
            ),
            if (isWithActionDetail) const SizedBox(width: 4.0),
            if (isWithActionDetail)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.0,
                color: AppColor.primary[500],
              ),
          ],
        ),
      );
    }

    Widget titleProductionCost() {
      return Row(
        children: [
          Expanded(
            child: Text(
              'Biaya Produksi',
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                  ),
            ),
          ),
          BlocBuilder<FinanceDetailCubit, FinanceDetailState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const AppShimmer(
                  35,
                  70,
                  1000.0,
                );
              }

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      ProductionCostDetailPage(
                        widget.fishPondID,
                        state.data!,
                        state.otherCost!,
                        state.cycleDetail!,
                      ),
                      ProductionCostDetailPage.routeSettings(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: AppColor.primary[50],
                  ),
                  child: Text(
                    'Detail',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.primary[500],
                        ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }

    Widget totalIncome() {
      return BlocBuilder<FinanceDetailCubit, FinanceDetailState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  DetailIncomePage(
                    state.data?.fishPondCycleID ?? '0',
                    state.data?.totalPendapatan?.toDouble() ?? 0.0,
                  ),
                  DetailIncomePage.route(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Pendapatan',
                              textAlign: TextAlign.start,
                              style: appTextTheme(context)
                                  .titleSmall
                                  ?.copyWith(color: AppColor.primary[500]),
                            ),
                            const SizedBox(width: 4.0),
                            Icon(
                              Icons.chevron_right,
                              size: 20.0,
                              color: AppColor.primary[500],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          appConvertCurrency(
                            state.data?.totalPendapatan?.toDouble() ?? 0.0,
                          ),
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    AppAssets.overviewRevenueIcon,
                    height: 34.0,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget bodyData() {
      return BlocBuilder<FinanceDetailCubit, FinanceDetailState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: AppColor.neutral[50],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                textRow(
                  'Siklus',
                  '${AppConvertDateTime().dmy(state.data?.periodeSiklusStart ?? DateTime.now())} - ${AppConvertDateTime().dmy(state.data?.periodeSiklusEnd ?? DateTime.now())}',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                textRow(
                  'HPP per ekor',
                  '${appConvertCurrency(state.data?.hppPerEkor ?? 0.0)}/ekor',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                textRow(
                  'HPP per kilogram',
                  '${appConvertCurrency(state.data?.hppPerKg ?? 0.0)}/kg',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                textRow(
                  'Laba/Rugi',
                  '${appConvertCurrency(state.data?.labaRugi?.toDouble() ?? 0.0)} (${state.data?.persentaseLabaRugi}%)',
                  titleColor: AppColor.black,
                  titleFontWeight: FontWeight.w700,
                  valueColor: AppColor.green[500],
                  valueFontWeight: FontWeight.w700,
                ),
              ],
            ),
          );
        },
      );
    }

    return AppRefresher(
      onRefresh: () {
        context.read<FinanceDetailCubit>().refresh();
      },
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          totalIncome(),
          Container(
            padding: const EdgeInsets.all(18.0),
            color: AppColor.white,
            child: Column(
              children: [
                titleProductionCost(),
                const SizedBox(height: 24.0),
                buildDefaultDoughnutChart(),
                const SizedBox(height: 24.0),
                bodyData(),
                const SizedBox(height: 64.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
