import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailActivityView extends StatefulWidget {
  const DetailActivityView({super.key});

  @override
  State<DetailActivityView> createState() => _DetailActivityViewState();
}

class _DetailActivityViewState extends State<DetailActivityView> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = 0;
  }

  List<String> listImage = [
    AppAssets.dummyDetailActivityBannerImage,
    AppAssets.dummyDetailActivityBannerImage,
    AppAssets.dummyDetailActivityBannerImage,
  ];
  @override
  Widget build(BuildContext context) {
    Widget bottomActionItem(
      String name,
      String icon, {
      Function()? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: 24.0,
              width: 24.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    }

    Widget bottomAction() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF155ED0).withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomActionItem(
                'Aktivitas',
                AppAssets.documentAddIcon,
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const ActivityActivitiesPage(),
                    ActivityActivitiesPage.routeSettings(),
                  ));
                },
              ),
              bottomActionItem(
                'Kejadian',
                AppAssets.notebookIcon,
                onTap: () {},
              ),
              bottomActionItem(
                'Monitoring',
                AppAssets.pulseIcon,
                onTap: () {},
              ),
              bottomActionItem(
                'Panen',
                AppAssets.cartIcon,
                onTap: () {},
              ),
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          Container(
            color: AppColor.primary[800],
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: listImage.length,
                  itemBuilder: (context, index, realIndex) {
                    return AspectRatio(
                      aspectRatio: 375 / 262,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          listImage[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    initialPage: 0,
                    aspectRatio: 375 / 262,
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
                Positioned(
                  top: 8.0,
                  left: 18.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 18.0,
                  child: InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget headerInformationsItem(
      String value,
      String label,
    ) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary[600],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
        ],
      );
    }

    Widget headerInformations() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            Text(
              "Kolam 1",
              style: appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12.0),
            Text(
              "Jl. Anggrek No. 123, Kel. Mawar, Kec. Bunga, 12345",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                  ),
            ),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Expanded(child: headerInformationsItem("405 m", "Luas Lahan")),
                SizedBox(
                  height: 38.0,
                  child: VerticalDivider(color: AppColor.neutral[200]),
                ),
                Expanded(child: headerInformationsItem("250", "Jumlah Ikan")),
                SizedBox(
                  height: 38.0,
                  child: VerticalDivider(color: AppColor.neutral[200]),
                ),
                Expanded(child: headerInformationsItem("50 Kg", "Total Pakan")),
              ],
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget detailItem(
      String title,
      String value,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Text(
              title,
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                  ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.neutral[600],
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    Widget feedSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18.0),
            Text(
              "Pakan",
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18.0),
            detailItem(
              "Starter",
              "PF 500, PF 800, NH 632-0.5",
            ),
            const Divider(
              color: Color(0xFFF3F6F9),
              height: 0.0,
              thickness: 1.0,
            ),
            detailItem(
              "Grower",
              "NH 835-3, NH 835-3 Hi-Pro 783-3",
            ),
            const Divider(
              color: Color(0xFFF3F6F9),
              height: 0.0,
              thickness: 1.0,
            ),
            detailItem(
              "Finisher",
              "NH 835-3, Hi-Pro 783-3, Super Patin",
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget targetSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18.0),
            Text(
              "Target",
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18.0),
            detailItem(
              "Tanggal Tebar",
              "17 Agustus 2024",
            ),
            const Divider(
              color: Color(0xFFF3F6F9),
              height: 0.0,
              thickness: 1.0,
            ),
            detailItem(
              "Target Bobot Panen",
              "250 gr",
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ListView(
          children: [
            header(),
            headerInformations(),
            feedSection(),
            targetSection(),
            const SizedBox(height: 72.0),
          ],
        ),
        bottomAction(),
      ],
    );
  }
}
