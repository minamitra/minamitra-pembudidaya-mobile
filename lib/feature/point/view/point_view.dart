import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point/view/history_withdraw_tab/history_withdraw_tab.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point/view/withdraw_point_tab/withdraw_point_tab.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PointView extends StatefulWidget {
  const PointView({super.key});

  @override
  State<PointView> createState() => _PointViewState();
}

class _PointViewState extends State<PointView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<NameIconEntity> listLevel = [
    NameIconEntity(
      "200",
      AppAssets.starIcon,
    ),
    NameIconEntity(
      "400",
      AppAssets.medalSilverIcon,
    ),
    NameIconEntity(
      "600",
      AppAssets.medalGoldIcon,
    ),
    NameIconEntity(
      "800",
      AppAssets.crownIcon,
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget pointCard() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColor.primary,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    height: 38.0,
                    width: 38.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.neutral[100],
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.startFullIcon),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10 Poin",
                        style: appTextTheme(context).headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Bronze",
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: 98.0,
                    child: AppWhiteButton(
                      "Tukar Poin",
                      () {},
                      height: 32.0,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                AppAssets.circleBackdropImage,
                height: 78.0,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> pointBar() {
      return [
        Text(
          "Poin Bar",
          style: appTextTheme(context)
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                listLevel.length,
                (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        listLevel[index].icon,
                        height: 28.0,
                        width: 28.0,
                        fit: BoxFit.cover,
                        color:
                            index < 2 ? AppColor.accent : AppColor.black[300],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 16.0,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                LinearPercentIndicator(
                  padding: const EdgeInsets.all(0),
                  animation: true,
                  lineHeight: 12.0,
                  animationDuration: 1000,
                  percent: 0.4,
                  barRadius: const Radius.circular(8.0),
                  progressColor: AppColor.accent[900],
                  backgroundColor: AppColor.neutral[100],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      listLevel.length,
                      (index) {
                        return Image.asset(
                          AppAssets.circleActiveIcon,
                          width: 16.0,
                          height: 16.0,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ];
    }

    Widget tabBar() {
      return Container(
        height: 55.0,
        decoration: BoxDecoration(
          color: AppColor.neutral[100],
          borderRadius: BorderRadius.circular(100.0),
        ),
        // decoration: BoxDecoration(color: AppColor.neutral[50]),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: AppColor.primary[900],
          ),
          dividerColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColor.primary,
          indicatorWeight: 2.5,
          padding: EdgeInsets.zero,
          labelColor: AppColor.white,
          unselectedLabelColor: AppColor.neutral[400],
          labelStyle: appTextTheme(context).titleMedium?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
          unselectedLabelStyle: appTextTheme(context).bodySmall?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
          labelPadding: const EdgeInsets.all(0),
          isScrollable: false,
          tabs: const [
            Tab(text: 'Tukar Poin'),
            Tab(text: 'Riwayat'),
          ],
        ),
      );
    }

    Widget tabBody() {
      return TabBarView(
        controller: _tabController,
        children: [
          WithdrawPointTab(),
          HistoryWithdrawTab(),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18.0),
          pointCard(),
          const SizedBox(height: 18.0),
          ...pointBar(),
          const SizedBox(height: 24.0),
          tabBar(),
          const SizedBox(height: 18.0),
          Expanded(child: tabBody()),
        ],
      ),
    );
  }
}
