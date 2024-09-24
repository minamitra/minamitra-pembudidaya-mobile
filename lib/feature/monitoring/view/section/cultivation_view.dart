import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/view/cultivation_note_all_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/line_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_chip.dart';
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

  TrackballBehavior defaultTrackballBehavior = TrackballBehavior(
    enable: true,
    tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
    activationMode: ActivationMode.singleTap,
    lineType: TrackballLineType.vertical,
    tooltipSettings: const InteractiveTooltip(
      textStyle: TextStyle(
        color: Colors.blue,
        fontSize: 12,
      ),
      format: "point.x Hari : point.y gram",
    ),
    builder: (context, trackballs) {
      return trackballs.seriesIndex == 2
          ? Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Text(
                "DoC : ${trackballs.point?.x.toString()} Hari\nMBW : ${trackballs.point?.y.toString()} gram",
                style: const TextStyle(color: Colors.white),
              ),
            )
          : Container();
    },
  );

  TooltipBehavior defaultTooltipBehavior = TooltipBehavior(
    enable: true,
    activationMode: ActivationMode.singleTap,
    header: '',
    animationDuration: 500,
    duration: 2000,
    canShowMarker: false,
    shouldAlwaysShow: false,
    format: 'point.x Hari : point.y gram',
    builder: (data, point, series, pointIndex, seriesIndex) {
      return Container(
        margin: const EdgeInsets.all(5),
        child: Text(
          "DoC : ${point.x.toString()} Hari\nMBW : ${point.y.toString()} gram",
          style: const TextStyle(color: Colors.white),
        ),
      );
    },
  );

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
      return Container(
        margin: const EdgeInsets.only(right: 18.0),
        width: MediaQuery.sizeOf(context).width * 1.5,
        child: SfCartesianChart(
          borderWidth: 2.0,
          plotAreaBorderWidth: 2.0,
          zoomPanBehavior: ZoomPanBehavior(
            maximumZoomLevel: 0.5,
            enablePanning: true, // Enable panning for the chart
            enablePinching: true, // Enable pinch zooming
            zoomMode:
                ZoomMode.x, // Allow zooming and panning only on the X-axis
          ),
          trackballBehavior: defaultTrackballBehavior,
          tooltipBehavior: defaultTooltipBehavior,
          legend: Legend(
            isVisible: true,
          ),
          primaryXAxis: NumericAxis(
            title: AxisTitle(text: "DoC (hari)"),
            minimum: 0,
            interval: 1,
            initialVisibleMaximum: 10,
            enableAutoIntervalOnZooming: true,
            anchorRangeToVisiblePoints: true,
            majorGridLines: MajorGridLines(
              width: 1.5,
              color: AppColor.neutral[200],
              dashArray: const [8, 10],
            ),
            decimalPlaces: 0,
            desiredIntervals: 10,
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: "MBW (gram)"),
            minimum: 0,
            maximum: 100,
            interval: 10,
            initialVisibleMinimum: 0,
            initialVisibleMaximum: 100,
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
              enableTooltip: true,
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
              enableTooltip: true,
            )
          ],
        ),
      );
    }

    Widget itemNote() {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                child: Image.asset(
                  AppAssets.profileImageDummy,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jacob Jones",
                      style: appTextTheme(context).titleSmall,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Senin, 12 Sept 2024, 14:30",
                      style: appTextTheme(context)
                          .labelLarge
                          ?.copyWith(color: AppColor.neutral[400]),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: AppColor.secondary[50],
                  border: Border.all(color: AppColor.secondary[900]!),
                ),
                child: Text(
                  "Baru",
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.secondary[900],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            "Pada tanggal 12 September 2024, dilakukan pengecekan kualitas air di Kolam 1. Ditemukan bahwa tingkat pH air menunjukkan fluktuasi yang cukup signifikan, dengan penurunan di bawah batas optimal. Kondisi ini dapat mempengaruhi kesehatan ikan, terutama dalam hal pertumbuhan dan daya tahan mereka terhadap penyakit. Setelah berkonsultasi dengan tim teknis, dilakukan penambahan buffer pH untuk menstabilkan kondisi air. Selain itu, pendamping merekomendasikan pemantauan harian untuk memastikan bahwa kondisi air tetap stabil dan tidak memburuk. Langkah selanjutnya adalah melakukan pengecekan lanjutan dalam 3 hari ke depan guna memastikan efektivitas dari penambahan buffer pH.",
            maxLines: 3,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    Widget notes() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Text(
                "Catatan Pendamping",
                style: appTextTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              AppWidgetSecondaryChip(
                text: "Lihat Semua",
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const CultivationNoteAllPage(),
                    CultivationNoteAllPage.routeSettings,
                  ));
                },
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const CultivationNoteDetailPage(),
                    CultivationNoteDetailPage.routeSettings,
                  ));
                },
                child: itemNote(),
              );
            },
          )
        ],
      );
    }

    return ListView(
      children: [
        const SizedBox(height: 18),
        parameter(),
        const SizedBox(height: 18),
        xSetter(),
        lineChart(),
        const SizedBox(height: 36),
        AppDividerLarge(),
        const SizedBox(height: 18),
        notes(),
        const SizedBox(height: 18),
      ],
    );
  }
}
