import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_module_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
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
      "Lapak Ikan",
      AppAssets.locationIcon,
    ),
    NameIconEntity(
      "Acara 3M",
      AppAssets.ticketIcon,
    ),
    NameIconEntity(
      "Beli Pakan",
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
        Container(
          color: AppColor.primary[800],
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: listImage.length,
                itemBuilder: (context, index, realIndex) {
                  return InkWell(
                    onTap: () {},
                    child: Image.asset(
                      listImage[index],
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
                  count: listImage.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Stack(
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
                    Column(
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
                    const SizedBox(width: 12.0),
                    Column(
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
                  ],
                ),
              ),
            ),
          ],
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
    return AppDefaultCard(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.only(),
      borderRadius: 16.0,
      backgroundCardColor: AppColor.primary,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
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
                    () {},
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              AppAssets.circleBackdropImage,
              height: 72.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget moduleContainer(NameIconEntity entity) {
    return AppModuleCard(
      entity.name,
      entity.icon,
      () {},
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
      ],
    );
  }
}
