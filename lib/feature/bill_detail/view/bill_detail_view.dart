import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/logic/bill_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_pay/view/bill_payment_pay_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_bill_detail/view/transaction_bill_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BillDetailView extends StatefulWidget {
  const BillDetailView({
    required this.isHistoryTransaction,
    super.key,
  });

  final bool isHistoryTransaction;

  @override
  State<BillDetailView> createState() => _BillDetailViewState();
}

class _BillDetailViewState extends State<BillDetailView> {
  int totalCredit = 111111111;
  final ScrollController scrollController = ScrollController();

  Color badgeBorderColor(String status) {
    switch (status) {
      case 'Menunggu':
        return AppColor.accent;
      case 'Diproses':
        return const Color(0xFF0EA5E9);
      case 'Dikirim':
        return const Color(0xFF0EA5E9);
      case 'Berjalan':
        return AppColor.green[500]!;
      case 'Dibatalkan':
      case 'Ditolak':
        return AppColor.red[600]!;
      default:
        return AppColor.accent;
    }
  }

  Color badgeColor(String status) {
    switch (status) {
      case 'Menunggu':
        return AppColor.accent[50]!;
      case 'Diproses':
        return const Color(0xFF0EA5E9);
      case 'Dikirim':
        return const Color(0xFF0EA5E9);
      case 'Berjalan':
        return AppColor.green[50]!;
      case 'Dibatalkan':
      case 'Ditolak':
        return AppColor.red[600]!;
      default:
        return AppColor.accent;
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        totalCredit = 10000000;
      });
    });
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
                  'Sisa Limit',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.neutral[400]),
                ),
                const SizedBox(width: 8.0),
                AnimatedFlipCounter(
                  value: totalCredit,
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
            LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              animation: true,
              lineHeight: 12.0,
              animationDuration: 1000,
              percent: 0.80,
              barRadius: const Radius.circular(8.0),
              progressColor: AppColor.accent[900],
              backgroundColor: AppColor.neutral[100],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Dari total pendanaan Rp 12.500.000',
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .labelSmall
                  ?.copyWith(color: AppColor.neutral[500]),
            ),
            const SizedBox(height: 18.0),
            const AppDottedLine(),
            const SizedBox(height: 18.0),
            Text(
              'Tagihan Kolam X',
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: AppColor.neutral[400]),
            ),
            const SizedBox(height: 10.0),
            AnimatedFlipCounter(
              value: totalCredit,
              prefix: 'Rp ',
              thousandSeparator: '.',
              duration: const Duration(milliseconds: 800),
              textStyle: appTextTheme(context).headlineSmall,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Jatuh Tempo 15 Februari 2024',
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: AppColor.neutral[400]),
            ),
            if (!widget.isHistoryTransaction) const SizedBox(height: 18.0),
            if (!widget.isHistoryTransaction)
              AppPrimaryFullButton(
                'Bayar Sekarang',
                () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      const BillPaymentPayPage(),
                      BillPaymentPayPage.routeSettings(),
                    ),
                  );
                },
              ),
          ],
        ),
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
              'Rp 2.440.000',
              percentage: '30%',
            ),
            const SizedBox(height: 18.0),
            transactionItem(
              'Perlakuan',
              'Rp 1.525.000',
              percentage: '20%',
            ),
            const SizedBox(height: 18.0),
            transactionItem(
              'Bibit/Benih',
              'Rp 915.000',
              percentage: '15%',
            ),
            const SizedBox(height: 18.0),
            transactionItem(
              'Pembelian',
              'Rp 610.000',
              percentage: '10%',
            ),
            const SizedBox(height: 18.0),
            transactionItem(
              'Lainnya',
              'Rp 915.000',
              percentage: '10%',
            ),
            const SizedBox(height: 18.0),
            AppDottedLine(color: AppColor.neutral[200]),
            const SizedBox(height: 18.0),
            transactionItem(
              'Lainnya',
              'Rp 915.000',
              percentage: '10%',
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
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return AppDividerSmall();
        },
        itemBuilder: (context, index) {
          return historyBillPayedItem(
            isTransferMethod: false,
            value: 'Rp 10.000.000',
            status: 'Menunggu',
            date: '19 Sep 2024, 15:30',
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        AppTransition.pushTransition(
                          const TransactionBillDetailPage(),
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
                      Text(
                        'Tagihan Kolam X',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context)
                            .headlineSmall
                            ?.copyWith(color: AppColor.white),
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
