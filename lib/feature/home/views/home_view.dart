import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_module_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/logic/home_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/information_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/promo_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point/view/point_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/qr_scan/view/qr_scan_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/referral/view/referral_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/views/transaction_history_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_chip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = 0;
  }

  List<String> listImage = [
    AppAssets.banner1Image,
    AppAssets.banner2Image,
    AppAssets.banner3Image,
  ];

  int levelStep = 1;
  List<NameIconEntity> listLevel = [
    NameIconEntity(
      "Bronze",
      AppAssets.starIcon,
    ),
    NameIconEntity(
      "Silver",
      AppAssets.medalSilverIcon,
    ),
    NameIconEntity(
      "Gold",
      AppAssets.medalGoldIcon,
    ),
    NameIconEntity(
      "Platinum",
      AppAssets.crownIcon,
    ),
  ];

  List<NameIconEntity> listMenu = [
    NameIconEntity(
      "Promo 3M",
      AppAssets.speakerIcon,
    ),
    NameIconEntity(
      "Pasar Ikan",
      AppAssets.locationIcon,
    ),
    NameIconEntity(
      "Acara 3M",
      AppAssets.ticketIcon,
    ),
    NameIconEntity(
      "Belanja",
      AppAssets.bagIcon,
    ),
  ];

  Widget header() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          color: AppColor.primary[800],
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    style: AppTextStyle.blackSmallText,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintStyle: AppTextStyle.blackSmallText,
                      hintText: 'Cari produk',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColor.black,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Image.asset(
                AppAssets.basketIcon,
                height: 20.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16.0),
              Image.asset(
                AppAssets.bellIcon,
                height: 20.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
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
                alignment: Alignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: state.bannerResponse?.data?.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: () {},
                        child: Image.network(
                          state.bannerResponse?.data?[index].imageUrl ?? "",
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
                              Text(
                                "Rp 12.500.000",
                                style: AppTextStyle.blackSemiBoldText,
                              ),
                              Text(
                                "Sisa plafon anda",
                                style: AppTextStyle.blackExtraSmallText,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(AppTransition.pushTransition(
                              const QrScanPage(),
                              QrScanPage.route(),
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Image.asset(
                                  AppAssets.scanIcon,
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "Bayar",
                                style: AppTextStyle.blackExtraSmallText,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(AppTransition.pushTransition(
                              const TransactionHistoryPage(),
                              TransactionHistoryPage.route(),
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Image.asset(
                                  AppAssets.historyIcon,
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "Riwayat",
                                style: AppTextStyle.blackExtraSmallText,
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
        ),
      ],
    );
  }

  Widget levelCard() {
    return AppDefaultCard(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      borderRadius: 16.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Level Kamu",
                style: AppTextStyle.blackBoldText,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const PointPage(),
                    PointPage.routeSettings,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColor.primary[50],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    "Detail",
                    style: AppTextStyle.primarySmallMediumText.copyWith(
                      color: AppColor.secondary,
                    ),
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
                          color: index < levelStep
                              ? AppColor.accent
                              : AppColor.black[300],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          listLevel[index].name,
                          style: AppTextStyle.blackExtraSmallText.copyWith(
                            color: index < levelStep
                                ? AppColor.black
                                : AppColor.black[300],
                            fontWeight: index < levelStep
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
          LinearProgressBar(
            maxSteps: listLevel.length,
            progressType:
                LinearProgressBar.progressTypeLinear, // Use Linear progress
            currentStep: levelStep,
            minHeight: 7,
            progressColor: AppColor.accent,
            backgroundColor: AppColor.black[300],
            borderRadius: BorderRadius.circular(10), //  NEW
          ),
          const SizedBox(height: 12.0),
          Text(
            "Gabung program Mitra3M, bisa beli pakan sekarang, bayarnya nanti setelah panen.",
            style: AppTextStyle.blackExtraSmallText.copyWith(
              color: AppColor.black[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget poinCard() {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AppShimmer(
            80,
            double.infinity,
            16,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
          );
        }

        log(state.pondReponse?.data?.length.toString() ?? "no");

        if ((state.pondReponse?.data?.length ?? 1) <= 1) {
          return AppDefaultCard(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              "0 Poin",
                              style: AppTextStyle.whiteBoldText,
                            ),
                            Text(
                              "Lengkapi data kolam sekarang!",
                              style: AppTextStyle.whiteExtraSmallText,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                        width: 120,
                        child: AppWhiteButton(
                          "Lengkapi Data",
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
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget moduleContainer(NameIconEntity entity) {
    return AppModuleCard(
      entity.name,
      entity.icon,
      () {
        switch (entity.name) {
          case "Promo 3M":
            Navigator.of(context).push(AppTransition.pushTransition(
              const CommingSoonPage("Promo 3M"),
              CommingSoonPage.route(),
            ));
            break;
          case "Pasar Ikan":
            Navigator.of(context).push(AppTransition.pushTransition(
              const CommingSoonPage("Pasar Ikan"),
              CommingSoonPage.route(),
            ));
            break;
          case "Acara 3M":
            Navigator.of(context).push(AppTransition.pushTransition(
              const CommingSoonPage("Acara 3M"),
              CommingSoonPage.route(),
            ));
            break;
          case "Belanja":
            Navigator.of(context).push(AppTransition.pushTransition(
              const ProductsPage(),
              ProductsPage.routeSettings(),
            ));
            break;
          default:
        }
      },
    );
  }

  Widget menu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
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

  List<Widget> event() {
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
                    "Acara 3M",
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Jangan lewatkan acara menarik kami",
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.neutral[500],
                        ),
                  ),
                ],
              ),
            ),
            AppWidgetSecondaryChip(
              text: "Lihat Semua",
              onTap: () {
                Navigator.of(context).push(AppTransition.pushTransition(
                  const CommingSoonPage("Acara 3M"),
                  CommingSoonPage.route(),
                ));
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 18.0),
      SizedBox(
        height: 125.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                left: 18.0,
                right: index == 4 ? 18.0 : 0,
              ),
              height: 125.0,
              width: MediaQuery.of(context).size.width - 72,
              decoration: BoxDecoration(
                color: AppColor.primary[50],
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppAssets.dummyEventImage),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget referral() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(AppTransition.pushTransition(
          const ReferralPage(),
          ReferralPage.routeSettings,
        ));
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
          "Promo Mitra3M",
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
                      "Lihat Semua",
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
          "Literasi & Informasi",
          style: appTextTheme(context)
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(height: 18.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 178.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppAssets.informationDummy1Image),
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Text(
              "Cara Mengelola Kualitas Air untuk Hasil Panen Optimal",
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Kualitas air merupakan faktor penting dalam budidaya ikan patin. Dalam artikel ini, kami akan",
              style: appTextTheme(context).bodySmall,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "Lihat Selengkapnya",
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.primary[500],
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: 18.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: informationDummyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                informationDummyList[index].imageAsset),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              informationDummyList[index].title,
                              style: appTextTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              informationDummyList[index].description,
                              style: appTextTheme(context).labelLarge,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        header(),
        const SizedBox(height: 16.0),
        levelCard(),
        const SizedBox(height: 16.0),
        poinCard(),
        const SizedBox(height: 16.0),
        menu(),
        const SizedBox(height: 16.0),
        ...event(),
        const SizedBox(height: 18.0),
        referral(),
        const SizedBox(height: 18.0),
        ...promo(),
        const SizedBox(height: 18.0),
        ...informations(),
      ],
    );
  }
}
