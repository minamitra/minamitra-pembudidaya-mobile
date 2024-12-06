import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/views/finance_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/finance_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/monitoring_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_header_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/line_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  final TextEditingController parameterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget itemValueFinanceItem({
      required String title,
      required String value,
      Color? color,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: appTextTheme(context).titleSmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ],
      );
    }

    Widget cardFinanceItem({
      bool isActive = true,
      required FinanceResponseData data,
    }) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAssets.cycleIcon,
                  height: 20.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    '${AppConvertDateTime().dmyName(data.periodeSiklusStart ?? DateTime.now())} - ${AppConvertDateTime().dmyName(data.periodeSiklusEnd ?? DateTime.now())}',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.primary[600],
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isActive ? AppColor.green[50] : AppColor.neutral[100],
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: isActive
                          ? AppColor.green[500]!
                          : AppColor.neutral[400]!,
                    ),
                  ),
                  child: Text(
                    isActive
                        ? data.status?.toLowerCase() == 'harvest'
                            ? 'Proses Panen'
                            : 'Berjalan'
                        : 'Selesai',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: isActive
                              ? AppColor.green[500]
                              : AppColor.neutral[400],
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            AppDividerSmall(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'HPP Per Kilogram',
                    value: appConvertCurrency(data.hppPerKg ?? 0.0),
                  ),
                ),
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'HPP Per Ekor',
                    value: appConvertCurrency(data.hppPerEkor ?? 0.0),
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'Biaya Produksi',
                    value: appConvertCurrency(
                      data.totalBiayaProduksi?.toDouble() ?? 0.0,
                    ),
                  ),
                ),
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'Laba/Rugi',
                    value: appConvertCurrency(data.labaRugi?.toDouble() ?? 0.0),
                    color: AppColor.green[500],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
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
        height: 100.0,
        width: MediaQuery.of(context).size.width * 0.725,
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
                ],
              ),
            ),
            Image.asset(
              imageAsset,
              height: 36.0,
              width: 36.0,
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
      return BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(
              200,
              double.infinity,
              8.0,
              margin: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 18.0,
              ),
            );
          }

          return Container(
            color: AppColor.neutral[100],
            child: Column(
              children: [
                const SizedBox(height: 18.0),
                BlocBuilder<FinanceCubit, FinanceState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const AppShimmer(
                        180,
                        double.infinity,
                        8.0,
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                      );
                    }

                    return SizedBox(
                      height: 225.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: financeHeaderDataWrapped(
                          totalProductionCost:
                              state.financeSummary?.data?.totalBiayaProduksi ??
                                  0.0,
                          totalRevenue:
                              state.financeSummary?.data?.totalPendapatan ??
                                  0.0,
                          hppPerHead:
                              state.financeSummary?.data?.hppPerEkor ?? 0.0,
                          totalProfitLoss:
                              state.financeSummary?.data?.labaRugi ?? 0.0,
                          hppPerKg: state.financeSummary?.data?.hppPerKg ?? 0.0,
                          totalProfitLossPercentage:
                              state.financeSummary?.data?.persentaseLabaRugi ??
                                  0.0,
                        ).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: financeHeaderDataWrapped(
                                          totalProductionCost: state
                                                  .financeSummary
                                                  ?.data
                                                  ?.totalBiayaProduksi ??
                                              0.0,
                                          totalRevenue: state.financeSummary
                                                  ?.data?.totalPendapatan ??
                                              0.0,
                                          hppPerHead: state.financeSummary?.data
                                                  ?.hppPerEkor ??
                                              0.0,
                                          totalProfitLoss: state.financeSummary
                                                  ?.data?.labaRugi ??
                                              0.0,
                                          hppPerKg: state.financeSummary?.data
                                                  ?.hppPerKg ??
                                              0.0,
                                          totalProfitLossPercentage: state
                                                  .financeSummary
                                                  ?.data
                                                  ?.persentaseLabaRugi ??
                                              0.0,
                                        ).length -
                                        1 ==
                                    index
                                ? const EdgeInsets.only(right: 18.0)
                                : EdgeInsets.zero,
                            child: wrappedHeaderItemData(
                              financeHeaderDataWrapped(
                                totalProductionCost: state.financeSummary?.data
                                        ?.totalBiayaProduksi ??
                                    0.0,
                                totalRevenue: state.financeSummary?.data
                                        ?.totalPendapatan ??
                                    0.0,
                                hppPerHead:
                                    state.financeSummary?.data?.hppPerEkor ??
                                        0.0,
                                totalProfitLoss:
                                    state.financeSummary?.data?.labaRugi ?? 0.0,
                                hppPerKg:
                                    state.financeSummary?.data?.hppPerKg ?? 0.0,
                                totalProfitLossPercentage: state.financeSummary
                                        ?.data?.persentaseLabaRugi ??
                                    0.0,
                              )[index],
                              true,
                              '5',
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

    Widget listData() {
      return BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppColor.neutral[100],
                  thickness: 18.0,
                );
              },
              itemBuilder: (context, index) {
                return const AppShimmer(
                  150,
                  double.infinity,
                  0,
                );
              },
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.finance?.data?.length ?? 0,
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColor.neutral[100],
                thickness: 18.0,
              );
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      FinanceDetailPage(
                        context.read<FinanceCubit>().fishPondID,
                        state.finance!.data![index],
                      ),
                      FinanceDetailPage.route(),
                    ),
                  );
                },
                child: cardFinanceItem(
                  isActive: state.finance?.data![index].status != 'done',
                  data: state.finance!.data![index],
                ),
              );
            },
          );
        },
      );
    }

    return AppRefresher(
      onRefresh: () {
        context.read<FinanceCubit>().refresh();
      },
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          headerData(),
          listData(),
          const SizedBox(height: 75.0),
        ],
      ),
    );
  }
}
