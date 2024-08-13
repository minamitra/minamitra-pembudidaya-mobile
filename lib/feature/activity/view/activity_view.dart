import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/chart_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  Widget build(BuildContext context) {
    Widget chartSection() {
      return SizedBox(
        height: 260.0,
        child: Center(
          child: SfCircularChart(
            legend: const Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.wrap,
              isResponsive: true,
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              format: 'point.x : point.y %',
            ),
            series: <CircularSeries>[
              // Renders radial bar chart
              RadialBarSeries<ChartDummy, String>(
                dataSource: chartDummyData,
                xValueMapper: (ChartDummy data, _) => data.name,
                yValueMapper: (ChartDummy data, _) => data.value,
                legendIconType: LegendIconType.circle,
                cornerStyle: CornerStyle.endCurve,
                maximumValue: 100.0,
                name: "Aktifitas",
                enableTooltip: true,
                dataLabelMapper: (ChartDummy data, _) => data.name,
              )
            ],
          ),
        ),
      );
    }

    Widget dataItem(
      String title,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            style: appTextTheme(context).titleSmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            value,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      );
    }

    Widget data() {
      return Column(
        children: [
          dataItem("Total Plafon", "Rp 120.000.000"),
          const SizedBox(height: 12.0),
          dataItem("Plafon Terpakai", "Rp 50.000.000"),
          const SizedBox(height: 12.0),
          dataItem("Sisa Plafon", "Rp 70.000.000"),
        ],
      );
    }

    Widget seeAllText() {
      return InkWell(
        onTap: () {},
        child: Text(
          "Selengkapnya",
          textAlign: TextAlign.center,
          style: appTextTheme(context).titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.primary[500],
              ),
        ),
      );
    }

    Widget activityItem({
      required String title,
      required String value,
      required String percentage,
      void Function()? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            Row(
              children: [
                Container(
                  width: 54.0,
                  height: 54.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.primary,
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.dymmyActivityImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: appTextTheme(context).titleSmall,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        value,
                        style: appTextTheme(context).titleSmall?.copyWith(
                              color: const Color(0xFF94A3B8),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  percentage,
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 18.0),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                )
              ],
            ),
            const SizedBox(height: 18.0),
            const Divider(
              color: Color(0xFFF3F6F9),
              height: 0,
              thickness: 1.0,
            )
          ],
        ),
      );
    }

    List<Widget> listActivityItem() {
      return List.generate(
        3,
        (index) {
          return activityItem(
            title: "Kolam $index",
            value: "2500 Ekor",
            percentage: "50%",
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const DetailActivityPage(),
                DetailActivityPage.routeSettings(),
              ));
            },
          );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        chartSection(),
        const SizedBox(height: 12.0),
        data(),
        const SizedBox(height: 12.0),
        seeAllText(),
        const SizedBox(height: 18.0),
        ...listActivityItem(),
      ],
    );
  }
}
