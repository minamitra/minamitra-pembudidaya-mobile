import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/view/cultivation_note_all_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/graph_response.dart';
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
    "Pakan Harian",
    "Pakan Kumulatif",
    "SR (Survival Rate) (%)",
    "FCR (Feed Convertion Ratio)",
    "ADG (Average Daily Growth) (gram)",
  ];

  TrackballBehavior defaultTrackballBehavior(
    String title,
    List<GraphResponseDataItem> data,
  ) =>
      TrackballBehavior(
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(
          textStyle: TextStyle(
            color: Colors.blue,
            fontSize: 12,
          ),
          format: "point.x Hari : point.y gram",
        ),
        // tooltipAlignment: ChartAlignment.far,
        builder: (context, trackballs) {
          return Container(
              width: MediaQuery.sizeOf(context).width * 0.55,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      color: AppColor.primary[600],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.convertFilterToTitle(),
                          style: appTextTheme(context).labelLarge?.copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "DoC : ${trackballs.groupingModeInfo?.points[0].x.toString()} Hari",
                                style:
                                    appTextTheme(context).labelLarge?.copyWith(
                                          color: AppColor.white,
                                        ),
                              ),
                            ),
                            Text(
                              AppConvertDateTime().dmyName(
                                  data[trackballs.groupingModeInfo?.points[0].x]
                                          .date ??
                                      DateTime.now()),
                              style: appTextTheme(context).labelLarge?.copyWith(
                                    color: AppColor.white,
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: AppColor.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 14.0,
                              height: 14.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: AppColor.accent[900],
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Expanded(
                              child: Text(
                                "Target",
                                style: appTextTheme(context).labelLarge,
                              ),
                            ),
                            Text(
                              trackballs.groupingModeInfo?.points[0].y
                                      ?.toStringAsFixed(5) ??
                                  "-",
                              style: appTextTheme(context).labelLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        DottedLine(dashColor: AppColor.neutral[200]!),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            Container(
                              width: 14.0,
                              height: 14.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: AppColor.green[500],
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Expanded(
                              child: Text(
                                "Aktual",
                                style: appTextTheme(context).labelLarge,
                              ),
                            ),
                            Text(
                              trackballs.groupingModeInfo?.points[1].y
                                      .toString() ??
                                  "",
                              style: appTextTheme(context).labelLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )

              // Text(
              //   "DoC : ${trackballs.groupingModeInfo?.points[0].x.toString()} Hari\nMBW : ${trackballs.point?.y.toString()} gram",
              //   style: const TextStyle(color: Colors.white),
              // ),
              );
          // : Container();
        },
      );

  // TooltipBehavior defaultTooltipBehavior = TooltipBehavior(
  //   enable: true,
  //   activationMode: ActivationMode.singleTap,
  //   header: '',
  //   animationDuration: 500,
  //   duration: 2000,
  //   canShowMarker: false,
  //   shouldAlwaysShow: false,
  //   format: 'point.x Hari : point.y gram',
  //   builder: (data, point, series, pointIndex, seriesIndex) {
  //     return Container(
  //       margin: const EdgeInsets.all(5),
  //       child: Text(
  //         "DoC : ${point.x.toString()} Hari\nMBW : ${point.y.toString()} gram",
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //     );
  //   },
  // );

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
          if (value is String) {
            parameterController.text = value;
            context.read<CultivationCubit>().onChangeFilter(value.parameter());
            setState(() {});
          }
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
      return BlocBuilder<CultivationCubit, CultivationState>(
        builder: (context, state) {
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
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      child: TextField(
                        controller:
                            context.read<CultivationCubit>().docStartController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: appTextTheme(context).bodySmall,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      child: TextField(
                        controller:
                            context.read<CultivationCubit>().docEndController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: appTextTheme(context).bodySmall,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              InkWell(
                onTap: () {
                  if (int.parse(context
                          .read<CultivationCubit>()
                          .docStartController
                          .text) >
                      int.parse(context
                          .read<CultivationCubit>()
                          .docEndController
                          .text)) {
                    AppTopSnackBar(context).showDanger(
                        "DoC awal tidak boleh lebih besar dari DoC akhir");
                    return;
                  }
                  if (int.parse(context
                          .read<CultivationCubit>()
                          .docEndController
                          .text) >
                      (state.data?.tempData?.length ?? 0)) {
                    AppTopSnackBar(context).showDanger(
                        "DoC akhir tidak boleh lebih besar dari DoC terakhir");
                    return;
                  }
                  setState(() {});
                  context.read<CultivationCubit>().cahngeDOC();
                },
                child: const Icon(Icons.refresh_outlined),
              ),
            ],
          );
        },
      );
    }

    Widget lineChart() {
      return BlocBuilder<CultivationCubit, CultivationState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppShimmer(
                MediaQuery.sizeOf(context).height * 0.4,
                double.infinity,
                12.0,
              ),
            );
          }

          log(state.data?.data?.map((e) => e.target).reduce((a, b) {
                return (a ?? 0.0) > (b ?? 0.0) ? a : b;
              }).toString() ??
              "null");

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
              trackballBehavior: defaultTrackballBehavior(
                state.data?.filterName ?? "",
                state.data?.data ?? [],
              ),
              // tooltipBehavior: defaultTooltipBehavior,
              legend: Legend(
                isVisible: true,
              ),
              primaryXAxis: NumericAxis(
                title: const AxisTitle(text: "DoC (hari)"),
                minimum: state.data?.data?.first.doc?.toDouble() ?? 10,
                interval: 1,
                initialVisibleMaximum: (state.data?.data?.length ?? 10) / 2,
                enableAutoIntervalOnZooming: true,
                anchorRangeToVisiblePoints: true,
                majorGridLines: MajorGridLines(
                  width: 1.5,
                  color: AppColor.neutral[200],
                  dashArray: const [8, 10],
                ),
                decimalPlaces: ((state.data?.data?.length ?? 10) < 10) ? 2 : 0,
                desiredIntervals: 8,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: (state.data?.filterName ?? "Unknown Filter")
                        .convertFilterToTitle()),
                minimum: 0,
                maximum: (state.data?.data?.map((e) => e.target).reduce((a, b) {
                              return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                            }) ??
                            100) <
                        20
                    ? 100
                    : (state.data?.data?.map((e) => e.target).reduce((a, b) {
                          return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                        }) ??
                        100),
                interval:
                    ((state.data?.data?.map((e) => e.target).reduce((a, b) {
                                      return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                                    }) ??
                                    100) <
                                20
                            ? 10
                            : (state.data?.data
                                        ?.map((e) => e.target)
                                        .reduce((a, b) {
                                      return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                                    }) ??
                                    100) /
                                10)
                        .roundToDouble(),
                initialVisibleMinimum: 0,
                initialVisibleMaximum: (state.data?.data
                                ?.map((e) => e.target)
                                .reduce((a, b) {
                              return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                            }) ??
                            100) <
                        20
                    ? 100
                    : (state.data?.data?.map((e) => e.target).reduce((a, b) {
                          return (a ?? 0.0) > (b ?? 0.0) ? a : b;
                        }) ??
                        100),
                majorGridLines: MajorGridLines(
                  width: 1.5,
                  color: AppColor.neutral[200],
                  dashArray: const [8, 10],
                ),
              ),
              series: <CartesianSeries>[
                // Renders line chart
                LineSeries<GraphResponseDataItem, int>(
                  dataSource: state.data?.data ?? [],
                  xValueMapper: (GraphResponseDataItem data, _) => data.doc,
                  yValueMapper: (GraphResponseDataItem data, _) => data.target,
                  width: 4.0,
                  color: AppColor.accent[900],
                  legendIconType: LegendIconType.seriesType,
                  isVisibleInLegend: true,
                  legendItemText: "Target",
                  enableTooltip: true,
                ),
                LineSeries<GraphResponseDataItem, int>(
                  dataSource: state.data?.data ?? [],
                  xValueMapper: (GraphResponseDataItem data, _) => data.doc,
                  yValueMapper: (GraphResponseDataItem data, _) => data.actual,
                  width: 4.0,
                  color: AppColor.green[500],
                  legendIconType: LegendIconType.seriesType,
                  isVisibleInLegend: true,
                  legendItemText: "Aktual",
                  enableTooltip: false,
                )
              ],
            ),
          );
        },
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
