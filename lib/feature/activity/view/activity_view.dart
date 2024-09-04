import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/chart_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/view/add_bulk_feed_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/view/detail_activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final TextEditingController pondController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  Function() bottomSheetShowModal(
    BuildContext context,
    String title,
    List<String> data,
  ) {
    return () {
      showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                title,
                height: MediaQuery.of(context).size.height * 0.5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: AppColor.neutral[100],
                              thickness: 1.0,
                              height: 0.0,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(data[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Text(
                                  data[index],
                                  textAlign: TextAlign.start,
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.black,
                                          ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then((value) {
        if (value != null) {
          if (value is String) {}
        }
      });
    };
  }

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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: activityItem(
              title: "Kolam $index",
              value: "2500 Ekor",
              percentage: "50%",
              onTap: () {
                Navigator.of(context).push(AppTransition.pushTransition(
                  const DetailActivityPage(),
                  DetailActivityPage.routeSettings(),
                ));
              },
            ),
          );
        },
      );
    }

    Widget addButton() {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const AddPondPage(),
            AddPondPage.routeSettings(),
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColor.primary[600]),
            const SizedBox(width: 8.0),
            Text(
              "Tambah Kolam",
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: AppColor.primary[600],
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      );
    }

    Widget headerDataItem({
      required IconData icon,
      Color? iconColor,
      required String title,
      required String value,
      String? description,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 18.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.neutral[600],
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              value,
              maxLines: 1,
              style: appTextTheme(context).headlineSmall?.copyWith(
                    color: AppColor.neutral[600],
                  ),
            ),
            if (description != null) const SizedBox(height: 12.0),
            if (description != null)
              Text(
                description,
                maxLines: 1,
                style: appTextTheme(context).labelLarge?.copyWith(
                      color: AppColor.neutral[500],
                    ),
              ),
          ],
        ),
      );
    }

    Widget firstData() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: headerDataItem(
                    icon: Icons.monitor_weight,
                    iconColor: AppColor.secondary[800],
                    title: "Biomasa",
                    value: "1.234,56 Kg",
                    description: "dari 3 kolam aktif",
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: headerDataItem(
                    icon: Icons.shopping_bag_rounded,
                    iconColor: AppColor.red[400],
                    title: "Pakan",
                    value: "15.2 Kg",
                    description: "dari 3 kolam aktif",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: headerDataItem(
                    icon: Icons.pie_chart_sharp,
                    iconColor: AppColor.accent[700],
                    title: "Estimasi SR (%)",
                    value: "84,5 %",
                    description: "dari 3 kolam aktif",
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: headerDataItem(
                    icon: Icons.bar_chart_rounded,
                    iconColor: AppColor.green[400],
                    title: "Estimasi Jual (Rp)",
                    value: "12,34 Jt",
                    description: "dari 3 kolam aktif",
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget secondData() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: headerDataItem(
                    icon: Icons.monitor_weight,
                    iconColor: AppColor.secondary[800],
                    title: "Biomasa",
                    value: "1.234,56 Kg",
                    description: "dari 3 kolam aktif",
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: headerDataItem(
                    icon: Icons.shopping_bag_rounded,
                    iconColor: AppColor.red[400],
                    title: "Pakan",
                    value: "15.2 Kg",
                    description: "dari 3 kolam aktif",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: headerDataItem(
                    icon: Icons.pie_chart_sharp,
                    iconColor: AppColor.accent[700],
                    title: "Estimasi SR (%)",
                    value: "84,5 %",
                    description: "dari 3 kolam aktif",
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: headerDataItem(
                    icon: Icons.bar_chart_rounded,
                    iconColor: AppColor.green[400],
                    title: "Estimasi Jual (Rp)",
                    value: "12,34 Jt",
                    description: "dari 3 kolam aktif",
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget scrollIndicator() {
      return AnimatedSmoothIndicator(
        activeIndex: page,
        count: 2,
        effect: const ExpandingDotsEffect(
          dotHeight: 7,
          dotWidth: 7,
          activeDotColor: AppColor.white,
        ),
      );
    }

    Widget headerData() {
      return Container(
        color: AppColor.primary[800],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppValidatorTextField(
                controller: pondController,
                isMandatory: false,
                withUpperLabel: false,
                readOnly: true,
                hintText: "Semua kolam",
                suffixWidget: const Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
                suffixConstraints: const BoxConstraints(),
                validator: (value) {
                  return null;
                },
                onTap: bottomSheetShowModal(
                  context,
                  "Pilih Kolam",
                  ["Kolam 1", "Kolam 2", "Kolam 3"],
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.35,
              width: double.infinity,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    page = value;
                  });
                },
                controller: pageController,
                physics: AlwaysScrollableScrollPhysics(),
                allowImplicitScrolling: true,
                pageSnapping: true,
                children: [
                  firstData(),
                  secondData(),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            scrollIndicator(),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget addPond() {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  color: AppColor.primary,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    AppConvertDateTime().edmy(DateTime.now()),
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(AppTransition.pushTransition(
                      const AddBulkFeedPage(),
                      AddBulkFeedPage.routeSettings(),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary[600],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColor.white,
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "Pakan",
                          style: appTextTheme(context).titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Divider(
              color: AppColor.neutral[200],
              thickness: 1.0,
              height: 0.0,
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        // const SizedBox(height: 18.0),
        // chartSection(),
        // const SizedBox(height: 12.0),
        // data(),
        // const SizedBox(height: 12.0),
        // seeAllText(),
        headerData(),
        addPond(),
        ...listActivityItem(),
        const SizedBox(height: 18.0),
        addButton(),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
