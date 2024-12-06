import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/view/add_another_finance_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/production_cost_detail/logic/production_cost_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ProductionCostDetailView extends StatefulWidget {
  const ProductionCostDetailView(
    this.fishPondID,
    this.financeResponseData,
    this.cycleDetail, {
    super.key,
  });

  final String fishPondID;
  final FinanceResponseData financeResponseData;
  final FeedCycleHistoryResponseData cycleDetail;

  @override
  State<ProductionCostDetailView> createState() =>
      _ProductionCostDetailViewState();
}

class _ProductionCostDetailViewState extends State<ProductionCostDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget summaryCard() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.red[400],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.red[400]!.withOpacity(0.24),
              blurRadius: 24.0,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Biaya Produksi',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.red[200],
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  BlocBuilder<ProductionCostDetailCubit,
                      ProductionCostDetailState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const AppShimmer(
                          24.0,
                          150.0,
                          4.0,
                        );
                      }
                      return Text(
                        appConvertCurrency(
                          state.financeResponseData?.totalBiayaProduksi
                                  ?.toDouble() ??
                              0.0,
                        ),
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Image.asset(
              AppAssets.productionCostSummaryIcon,
              height: 40.0,
              width: 40.0,
            ),
          ],
        ),
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

    Widget staticCost() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            textRow(
              'Pakan',
              appConvertCurrency(
                widget.financeResponseData.totalBiayaPakan ?? 0,
              ),
            ),
            Divider(
              height: 32.0,
              thickness: 1,
              color: AppColor.neutral[100],
            ),
            textRow(
              'Benih bibit',
              appConvertCurrency(
                widget.financeResponseData.totalBiayaBenih ?? 0,
              ),
            ),
            Divider(
              height: 32.0,
              thickness: 1,
              color: AppColor.neutral[100],
            ),
            textRow(
              'Perlakuan',
              appConvertCurrency(
                widget.financeResponseData.totalBiayaThreatment ?? 0,
              ),
            ),
          ],
        ),
      );
    }

    Widget anotherCostTitle() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'Biaya Lainnya',
          textAlign: TextAlign.start,
          style: appTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
        ),
      );
    }

    Widget anotherCostItem(FishpondCycleCostResponseData data) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppConvertDateTime().dmyName(data.date ?? DateTime.now()),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(color: AppColor.primary[600]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      AppTransition.pushTransition(
                        AddAnotherFinancePage(
                          isRequiredCycleID: false,
                          fishPondID: widget.fishPondID,
                          fishPondCycleID:
                              widget.financeResponseData.fishPondCycleID,
                          otherCostData: data,
                          tebarDate:
                              widget.cycleDetail.tebarDate ?? DateTime.now(),
                        ),
                        AddAnotherFinancePage.route(),
                      ),
                    )
                        .then((value) {
                      if (value == 'refresh') {
                        context.read<ProductionCostDetailCubit>().refresh();
                      }
                    });
                  },
                  child: Icon(
                    Icons.edit_rounded,
                    color: AppColor.neutralBlueGrey[400],
                    size: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              height: 32.0,
              thickness: 1,
              color: AppColor.neutral[100],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.type.handlingEmptyString(),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall,
                  ),
                ),
                Text(
                  appConvertCurrency(double.parse(data.nominal ?? '0.0')),
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Text(
              data.note.handlingEmptyString(),
              textAlign: TextAlign.start,
              style: appTextTheme(context).bodySmall,
            ),
            const SizedBox(height: 18.0),
            ...List.generate(
              data.attachmentJsonArray?.length ?? 0,
              (index) {
                return InkWell(
                  onTap: () {
                    showImageViewer(
                      context,
                      Image.network(data.attachmentJsonArray?[index] ?? '')
                          .image,
                      immersive: false,
                      useSafeArea: true,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      backgroundColor: Colors.black.withOpacity(0.7),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppColor.primary[50]!,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: AppColor.primary[50],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                          ),
                          child: Icon(
                            Icons.insert_drive_file_outlined,
                            color: AppColor.primary[500],
                          ),
                        ),
                        const SizedBox(width: 18.0),
                        Text(
                          'Lampiran ${index + 1}',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.primary[500],
                              ),
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

    Widget listAnotherCost() {
      return BlocBuilder<ProductionCostDetailCubit, ProductionCostDetailState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 18.0);
              },
              itemBuilder: (context, index) {
                return const AppShimmer(
                  150.0,
                  double.infinity,
                  0.0,
                );
              },
            );
          }

          if (state.otherCostData?.data?.isEmpty ?? true) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.10,
              ),
              child: const AppEmptyData(
                'Belum ada data ditambahkan',
                isCenter: true,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.otherCostData?.data?.length ?? 0,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 18.0);
            },
            itemBuilder: (context, index) {
              return anotherCostItem(state.otherCostData!.data![index]);
            },
          );
        },
      );
    }

    Widget addFinance() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.white,
        child: AppPrimaryFullButton(
          'Tambah Biaya',
          () {
            Navigator.of(context)
                .push(
              AppTransition.pushTransition(
                AddAnotherFinancePage(
                  isRequiredCycleID: false,
                  fishPondID: widget.fishPondID,
                  fishPondCycleID: widget.financeResponseData.fishPondCycleID,
                  tebarDate: widget.cycleDetail.tebarDate ?? DateTime.now(),
                ),
                AddAnotherFinancePage.route(),
              ),
            )
                .then((value) {
              if (value == 'refresh') {
                context.read<ProductionCostDetailCubit>().refresh();
              }
            });
          },
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              summaryCard(),
              const SizedBox(height: 8.0),
              staticCost(),
              const SizedBox(height: 24.0),
              anotherCostTitle(),
              const SizedBox(height: 18.0),
              listAnotherCost(),
              const SizedBox(height: 18.0),
            ],
          ),
        ),
        addFinance(),
      ],
    );
  }
}
