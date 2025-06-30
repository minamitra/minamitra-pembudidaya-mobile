import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/logic/bill_payment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/limit_bill/view/limit_bill_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/limit_bill/view/limit_bill_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/list_bill/view/list_bill_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/score_credit_bill_info/view/score_credit_bill_info_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class BillPaymentView extends StatefulWidget {
  const BillPaymentView({super.key});

  @override
  State<BillPaymentView> createState() => _BillPaymentViewState();
}

class _BillPaymentViewState extends State<BillPaymentView> {
  // int totalCredit = 111111111;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   setState(() {
    //     totalCredit = 10000000;
    //   });
    // });

    scrollController.addListener(
      () {
        if (scrollController.offset >
            MediaQuery.sizeOf(context).height * 0.15) {
          context.read<BillPaymentCubit>().showBackgroundAppBar(true);
        } else {
          context.read<BillPaymentCubit>().showBackgroundAppBar(false);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<BillPaymentCubit, BillPaymentState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            height: 325.0,
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
            child: Column(
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
                    const Expanded(child: SizedBox()),
                    state.status.isLoading
                        ? const AppShimmer(
                            35.0,
                            100.0,
                            100.0,
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppAssets.aScoreBillIcon,
                                  height: 20.0,
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Skor A',
                                  textAlign: TextAlign.start,
                                  style: appTextTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary[700],
                                      ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Total Penggunaan Biaya Distribusi',
                  textAlign: TextAlign.center,
                  style: appTextTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                ),
                const SizedBox(height: 12.0),
                state.status.isLoading
                    ? const AppShimmer(32.0, 150.0, 8.0)
                    : AnimatedFlipCounter(
                        value: state.status.isOnUpdating
                            ? state.dummyCount
                            : state.plafonSummaryResponse?.data?.totalCost ?? 0,
                        prefix: 'Rp ',
                        thousandSeparator: '.',
                        duration: const Duration(milliseconds: 600),
                        textStyle: appTextTheme(context)
                            .displaySmall
                            ?.copyWith(color: AppColor.white),
                      ),
                const SizedBox(height: 12.0),
                state.status.isLoading
                    ? const AppShimmer(18.0, 100.0, 8.0)
                    : AnimatedFlipCounter(
                        value: state.status.isOnUpdating
                            ? state.dummyCount
                            : state.plafonSummaryResponse?.data?.totalPlafon ??
                                0,
                        prefix: 'dari Rp ',
                        thousandSeparator: '.',
                        duration: const Duration(milliseconds: 800),
                        textStyle: appTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: AppColor.primary[300]),
                      ),
              ],
            ),
          );
        },
      );
    }

    Widget billCard() {
      return BlocBuilder<BillPaymentCubit, BillPaymentState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColor.white,
              border: Border.all(color: AppColor.neutral[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Tagihan',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10.0),
                state.status.isLoading
                    ? const AppShimmer(22.0, 120.0, 8.0)
                    : AnimatedFlipCounter(
                        value: state.status.isOnUpdating
                            ? state.dummyCount
                            : state.billSummaryResponse?.data?.totalInvoice ??
                                0,
                        prefix: 'Rp ',
                        thousandSeparator: '.',
                        duration: const Duration(milliseconds: 1000),
                        textStyle: appTextTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.primary[600],
                            ),
                      ),
                const SizedBox(height: 10.0),
                state.status.isLoading
                    ? const AppShimmer(18.0, 180.0, 8.0)
                    : Text(
                        'Jatuh tempo terdekat: ${(state.billSummaryResponse?.data?.nearestDueDate == null) ? '-' : AppConvertDateTime().dmyName(state.billSummaryResponse?.data?.nearestDueDate ?? DateTime.now())}',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.neutral[400]),
                      ),
                const SizedBox(height: 18.0),
                AppPrimaryFullButton(
                  'Bayar Tagihan',
                  () {
                    Navigator.of(context)
                        .push(
                      AppTransition.pushTransition(
                        const ListBillPage(),
                        ListBillPage.routeSettings(),
                      ),
                    )
                        .then(
                      (value) {
                        context.read<BillPaymentCubit>().init();
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

    Widget billMenu({
      required void Function() onTap,
      required IconData icon,
      required String title,
      required String description,
    }) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColor.primary[50],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColor.primary[600],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      description,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .labelMedium
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.primary[900],
              ),
            ],
          ),
        ),
      );
    }

    Widget infoBillMenu(
      String image,
      String title,
      String description,
      void Function() onTap,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColor.primary[50],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Image.asset(
                  image,
                  width: 65.0,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        description,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: appTextTheme(context)
                            .labelMedium
                            ?.copyWith(color: const Color(0xFF727C98)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget billBody() {
      return ListView(
        controller: scrollController,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: (kTextTabBarHeight - 18.0) + 183.0),
          billCard(),
          const SizedBox(height: 18.0),
          Container(
            color: AppColor.white,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                billMenu(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      AppTransition.pushTransition(
                        const ListBillPage(),
                        ListBillPage.routeSettings(),
                      ),
                    )
                        .then(
                      (value) {
                        context.read<BillPaymentCubit>().init();
                      },
                    );
                  },
                  icon: Icons.receipt_outlined,
                  title: 'Rincian Tagihan',
                  description: 'Cek semua tagihan yang perlu dibayar',
                ),
                AppDividerSmall(),
                billMenu(
                  onTap: () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        const ListBillPage(isHistoryTransaction: true),
                        ListBillPage.routeSettings(),
                      ),
                    );
                  },
                  icon: Icons.history,
                  title: 'Riwayat Transaksi',
                  description: 'Cek semua transaksi tagihan kamu',
                ),
                const SizedBox(height: 18.0),
                const AppDivider(thickness: 12.0),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Mau Limit Lebih Besar?',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                infoBillMenu(
                  AppAssets.rocketBillMenuIcon,
                  'Mau Limit Lebih Besar?',
                  'Jangan sia-siakan kesempatan ini, dapatkan limit hingga Rp50 Juta',
                  () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        LimitBillPage(
                          context
                                  .read<BillPaymentCubit>()
                                  .state
                                  .plafonSummaryResponse
                                  ?.data
                                  ?.totalPlafon ??
                              0,
                        ),
                        LimitBillPage.routeSettings,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Skor Kredit',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                infoBillMenu(
                  AppAssets.aScoreBillIcon,
                  'Skor Kredit Tinggi, Peluang Pinjaman Lebih Besar!',
                  'Bayar tepat waktu untuk skor tinggi dan proses pinjaman yang lebih mudah!',
                  () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        ScoreCreditBillInfoPage(
                          context
                                  .read<BillPaymentCubit>()
                                  .state
                                  .billSummaryResponse
                                  ?.data
                                  ?.memberCreditScore ??
                              '-',
                        ),
                        ScoreCreditBillInfoPage.routeSettings,
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
              ],
            ),
          ),
        ],
      );
    }

    Widget appBar() {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: kToolbarHeight - 18.0),
            BlocBuilder<BillPaymentCubit, BillPaymentState>(
              builder: (context, state) {
                String getScoreName(String score) {
                  switch (score.toLowerCase()) {
                    case 'a':
                    case 'kol 1':
                      return 'Lancar';
                    case 'b':
                    case 'kol 2':
                      return 'Dalam Perhatian';
                    case 'kol 3':
                      return 'Kurang Lancar';
                    case 'c':
                    case 'kol 4':
                      return 'Diragukan';
                    case 'kol 5':
                      return 'Macet';
                    default:
                      return '-';
                  }
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  color: state.isShowingBackgroundAppBar
                      ? AppColor.primary[800]
                      : Colors.transparent,
                  child: Row(
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
                      const Expanded(child: SizedBox()),
                      state.status.isLoading
                          ? const AppShimmer(
                              30.0,
                              80.0,
                              100.0,
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AppAssets.aScoreBillIcon,
                                    height: 20.0,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    getScoreName(
                                      state.billSummaryResponse?.data
                                              ?.memberCreditScore
                                              .handlingEmptyString() ??
                                          '-',
                                    ),
                                    textAlign: TextAlign.start,
                                    style: appTextTheme(context)
                                        .labelSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.primary[700],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        header(),
        billBody(),
        appBar(),
      ],
    );
  }
}
