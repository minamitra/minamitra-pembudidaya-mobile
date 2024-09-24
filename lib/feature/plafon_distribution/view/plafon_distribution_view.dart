import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/view/feed_tab/feed_tab_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PlafonDistributionView extends StatefulWidget {
  const PlafonDistributionView({super.key});

  @override
  State<PlafonDistributionView> createState() => _PlafonDistributionViewState();
}

class _PlafonDistributionViewState extends State<PlafonDistributionView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget filterDateSection() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.neutral[100],
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColor.neutral[200]!),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "12 Sep 2024 - 19 Sep 2024",
                  style: appTextTheme(context).bodySmall?.copyWith(),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColor.neutral[500],
              ),
            ],
          ),
        ),
      );
    }

    Widget balanceLegendItem(
      Color color,
      String pond,
      String balance,
    ) {
      return Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              pond,
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.neutral[400],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            balance,
            style: appTextTheme(context)
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    Widget chartData() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Distribusi Plafon",
              style: appTextTheme(context).titleSmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rp 1.000.000",
                  style: appTextTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  "dari Rp 1.500.000",
                  style: appTextTheme(context).labelLarge?.copyWith(
                        color: AppColor.neutral[400],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 12.0,
              width: double.infinity,
              child: Stack(
                children: [
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.65,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.green[500],
                    backgroundColor: AppColor.neutral[100],
                  ),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.49,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.accent[900],
                    backgroundColor: Colors.transparent,
                  ),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.33,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.primary[500],
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            balanceLegendItem(
              AppColor.primary[500]!,
              "Kolam 1",
              "Rp 500.000",
            ),
            const SizedBox(height: 16.0),
            balanceLegendItem(
              AppColor.accent[900]!,
              "Kolam 2",
              "Rp 250.000",
            ),
            const SizedBox(height: 16.0),
            balanceLegendItem(
              AppColor.green[500]!,
              "Kolam 3",
              "Rp 250.000",
            ),
          ],
        ),
      );
    }

    Widget selectPondSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Detail Penggunaan",
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColor.neutral[200]!),
              ),
              child: Row(
                children: [
                  Text(
                    "Kolam 1",
                    style: appTextTheme(context).bodySmall,
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColor.neutral[500],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget summaryItem(
      String title,
      String percentage,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(width: 4.0),
          Text(
            percentage,
            style: appTextTheme(context).labelLarge?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: appTextTheme(context).titleSmall,
          ),
        ],
      );
    }

    Widget summarySection() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.neutral[50],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColor.neutral[200]!),
        ),
        child: Column(
          children: [
            summaryItem(
              "Biaya Pakan",
              "50%",
              "Rp 100.000",
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              "Biaya Pakan",
              "50%",
              "Rp 100.000",
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              "Biaya Pakan",
              "50%",
              "Rp 100.000",
            ),
          ],
        ),
      );
    }

    Widget historyData() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: AppColor.neutral[50]),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.primary,
                indicatorWeight: 2.5,
                padding: EdgeInsets.zero,
                labelColor: AppColor.primary,
                unselectedLabelColor: AppColor.neutral[400],
                labelStyle:
                    appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
                unselectedLabelStyle:
                    appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
                labelPadding: const EdgeInsets.all(0),
                isScrollable: false,
                tabs: const [
                  Tab(text: 'Pakan'),
                  Tab(text: 'Perlakuan'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FeedTabView(),
                  FeedTabView(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget distributionBody() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          chartData(),
          const SizedBox(height: 18.0),
          AppDividerLarge(),
          const SizedBox(height: 18.0),
          selectPondSection(),
          const SizedBox(height: 18.0),
          summarySection(),
          const SizedBox(height: 18.0),
          historyData(),
        ],
      );
    }

    return Column(
      children: [
        filterDateSection(),
        Expanded(child: distributionBody()),
      ],
    );
  }
}
