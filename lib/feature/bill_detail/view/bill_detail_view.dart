import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/logic/bill_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_pay/view/bill_payment_pay_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_bill_detail/view/transaction_bill_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BillDetailView extends StatefulWidget {
  const BillDetailView({
    required this.isHistoryTransaction,
    required this.billResponseData,
    super.key,
  });

  final bool isHistoryTransaction;
  final BillResponseData billResponseData;

  @override
  State<BillDetailView> createState() => _BillDetailViewState();
}

class _BillDetailViewState extends State<BillDetailView> {
  final ScrollController scrollController = ScrollController();

  Color badgeBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return AppColor.accent;
      case 'diproses':
        return const Color(0xFF0EA5E9);
      case 'dikirim':
        return const Color(0xFF0EA5E9);
      case 'disetujui':
        return AppColor.green[500]!;
      case 'dibatalkan':
      case 'ditolak':
        return AppColor.red[600]!;
      default:
        return AppColor.accent;
    }
  }

  Color badgeColor(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return AppColor.accent[50]!;
      case 'diproses':
        return const Color(0xFF0EA5E9);
      case 'dikirim':
        return const Color(0xFF0EA5E9);
      case 'disetujui':
        return AppColor.green[50]!;
      case 'dibatalkan':
      case 'ditolak':
        return AppColor.red[50]!;
      default:
        return AppColor.accent[50]!;
    }
  }

  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.offset >
            MediaQuery.sizeOf(context).height * 0.02) {
          context.read<BillDetailCubit>().showBackgroundAppBar(true);
        } else {
          context.read<BillDetailCubit>().showBackgroundAppBar(false);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 275.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00317E),
              Color(0XFF002155),
            ],
          ),
        ),
      );
    }

    Widget billCard() {
      return BlocBuilder<BillDetailCubit, BillDetailState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5D72D8).withOpacity(0.1),
                  blurRadius: 24.0,
                  offset: const Offset(0, 8.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Penggunaan Distribusi',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .labelLarge
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                    const SizedBox(width: 8.0),
                    state.status.isLoading
                        ? const AppShimmer(
                            18.0,
                            120.0,
                            4.0,
                          )
                        : AnimatedFlipCounter(
                            value: state.status.isOnUpdating
                                ? state.dummyCount
                                : state.plafonUseSummary?.data?.totalCostUsed ??
                                    0,
                            prefix: 'Rp ',
                            thousandSeparator: '.',
                            duration: const Duration(milliseconds: 600),
                            textStyle: appTextTheme(context)
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                  ],
                ),
                const SizedBox(height: 8.0),
                state.status.isLoading
                    ? const AppShimmer(
                        16.0,
                        double.infinity,
                        100.0,
                      )
                    : LinearPercentIndicator(
                        padding: const EdgeInsets.all(0),
                        animation: true,
                        lineHeight: 12.0,
                        animationDuration: 1000,
                        percent: ((state.plafonUseSummary?.data
                                            ?.percentageCostUsed ??
                                        0) /
                                    100) <
                                1
                            ? ((state.plafonUseSummary?.data
                                        ?.percentageCostUsed ??
                                    0) /
                                100)
                            : 1,
                        barRadius: const Radius.circular(8.0),
                        progressColor: AppColor.accent[900],
                        backgroundColor: AppColor.neutral[100],
                      ),
                const SizedBox(height: 8.0),
                Text(
                  'Dari total pendanaan ${appConvertCurrency((widget.billResponseData.invoiceNominal ?? 0).toDouble())}',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelSmall
                      ?.copyWith(color: AppColor.neutral[500]),
                ),
                const SizedBox(height: 18.0),
                const AppDottedLine(),
                const SizedBox(height: 18.0),
                Text(
                  'Tagihan Kolam ${widget.billResponseData.fishpondName}',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.neutral[400]),
                ),
                const SizedBox(height: 10.0),
                state.status.isLoading
                    ? const AppShimmer(
                        18.0,
                        120.0,
                        4.0,
                      )
                    : AnimatedFlipCounter(
                        value: state.status.isOnUpdating
                            ? state.dummyCount
                            : widget.billResponseData.invoiceNominal ?? 0,
                        prefix: 'Rp ',
                        thousandSeparator: '.',
                        duration: const Duration(milliseconds: 800),
                        textStyle: appTextTheme(context).headlineSmall,
                      ),
                const SizedBox(height: 10.0),
                Text(
                  'Jatuh Tempo ${AppConvertDateTime().dmyName(widget.billResponseData.dueDate ?? DateTime.now())}',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.neutral[400]),
                ),
                if (!widget.isHistoryTransaction) const SizedBox(height: 18.0),
                if (!widget.isHistoryTransaction)
                  state.status.isLoading
                      ? const AppShimmer(
                          55.0,
                          double.infinity,
                          8.0,
                        )
                      : AppPrimaryFullButton(
                          'Bayar Sekarang',
                          () {
                            Navigator.of(context)
                                .push(
                              AppTransition.pushTransition(
                                BillPaymentPayPage(
                                  widget.billResponseData.invoiceNominal ?? 0,
                                  widget.billResponseData,
                                ),
                                BillPaymentPayPage.routeSettings(),
                              ),
                            )
                                .then(
                              (value) {
                                context.read<BillDetailCubit>().refresh();
                              },
                            );
                          },
                        ),
              ],
            ),
          );
        },
      );
    }

    Widget transactionItem(
      String title,
      String value, {
      String? percentage,
      TextStyle? titleStyle,
      TextStyle? valueStyle,
    }) {
      return Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: titleStyle ??
                appTextTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 4.0),
          if (percentage != null)
            Text(
              percentage,
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: AppColor.neutral[500]),
            ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: valueStyle ??
                  appTextTheme(context)
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    }

    Widget transaction() {
      return BlocBuilder<BillDetailCubit, BillDetailState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return AppShimmer(
              MediaQuery.sizeOf(context).height * 0.3,
              double.infinity,
              8.0,
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
            );
          }

          return Container(
            padding: const EdgeInsets.all(18.0),
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            decoration: BoxDecoration(
              color: AppColor.neutral[50],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColor.neutral[200]!),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                transactionItem(
                  'Pakan',
                  appConvertCurrency(
                    (state.plafonUseSummary?.data!.feedingCost?.costNominal ??
                            0.0)
                        .toDouble(),
                  ),
                  percentage:
                      '${state.plafonUseSummary?.data!.feedingCost?.percentage} %',
                ),
                const SizedBox(height: 18.0),
                transactionItem(
                  'Perlakuan',
                  appConvertCurrency(
                    (state.plafonUseSummary?.data!.treatmentCost?.costNominal ??
                            0.0)
                        .toDouble(),
                  ),
                  percentage:
                      '${state.plafonUseSummary?.data!.treatmentCost?.percentage} %',
                ),
                const SizedBox(height: 18.0),
                transactionItem(
                  'Bibit/Benih',
                  appConvertCurrency(
                    (state.plafonUseSummary?.data!.seedCost?.costNominal ?? 0.0)
                        .toDouble(),
                  ),
                  percentage:
                      '${state.plafonUseSummary?.data!.seedCost?.percentage} %',
                ),
                const SizedBox(height: 18.0),
                AppDottedLine(color: AppColor.neutral[200]),
                const SizedBox(height: 18.0),
                transactionItem(
                  'Lainnya',
                  appConvertCurrency(
                    (state.plafonUseSummary?.data!.otherCost?.costNominal ??
                            0.0)
                        .toDouble(),
                  ),
                  percentage:
                      '${state.plafonUseSummary?.data!.otherCost?.percentage} %',
                  titleStyle: appTextTheme(context)
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                  valueStyle: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget historyBillPayedItem({
      required bool isTransferMethod,
      required String value,
      required String status,
      required String date,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: isTransferMethod
                    ? AppColor.primary[50]
                    : AppColor.green[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset(
                isTransferMethod
                    ? AppAssets.paymentMehtodTransferBillIcon
                    : AppAssets.paymentMehtodCashBillIcon,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isTransferMethod ? 'Transfer' : 'Tunai',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleSmall,
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor(status),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: badgeBorderColor(status)),
                        ),
                        child: Text(
                          status,
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).labelSmall?.copyWith(
                                color: badgeBorderColor(status),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    date,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.neutral[400],
                        ),
                  ),
                ],
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleSmall,
            ),
          ],
        ),
      );
    }

    Widget historyBillPayment() {
      return BlocBuilder<BillDetailCubit, BillDetailState>(
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            itemCount: state.status.isLoading
                ? 5
                : state.listBillPayed?.data?.length ?? 0,
            separatorBuilder: (context, index) {
              return AppDividerSmall();
            },
            itemBuilder: (context, index) {
              if (state.status.isLoading) {
                return const AppShimmer(
                  100.0,
                  double.infinity,
                  8.0,
                );
              }

              return historyBillPayedItem(
                isTransferMethod:
                    state.listBillPayed?.data?[index].method == 'Tunai'
                        ? false
                        : true,
                value: appConvertCurrency(
                  (state.listBillPayed?.data?[index].nominal ?? 0).toDouble(),
                ),
                status: state.listBillPayed?.data?[index].status ?? '',
                date: AppConvertDateTime().dmyNamehhmm(
                  state.listBillPayed?.data?[index].createDatetime ??
                      DateTime.now(),
                ),
              );
            },
          );
        },
      );
    }

    Widget bodyData() {
      return Container(
        decoration: const BoxDecoration(color: AppColor.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transaksi',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  BlocBuilder<BillDetailCubit, BillDetailState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const AppShimmer(
                          18.0,
                          75.0,
                          4.0,
                        );
                      }

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            AppTransition.pushTransition(
                              TransactionBillDetailPage(
                                plafonUseSummary: state.plafonUseSummary,
                                plafonFeedUse: state.plafonFeedUse,
                                plafonTreatmentUse: state.plafonTreatmentUse,
                                plafonSeedUse: state.plafonSeedUse,
                                plafonAnotherUse: state.plafonAnotherUse,
                              ),
                              TransactionBillDetailPage.routeSettings,
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Detail',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.secondary[900],
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            transaction(),
            const SizedBox(height: 18.0),
            AppDivider(
              thickness: 12.0,
              color: AppColor.neutral[100],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Riwayat Pembayaran',
                textAlign: TextAlign.start,
                style: appTextTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 18.0),
            historyBillPayment(),
          ],
        ),
      );
    }

    Widget body() {
      return ListView(
        controller: scrollController,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: kToolbarHeight + 34),
          billCard(),
          const SizedBox(height: 24.0),
          bodyData(),
          const SizedBox(height: 24.0),
        ],
      );
    }

    Widget appBar() {
      return Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<BillDetailCubit, BillDetailState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              color: state.isShowingBackgroundAppBar
                  ? AppColor.primary[800]
                  : AppColor.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kToolbarHeight - 18.0),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          'Tagihan ${widget.billResponseData.fishpondName}',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTextTheme(context)
                              .headlineSmall
                              ?.copyWith(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Stack(
      children: [
        header(),
        body(),
        appBar(),
      ],
    );
  }
}
