import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/line_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CultivationView extends StatefulWidget {
  const CultivationView({super.key});

  @override
  State<CultivationView> createState() => _CultivationViewState();
}

class _CultivationViewState extends State<CultivationView> {
  final TextEditingController parameterController = TextEditingController();

  List<String> dataBudidayDummy = [
    "MBW (Mean Body Weight) (gram)",
    "Total Biomass (kg)",
    "Harvest Accumuation (kg)",
    "Feed (kg)",
    "FCR (Feed Convertion Ratio)",
    "SR (Survival Rate) (%)",
    "ADG (Average Daily Growth) (gram)",
  ];

  @override
  void initState() {
    parameterController.text = dataBudidayDummy[0];
    super.initState();
  }

  // final List<SalesData> chartData = [
  //   SalesData(2010, 35),
  //   SalesData(2011, 28),
  //   SalesData(2012, 34),
  //   SalesData(2013, 32),
  //   SalesData(2014, 40)
  // ];

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
                                setModalState(() {
                                  parameterController.text = data[index];
                                });
                                Navigator.of(context).pop(data[index]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  data[index],
                                  textAlign: TextAlign.start,
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: data[index] ==
                                                    parameterController.text
                                                ? AppColor.primary[500]
                                                : AppColor.black,
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
    Widget parameter() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: AppValidatorTextField(
          controller: parameterController,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Parameter",
          hintText: "Pilih parameter",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Parameter tidak boleh kosong";
            }
            return null;
          },
          onTap: bottomSheetShowModal(
            context,
            "Pilih Parameter",
            dataBudidayDummy,
          ),
        ),
      );
    }

    Widget xSetter() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColor.neutral[300]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 14.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    border: Border.all(color: Colors.white),
                    color: AppColor.neutral[100],
                  ),
                  child: const Text("DoC"),
                ),
                SizedBox(
                  height: 44.0,
                  child: VerticalDivider(
                    width: 2.0,
                    color: AppColor.neutral[300],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 14.0,
                  ),
                  child: const Text("0"),
                ),
                SizedBox(
                  height: 44.0,
                  child: VerticalDivider(
                    width: 2.0,
                    color: AppColor.neutral[300],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 14.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    border: Border.all(color: Colors.white),
                    color: AppColor.neutral[100],
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
                SizedBox(
                  height: 44.0,
                  child: VerticalDivider(
                    width: 2.0,
                    color: AppColor.neutral[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 14.0,
                  ),
                  child: Text("100"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Icon(Icons.refresh_outlined),
        ],
      );
    }

    Widget lineChart() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(right: 18.0),
          width: MediaQuery.sizeOf(context).width * 1.5,
          child: SfCartesianChart(
            borderWidth: 2.0,
            plotAreaBorderWidth: 2.0,
            legend: Legend(
              isVisible: true,
            ),
            primaryXAxis: NumericAxis(
              title: AxisTitle(text: "DoC (hari)"),
              minimum: 0,
              maximum: 100,
              interval: 10,
              majorGridLines: MajorGridLines(
                width: 1.5,
                color: AppColor.neutral[200],
                dashArray: const [8, 10],
              ),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: "MBW (gram)"),
              minimum: 0,
              maximum: 100,
              interval: 10,
              majorGridLines: MajorGridLines(
                width: 1.5,
                color: AppColor.neutral[200],
                dashArray: const [8, 10],
              ),
            ),
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<LineDummy, int>(
                dataSource: lineDummyData,
                xValueMapper: (LineDummy sales, _) => sales.xAxis,
                yValueMapper: (LineDummy sales, _) => sales.yAxis,
                width: 4.0,
                color: AppColor.primary,
                legendIconType: LegendIconType.seriesType,
                isVisibleInLegend: true,
                legendItemText: "Hiu",
              ),
              LineSeries<LineDummy, int>(
                dataSource: lineDummyData2,
                xValueMapper: (LineDummy sales, _) => sales.xAxis,
                yValueMapper: (LineDummy sales, _) => sales.yAxis,
                width: 4.0,
                color: AppColor.accent,
                legendIconType: LegendIconType.seriesType,
                isVisibleInLegend: true,
                legendItemText: "Gurame",
              )
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 18),
        parameter(),
        const SizedBox(height: 18),
        xSetter(),
        lineChart(),
      ],
    );
  }
}
