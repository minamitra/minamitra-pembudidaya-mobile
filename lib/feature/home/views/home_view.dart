import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_module_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/user/user_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/about/logic/about_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/about/view/about_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/banner_detail/view/banner_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/logic/dashboard_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event/view/event_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/fish_market/view/fish_market_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/logic/home_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/information_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/promo_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information/views/literacy_information_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/view/literacy_information_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/point_v2_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/promo/view/promo_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/view/qr_scan_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan_summary/view/qr_scan_summary_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/referral/view/referral_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/views/transaction_history_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/voucher/view/voucher_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/voucher_detail/view/voucher_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/bottom_sheet/showing_register_member_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_chip.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().refreshUser();
    activeIndex = 0;
  }

  List<String> listImage = [
    AppAssets.banner1Image,
    AppAssets.banner2Image,
    AppAssets.banner3Image,
  ];

  int levelStep = 3;
  List<NameIconEntity> listLevel = [
    NameIconEntity(
      'Bronze',
      AppAssets.bronzeV2Icon,
    ),
    NameIconEntity(
      'Silver',
      AppAssets.silverV2Icon,
    ),
    NameIconEntity(
      'Gold',
      AppAssets.goldV2Icon,
    ),
    NameIconEntity(
      'Platinum',
      AppAssets.platinumV2Icon,
    ),
    NameIconEntity(
      'Diamond',
      AppAssets.diamondV2Icon,
    ),
  ];

  List<NameIconEntity> listMenu = [
    NameIconEntity(
      'Promo 3M',
      AppAssets.speakerIcon,
    ),
    NameIconEntity(
      'Pasar Ikan',
      AppAssets.locationIcon,
    ),
    NameIconEntity(
      'Acara 3M',
      AppAssets.ticketIcon,
    ),
    NameIconEntity(
      'Belanja',
      AppAssets.bagIcon,
    ),
  ];

  Widget header() {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                175,
                double.infinity,
                0,
              );
            }

            return Container(
              color: AppColor.primary[800],
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CarouselSlider.builder(
                    itemCount: state.bannerResponse?.data?.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            AppTransition.pushTransition(
                              BannerDetailPage(
                                state.bannerResponse!.data![index],
                              ),
                              BannerDetailPage.routeSettings,
                            ),
                          );
                        },
                        child: Image.network(
                          state.bannerResponse?.data?[index].imageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      aspectRatio: 375 / 160,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: state.bannerResponse?.data?.length ?? 0,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        activeDotColor: AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      color: AppColor.primary[800],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AppDefaultCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        borderRadius: 16.0,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColor.primary[50],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Image.asset(
                                AppAssets.walletIcon,
                                height: 20.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state.status.isLoading
                                      ? const AppShimmer(
                                          20,
                                          120.0,
                                          6.0,
                                        )
                                      : AnimatedFlipCounter(
                                          value: state.status.isOnUpdating
                                              ? 999999999
                                              : userState
                                                              .userData?.type
                                                              ?.toLowerCase() !=
                                                          'member' ||
                                                      (userState
                                                              .userData
                                                              ?.isSubmission() ??
                                                          false) ||
                                                      (userState.userData
                                                              ?.isProcessed() ??
                                                          false) ||
                                                      (userState.userData
                                                              ?.isRejected() ??
                                                          false)
                                                  ? 0
                                                  : state.balanceResponse?.data
                                                          ?.totalSaldoRemaining ??
                                                      0,
                                          prefix: 'Rp ',
                                          thousandSeparator: '.',
                                          duration:
                                              const Duration(milliseconds: 800),
                                          textStyle: appTextTheme(context)
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                  state.status.isLoading
                                      ? const AppShimmer(
                                          12.0,
                                          200.0,
                                          6.0,
                                        )
                                      : Text(
                                          userState.userData?.type
                                                          ?.toLowerCase() !=
                                                      'member' ||
                                                  (userState.userData
                                                          ?.isSubmission() ??
                                                      false) ||
                                                  (userState.userData
                                                          ?.isProcessed() ??
                                                      false) ||
                                                  (userState.userData
                                                          ?.isRejected() ??
                                                      false)
                                              ? 'Anda belum terdaftar sebagai anggota'
                                              : 'Sisa plafon anda',
                                          style:
                                              AppTextStyle.blackExtraSmallText,
                                        ),
                                ],
                              ),
                            ),
                            if (userState.userData?.type?.toLowerCase() !=
                                    'member' ||
                                (userState.userData?.isSubmission() ?? false) ||
                                (userState.userData?.isProcessed() ?? false) ||
                                (userState.userData?.isRejected() ?? false))
                              Container(
                                height: 28.0,
                                width: 28.0,
                                decoration: BoxDecoration(
                                  color: AppColor.accent,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.info_outline,
                                    color: AppColor.white,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            if (userState.userData?.type?.toLowerCase() ==
                                    'member' &&
                                (userState.userData?.isApproved() ??
                                    false)) ...[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    AppTransition.pushTransition(
                                      const QrScanPage(),
                                      QrScanPage.route(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Image.asset(
                                        AppAssets.scanIcon,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Bayar',
                                      style: AppTextStyle.blackExtraSmallText,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    AppTransition.pushTransition(
                                      const TransactionHistoryPage(),
                                      TransactionHistoryPage.route(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Image.asset(
                                        AppAssets.historyIcon,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Riwayat',
                                      style: AppTextStyle.blackExtraSmallText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget levelCard() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            return AppDefaultCard(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              borderRadius: 16.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level Kamu',
                        style: AppTextStyle.blackBoldText,
                      ),
                      InkWell(
                        onTap: () {
                          if (userState.userData?.type?.toLowerCase() !=
                                  'member' ||
                              (userState.userData?.isSubmission() ?? false) ||
                              (userState.userData?.isProcessed() ?? false) ||
                              (userState.userData?.isRejected() ?? false)) {
                            AppTopSnackBar(context).showInfo(
                              'Anda belum terdaftar sebagai anggota',
                            );
                            return;
                          }
                          Navigator.of(context).push(
                            AppTransition.pushTransition(
                              const PointV2Page(),
                              PointV2Page.route(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary[50],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            'Detail',
                            style: AppTextStyle.primarySmallMediumText
                                .copyWith(color: AppColor.primary[500]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        listLevel.length,
                        (index) {
                          return Expanded(
                            child: Column(
                              children: [
                                Image.asset(
                                  listLevel[index].icon,
                                  height: 24.0,
                                  width: 24.0,
                                  fit: BoxFit.cover,
                                  color: userState.userData?.type
                                                  ?.toLowerCase() !=
                                              'member' ||
                                          (userState.userData?.isSubmission() ??
                                              false) ||
                                          (userState.userData?.isProcessed() ??
                                              false) ||
                                          (userState.userData?.isRejected() ??
                                              false)
                                      ? AppColor.black[300]
                                      : (state.pointBalance?.data?.totalPoin ??
                                                  0) >
                                              (state.pointConfigruation
                                                      ?.data?[index].minPoin ??
                                                  0)
                                          ? null
                                          : AppColor.black[300],
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  listLevel[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle
                                      .blackDoubleExtraSmallMediumText
                                      .copyWith(
                                    color: userState.userData?.type
                                                    ?.toLowerCase() !=
                                                'member' ||
                                            (userState.userData
                                                    ?.isSubmission() ??
                                                false) ||
                                            (userState.userData
                                                    ?.isProcessed() ??
                                                false) ||
                                            (userState.userData?.isRejected() ??
                                                false)
                                        ? AppColor.black[300]
                                        : (state.pointBalance?.data
                                                        ?.totalPoin ??
                                                    0) >
                                                (state
                                                        .pointConfigruation
                                                        ?.data?[index]
                                                        .minPoin ??
                                                    0)
                                            ? AppColor.black
                                            : AppColor.black[300],
                                    fontWeight:
                                        (state.pointBalance?.data?.totalPoin ??
                                                    0) >
                                                (state
                                                        .pointConfigruation
                                                        ?.data?[index]
                                                        .minPoin ??
                                                    0)
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  state.status.isLoading
                      ? const AppShimmer(
                          12.0,
                          double.infinity,
                          8.0,
                        )
                      : LinearPercentIndicator(
                          animation: true,
                          lineHeight: 8.0,
                          animationDuration: 1000,
                          percent: userState.userData?.type?.toLowerCase() !=
                                      'member' ||
                                  (userState.userData?.isSubmission() ??
                                      false) ||
                                  (userState.userData?.isProcessed() ??
                                      false) ||
                                  (userState.userData?.isRejected() ?? false)
                              ? 0
                              : (state.pointBalance?.data?.totalPoin ?? 0) /
                                          800 >
                                      1
                                  ? 1
                                  : (state.pointBalance?.data?.totalPoin ?? 0) /
                                      800,
                          barRadius: const Radius.circular(8.0),
                          progressColor: AppColor.accent[900],
                          backgroundColor: AppColor.black[300],
                        ),
                  // LinearPercentIndicator(
                  //   animation: true,
                  //   lineHeight: 8.0,
                  //   animationDuration: 1000,
                  //   percent: 0.4,
                  //   barRadius: const Radius.circular(10.0),
                  //   progressColor: AppColor.accent,
                  //   backgroundColor: AppColor.black[300],
                  // ),
                  const SizedBox(height: 12.0),
                  Text(
                    userState.userData?.type?.toLowerCase() != 'member' ||
                            (userState.userData?.isSubmission() ?? false) ||
                            (userState.userData?.isProcessed() ?? false) ||
                            (userState.userData?.isRejected() ?? false)
                        ? 'Gabung program Mitra3M, bisa beli pakan sekarang, bayarnya nanti setelah panen.'
                        : 'Selamat kamu mendapatkan poin! Ayo mulai belanja sekarang !',
                    style: AppTextStyle.blackExtraSmallText.copyWith(
                      color: AppColor.black[600],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget poinCard() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            AppAnimatedSize(
              isShow: state.status.isLoading,
              child: const AppShimmer(
                80,
                double.infinity,
                16,
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              ),
            ),
            if (state.userData?.type?.toLowerCase() == 'user')
              AppAnimatedSize(
                isShow: state.status.isLoaded,
                child: AppDefaultCard(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  padding: const EdgeInsets.only(),
                  borderRadius: 16.0,
                  backgroundCardColor: AppColor.primary,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppAssets.circleBackdropImage,
                          height: 72.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '0 Poin',
                                    style: AppTextStyle.whiteBoldText,
                                  ),
                                  Text(
                                    'Lengkapi data kolam sekarang !',
                                    style: AppTextStyle.whiteExtraSmallText,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 32,
                              width: 120,
                              child: AppWhiteButton(
                                'Lengkapi Data',
                                () {
                                  context
                                      .read<DashboardBottomNavCubit>()
                                      .changeIndex(2);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (state.userData?.type?.toLowerCase() == 'farmer')
              AppAnimatedSize(
                isShow: state.status.isLoaded,
                child: AppDefaultCard(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  padding: const EdgeInsets.only(),
                  borderRadius: 16.0,
                  backgroundCardColor: AppColor.primary,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppAssets.circleBackdropImage,
                          height: 72.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '0 Poin',
                                    style: AppTextStyle.whiteBoldText,
                                  ),
                                  Text(
                                    'Daftar jadi anggota sekarang !',
                                    style: AppTextStyle.whiteExtraSmallText,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 32,
                              width: 120,
                              child: AppWhiteButton(
                                'Daftar Anggota',
                                () {
                                  showingRegisterMemberBottomSheet(context)
                                      .then(
                                    (value) {
                                      if (value == 'cek-profile') {
                                        Navigator.of(context).push(
                                          AppTransition.pushTransition(
                                            const ProfileMemberPage(),
                                            ProfileMemberPage.routeSettings,
                                          ),
                                        );
                                      }

                                      if (value == 'register') {
                                        context
                                            .read<DashboardCubit>()
                                            .requestMember(context);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (state.userData?.type == 'member' &&
                    (state.userData?.isSubmission() ?? false) ||
                (state.userData?.isProcessed() ?? false) ||
                (state.userData?.isRejected() ?? false))
              AppAnimatedSize(
                isShow: state.status.isLoaded,
                child: AppDefaultCard(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  padding: const EdgeInsets.only(),
                  borderRadius: 16.0,
                  backgroundCardColor: AppColor.primary,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppAssets.circleBackdropImage,
                          height: 72.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (state.userData?.isSubmission() ?? false) ||
                                            (state.userData?.isProcessed() ??
                                                false)
                                        ? 'Dalam proses'
                                        : (state.userData?.isRejected() ??
                                                false)
                                            ? 'Verifikasi ditolak'
                                            : 'Daftar jadi anggota sekarang !',
                                    style: AppTextStyle.whiteBoldText,
                                  ),
                                  Text(
                                    (state.userData?.isSubmission() ?? false) ||
                                            (state.userData?.isProcessed() ??
                                                false)
                                        ? 'Data anda dalam proses verifikasi'
                                        : (state.userData?.isRejected() ??
                                                false)
                                            ? 'Verifikasi data anda ditolak'
                                            : 'Daftar jadi anggota sekarang !',
                                    style: AppTextStyle.whiteExtraSmallText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget moduleContainer(NameIconEntity entity) {
    return Center(
      child: AppModuleCard(
        entity.name,
        entity.icon,
        () {
          switch (entity.name) {
            case 'Promo 3M':
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const PromoPage(),
                  PromoPage.route,
                ),
              );
              // Navigator.of(context).push(
              //   AppTransition.pushTransition(
              //     const CommingSoonPage(
              //       'Promo 3M',
              //       customTitle: 'Promo 3M Akan Segera Hadir',
              //       customImage: AppAssets.commingSoonPromoImage,
              //     ),
              //     CommingSoonPage.route(),
              //   ),
              // );
              break;
            case 'Pasar Ikan':
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const FishMarketPage(),
                  FishMarketPage.routeSettings,
                ),
              );
              // Navigator.of(context).push(
              //   AppTransition.pushTransition(
              //     const CommingSoonPage(
              //       'Pasar Ikan',
              //       customTitle: 'Pasar Ikan Akan Segera Hadir',
              //       customImage: AppAssets.commingSoonFishStoreImage,
              //     ),
              //     CommingSoonPage.route(),
              //   ),
              // );
              break;
            case 'Acara 3M':
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const EventPage(),
                  EventPage.route(),
                ),
              );
              break;
            case 'Belanja':
              Navigator.of(context)
                  .push(
                AppTransition.pushTransition(
                  const ProductsPage(),
                  ProductsPage.routeSettings(),
                ),
              )
                  .then((value) {
                if (value == 'changeBottomNav1') {
                  context.read<DashboardBottomNavCubit>().changeIndex(1);
                }
              });
              break;
            default:
          }
        },
      ),
    );
  }

  Widget menu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        padding: const EdgeInsets.only(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 4,
          childAspectRatio: 0.8,
        ),
        itemCount: listMenu.length,
        itemBuilder: (context, index) {
          return moduleContainer(
            listMenu[index],
          );
        },
      ),
    );
  }

  Widget voucher({
    required EdgeInsetsGeometry margin,
    required Color backgroundColor,
    required String image,
    required Color textColor,
    required Color dividerColor,
    required String title,
    required String description,
    required String date,
  }) {
    return Container(
      height: 150.0,
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: MediaQuery.of(context).size.width - 65,
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: appTextTheme(context).headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: textColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          DottedLine(dashColor: dividerColor),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    date,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .labelSmall
                        ?.copyWith(color: textColor),
                  ),
                ),
                Text(
                  '*SK Berlaku',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelSmall
                      ?.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> voucherSection() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voucher 3M',
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Segera pakai sebelum kehabisan !',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.neutral[500],
                        ),
                  ),
                ],
              ),
            ),
            AppWidgetSecondaryChip(
              text: 'Lihat Semua',
              onTap: () {
                Navigator.of(context).push(
                  AppTransition.pushTransition(
                    const VoucherPage(),
                    VoucherPage.routeSettings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 18.0),
      BlocListener<UserCubit, UserState>(
        listener: (context, state) async {
          if (state.status.isLoaded) {
            await Future.delayed(const Duration(milliseconds: 500));
            await controller.animateTo(
              64.0,
              duration: const Duration(milliseconds: 550),
              curve: Curves.linear,
            );
            await controller.animateTo(
              -64.0,
              duration: const Duration(milliseconds: 550),
              curve: Curves.linear,
            );
          }
        },
        child: SizedBox(
          height: 150.0,
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      const VoucherDetailPage(),
                      VoucherDetailPage.routeSettings(),
                    ),
                  );
                },
                child: voucher(
                  margin: EdgeInsets.only(
                    left: 18.0,
                    right: index == 2 ? 18.0 : 0,
                  ),
                  backgroundColor: ((index + 1) % 2 == 0)
                      ? AppColor.primary[500]!
                      : AppColor.primary[900]!,
                  image: ((index + 1) % 2 == 0)
                      ? AppAssets.voucherTicketIcon
                      : AppAssets.voucherBoxIcon,
                  textColor: ((index + 1) % 2 == 0)
                      ? AppColor.primary[100]!
                      : AppColor.primary[200]!,
                  dividerColor: ((index + 1) % 2 == 0)
                      ? AppColor.primary[400]!
                      : AppColor.primary[700]!,
                  title: ((index + 1) % 2 == 0)
                      ? 'Voucher Diskon 20%'
                      : 'Diskon 50%',
                  description: ((index + 1) % 2 == 0)
                      ? 'Untuk setiap pembelian paket pakan diatas 100k di mitra terdekat'
                      : 'Untuk setiap pembelian paket pakan diatas 100k di mitra terdekat',
                  date: '1 Sep - 1 Nov 2024',
                ),
              );
            },
          ),
        ),
      ),
    ];
  }

  Widget referral() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          AppTransition.pushTransition(
            const ReferralPage(),
            ReferralPage.routeSettings,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        height: 72.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.referralImage),
          ),
        ),
      ),
    );
  }

  List<Widget> promo() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'Promo Mitra3M',
          style: appTextTheme(context)
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(height: 18.0),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: promoDummyList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                left: 18.0,
                right: promoDummyList.length - 1 == index ? 18.0 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: promoDummyList[index].cardColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    promoDummyList[index].title,
                    style: appTextTheme(context).displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 18.0),
                  Expanded(
                    child: Image.asset(
                      promoDummyList[index].iconAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: promoDummyList[index].chipColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Lihat Semua',
                      style: appTextTheme(context).titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ];
  }

  List<Widget> informations() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'Literasi & Informasi',
          style: appTextTheme(context)
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(height: 18.0),
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const AppShimmer(
                  75.0,
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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        LiteracyInformationDetailPage(
                          state.literacyInformationResponse!.data![0],
                        ),
                        LiteracyInformationDetailPage.settings,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: state.literacyInformationResponse?.data?[0]
                                .imageUrl ??
                            '',
                        child: Container(
                          height: 178.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                state.literacyInformationResponse?.data?[0]
                                        .imageUrl ??
                                    '',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      Text(
                        state.literacyInformationResponse?.data?[0].title
                                .handlingEmptyString() ??
                            '',
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        state.literacyInformationResponse?.data?[0].content
                                .handlingEmptyString() ??
                            '',
                        style: appTextTheme(context).bodySmall,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            AppTransition.pushTransition(
                              LiteracyInformationDetailPage(
                                state.literacyInformationResponse!.data![0],
                              ),
                              LiteracyInformationDetailPage.settings,
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Selengkapnya',
                          style: appTextTheme(context).bodySmall?.copyWith(
                                color: AppColor.primary[500],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18.0),
                (state.literacyInformationResponse?.data?.length ?? 0) > 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            (state.literacyInformationResponse?.data?.length ??
                                    0) -
                                1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                AppTransition.pushTransition(
                                  LiteracyInformationDetailPage(
                                    state.literacyInformationResponse!
                                        .data![index + 1],
                                  ),
                                  LiteracyInformationDetailPage.settings,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: state.literacyInformationResponse
                                            ?.data?[index + 1].imageUrl ??
                                        '',
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            state
                                                    .literacyInformationResponse
                                                    ?.data?[index + 1]
                                                    .imageUrl ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          state.literacyInformationResponse
                                                  ?.data?[index + 1].title
                                                  .handlingEmptyString() ??
                                              '-',
                                          style: appTextTheme(context)
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          state.literacyInformationResponse
                                                  ?.data?[index + 1].content
                                                  .handlingEmptyString() ??
                                              '-',
                                          style:
                                              appTextTheme(context).labelLarge,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      AppTransition.pushTransition(
                        const LiteracyInformationPage(),
                        LiteracyInformationPage.settings,
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary[50],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      'Lihat Semua',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.primarySmallMediumText
                          .copyWith(color: AppColor.primary[500]),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
              ],
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppRefresher(
      onRefresh: () {
        context.read<HomeCubit>().init();
        // context.read<ActivityCubit>().init(limit: '1');
        context.read<UserCubit>().refreshUser();
      },
      child: ListView(
        children: [
          header(),
          const SizedBox(height: 16.0),
          levelCard(),
          poinCard(),
          const SizedBox(height: 10.0),
          menu(),
          const SizedBox(height: 10.0),
          ...voucherSection(),
          const SizedBox(height: 18.0),
          referral(),
          // const SizedBox(height: 18.0),
          // ...promo(),
          const SizedBox(height: 18.0),
          ...informations(),
        ],
      ),
    );
  }
}
