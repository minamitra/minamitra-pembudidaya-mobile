import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/view/cultivation_note_all_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/finance_detail/repositories/sample_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/logic/resume_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/sampling_resume_detail/views/sampling_resume_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResumeDetailView extends StatefulWidget {
  const ResumeDetailView(
    this.pondID,
    this.pondCycleID,
    this.data, {
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final ResumePerCycleResponseData data;

  @override
  State<ResumeDetailView> createState() => _ResumeDetailViewState();
}

class _ResumeDetailViewState extends State<ResumeDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget itemValueText(
      String title,
      String value, {
      String? descValue,
    }) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.neutral[500],
                  ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: appTextTheme(context).titleSmall,
                ),
                if (descValue != null) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    descValue,
                    textAlign: TextAlign.end,
                    style: appTextTheme(context)
                        .labelLarge
                        ?.copyWith(color: AppColor.primary[500]),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }

    Widget pondInformation() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemValueText(
            'Nama kolam',
            widget.data.fishpondName.handlingEmptyString(),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          itemValueText(
            'Alamat',
            '${widget.data.memberAddress} Kel. ${widget.data.memberAddressVillageName} Kec. ${widget.data.memberAddressSubdistrictName} Kab. ${widget.data.memberAddressCityName} Prov. ${widget.data.memberAddressProvinceName}',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          itemValueText(
            'Luas kolam',
            '${(widget.data.fishpondAreaWidth ?? 0) * (widget.data.fishpondAreaLength ?? 0)} m\u00b2',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          itemValueText(
            'Total jumlah tebar',
            '${widget.data.tebarFishTotal} ekor',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          itemValueText(
            'Total densitas',
            '${widget.data.densitas?.toStringAsFixed(2)}/m\u00b2',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
        ],
      );
    }

    Widget titleText({
      required String title,
      bool? isShowing,
      void Function()? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
            ),
            if (isShowing != null)
              Icon(
                isShowing
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.chevron_right_rounded,
                color: AppColor.neutral[400],
              ),
          ],
        ),
      );
    }

    List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
      return <ColumnSeries<ChartSampleData, String>>[
        ColumnSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
              x: 'Produksi',
              y: (widget.data.totalBiayaProduksi ?? 0.0) / 1000000,
              text: appConvertCurrency(widget.data.totalBiayaProduksi ?? 0.0),
              color: AppColor.accent[900]!,
            ),
            ChartSampleData(
              x: 'Pendapatan',
              y: (widget.data.totalPendapatan ?? 0.0) / 1000000,
              text: appConvertCurrency(widget.data.totalPendapatan ?? 0.0),
              color: AppColor.green[500]!,
            ),
          ],
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          pointColorMapper: (data, index) => data.color,
        ),
      ];
    }

    SfCartesianChart buildDefaultColumnChart() {
      return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0.35),
          majorTickLines: MajorTickLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '{value} Jt',
          axisLine: AxisLine(width: 0.35),
          majorTickLines: MajorTickLines(size: 2),
          majorGridLines: MajorGridLines(width: 1),
        ),
        series: getDefaultColumnSeries(),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          builder: (
            dynamic data,
            dynamic point,
            dynamic series,
            int pointIndex,
            int seriesIndex,
          ) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColor.neutralBlueGrey[800],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.black,
                    blurRadius: 8.0,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: data.color,
                        size: 12.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${data.x}',
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.neutralBlueGrey[400]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${data.text}',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget dropDownBackground({
      required Widget child,
      required bool isShow,
    }) {
      return AppAnimatedSize(
        isShow: isShow,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColor.neutral[50],
          ),
          child: child,
        ),
      );
    }

    Widget cycleSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              titleText(
                title: 'Siklus',
                isShowing: state.isShowingCycleSection,
                onTap: () {
                  context.read<ResumeDetailCubit>().toggleCycleSection();
                },
              ),
              if (state.isShowingCycleSection) const SizedBox(height: 12.0),
              dropDownBackground(
                isShow: state.isShowingCycleSection,
                child: Column(
                  children: [
                    itemValueText(
                      'Tanggal tebar',
                      AppConvertDateTime()
                          .dmyName(widget.data.tebarDate ?? DateTime.now()),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Ukuran tebar',
                      '${widget.data.tebarBobot?.toStringAsFixed(2)} gr/ekor',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Asal benih',
                      widget.data.fishseedName.handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Jumlah ikan',
                      '${widget.data.tebarFishTotal} ekor',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Total pakan diberikan',
                      '${widget.data.totalPakan?.toStringAsFixed(2)} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Target bobot panen',
                      '${widget.data.targetPanenBobot?.toStringAsFixed(2)} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Est. perkiraan panen',
                      AppConvertDateTime().dmyName(
                        widget.data.estimationPanenDate ?? DateTime.now(),
                      ),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Est. tonase panen',
                      '${widget.data.estimationPanenTonase?.toStringAsFixed(2)} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget harvestInfoSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              titleText(
                title: 'Informasi Panen',
                isShowing: state.isShowingHarvestInfoSection,
                onTap: () {
                  context.read<ResumeDetailCubit>().toggleHarvestInfoSection();
                },
              ),
              if (state.isShowingHarvestInfoSection)
                const SizedBox(height: 12.0),
              dropDownBackground(
                isShow: state.isShowingHarvestInfoSection,
                child: Column(
                  children: [
                    itemValueText(
                      'Total tonase panen',
                      '${widget.data.totalTonasePanen} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Kirteria hasil panen',
                      widget.data.kriteriaHasilPanen.handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Pertumbuhan ikan',
                      widget.data.pertumbuhanIkanKeseluruhan
                          .handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Produktivitas',
                      widget.data.produktivitasKeseluruhan
                          .handlingEmptyString(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget cultivationAssessmentSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              titleText(
                title: 'Penilaian Budidaya',
                isShowing: state.isShowingCultivationAssessmentSection,
                onTap: () {
                  context
                      .read<ResumeDetailCubit>()
                      .toggleCultivationAssessmentSection();
                },
              ),
              if (state.isShowingCultivationAssessmentSection)
                const SizedBox(height: 12.0),
              dropDownBackground(
                isShow: state.isShowingCultivationAssessmentSection,
                child: Column(
                  children: [
                    itemValueText(
                      'Hasil panen',
                      widget.data.kriteriaHasilPanen.handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Nilai SR',
                      widget.data.nilaiSrKeseluruhan.handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Nilai EPP',
                      widget.data.nilaiEppKeseluruhan.handlingEmptyString(),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Nilai FCR',
                      widget.data.nilaiFcrKeseluruhan.handlingEmptyString(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget feedSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          String starter1Feed = widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter1',
                      )
                      .isEmpty ??
                  true
              ? '-'
              : widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter1',
                      )
                      .map((data) => data.fishfoodName)
                      .join(', ') ??
                  '-';
          double starter1FeedTotal = widget.data.pakan
                  ?.where(
                    (data) => data.fishfoodType?.toLowerCase() == 'starter1',
                  )
                  .map((data) => data.sumFeedingActual)
                  .fold(0, (prev, element) => (prev ?? 0) + (element ?? 0)) ??
              0;

          String starter2Feed = widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter2',
                      )
                      .isEmpty ??
                  true
              ? '-'
              : widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter2',
                      )
                      .map((data) => data.fishfoodName)
                      .join(', ') ??
                  '-';
          double starter2FeedTotal = widget.data.pakan
                  ?.where(
                    (data) => data.fishfoodType?.toLowerCase() == 'starter2',
                  )
                  .map((data) => data.sumFeedingActual)
                  .fold(0, (prev, element) => (prev ?? 0) + (element ?? 0)) ??
              0;

          String starter3Feed = widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter3',
                      )
                      .isEmpty ??
                  true
              ? '-'
              : widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'starter3',
                      )
                      .map((data) => data.fishfoodName)
                      .join(', ') ??
                  '-';
          double starter3FeedTotal = widget.data.pakan
                  ?.where(
                    (data) => data.fishfoodType?.toLowerCase() == 'starter3',
                  )
                  .map((data) => data.sumFeedingActual)
                  .fold(0, (prev, element) => (prev ?? 0) + (element ?? 0)) ??
              0;

          String growerFeed = widget.data.pakan
                      ?.where(
                        (data) => data.fishfoodType?.toLowerCase() == 'grower',
                      )
                      .isEmpty ??
                  true
              ? '-'
              : widget.data.pakan
                      ?.where(
                        (data) => data.fishfoodType?.toLowerCase() == 'grower',
                      )
                      .map((data) => data.fishfoodName)
                      .join(', ') ??
                  '-';
          double growerFeedTotal = widget.data.pakan
                  ?.where(
                    (data) => data.fishfoodType?.toLowerCase() == 'grower',
                  )
                  .map((data) => data.sumFeedingActual)
                  .fold(0, (prev, element) => (prev ?? 0) + (element ?? 0)) ??
              0;

          String finisherFeed = widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'finisher',
                      )
                      .isEmpty ??
                  true
              ? '-'
              : widget.data.pakan
                      ?.where(
                        (data) =>
                            data.fishfoodType?.toLowerCase() == 'finisher',
                      )
                      .map((data) => data.fishfoodName)
                      .join(', ') ??
                  '-';
          double finisherFeedTotal = widget.data.pakan
                  ?.where(
                    (data) => data.fishfoodType?.toLowerCase() == 'finisher',
                  )
                  .map((data) => data.sumFeedingActual)
                  .fold(0, (prev, element) => (prev ?? 0) + (element ?? 0)) ??
              0;

          return Column(
            children: [
              titleText(
                title: 'Pakan',
                isShowing: state.isShowingFeedSection,
                onTap: () {
                  context.read<ResumeDetailCubit>().toggleFeedSection();
                },
              ),
              if (state.isShowingFeedSection) const SizedBox(height: 12.0),
              dropDownBackground(
                isShow: state.isShowingFeedSection,
                child: Column(
                  children: [
                    itemValueText(
                      'Starter 1',
                      starter1Feed,
                      descValue:
                          'Total pakan: ${starter1FeedTotal.toStringAsFixed(2)}',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Starter 2',
                      starter2Feed,
                      descValue:
                          'Total pakan: ${starter2FeedTotal.toStringAsFixed(2)}',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Starter 3',
                      starter3Feed,
                      descValue:
                          'Total pakan: ${starter3FeedTotal.toStringAsFixed(2)}',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Grower',
                      growerFeed,
                      descValue:
                          'Total pakan: ${growerFeedTotal.toStringAsFixed(2)}',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Finisher',
                      finisherFeed,
                      descValue:
                          'Total pakan: ${finisherFeedTotal.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget cultivationResultsSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              titleText(
                title: 'Hasil Budidaya',
                isShowing: state.isShowingCultivationResultsSection,
                onTap: () {
                  context
                      .read<ResumeDetailCubit>()
                      .toggleCultivationResultsSection();
                },
              ),
              if (state.isShowingCultivationResultsSection)
                const SizedBox(height: 12.0),
              dropDownBackground(
                isShow: state.isShowingCultivationResultsSection,
                child: Column(
                  children: [
                    itemValueText(
                      'Tangagal panen',
                      widget.data.actualPanenDate == null
                          ? '-'
                          : AppConvertDateTime().dmyName(
                              widget.data.actualPanenDate!,
                            ),
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Total panen',
                      '${widget.data.totalPanen?.toStringAsFixed(2)} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'DoC (Umur Ikan)',
                      '${widget.data.doc} Hari',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'MBW Akhir',
                      '${widget.data.mbwAkhir?.toStringAsFixed(2)} gram',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Jumlah ikan akhir',
                      '${widget.data.jumlahIkanAkhir?.toStringAsFixed(0)} ekor',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Total pakan',
                      '${widget.data.totalPakan?.toStringAsFixed(2)} Kg',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'EPP',
                      '${widget.data.epp?.toStringAsFixed(2)}%',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'FCR',
                      '${widget.data.fcr?.toStringAsFixed(2)}',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'ADG',
                      '${widget.data.adg?.toStringAsFixed(2)} gram/hari',
                    ),
                    Divider(
                      height: 32.0,
                      thickness: 1,
                      color: AppColor.neutral[200],
                    ),
                    itemValueText(
                      'Produktivitas',
                      '${widget.data.produktivitas?.toStringAsFixed(2)} Kg/m\u00b2',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Widget anotherActionButton({
      required String title,
      required void Function() onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.secondary[900],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(color: AppColor.white),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColor.white,
              ),
            ],
          ),
        ),
      );
    }

    Widget companionNotesSection() {
      return BlocBuilder<ResumeDetailCubit, ResumeDetailState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(
              55,
              double.infinity,
              8.0,
            );
          }

          return anotherActionButton(
            title: 'Catatan Pendamping',
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  CultivationNoteAllPage(
                    widget.pondCycleID,
                    state.companionNotesResponse!.data,
                  ),
                  CultivationNoteAllPage.routeSettings,
                ),
              );
            },
          );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        titleText(title: 'Informasi Kolam'),
        const SizedBox(height: 18.0),
        pondInformation(),
        const SizedBox(height: 6.0),
        titleText(title: 'Keuangan'),
        const SizedBox(height: 24.0),
        buildDefaultColumnChart(),
        const SizedBox(height: 24.0),
        cycleSection(),
        const SizedBox(height: 24.0),
        harvestInfoSection(),
        const SizedBox(height: 24.0),
        cultivationAssessmentSection(),
        const SizedBox(height: 24.0),
        feedSection(),
        const SizedBox(height: 24.0),
        cultivationResultsSection(),
        const SizedBox(height: 24.0),
        companionNotesSection(),
        const SizedBox(height: 18.0),
        anotherActionButton(
          title: 'Data Sampling',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                SamplingResumeDetailPage(
                  int.parse(widget.pondID),
                  int.parse(widget.pondCycleID),
                ),
                SamplingResumeDetailPage.routeSettings(),
              ),
            );
          },
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
