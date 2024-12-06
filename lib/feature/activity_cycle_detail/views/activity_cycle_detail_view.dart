import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/cycle_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/buyer_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/views/activity_cycle_add_harvest_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleDetailView extends StatefulWidget {
  final FeedCycleHistoryResponseData data;
  final bool isReadyHarvest;

  const ActivityCycleDetailView(
    this.data, {
    required this.isReadyHarvest,
    super.key,
  });

  @override
  State<ActivityCycleDetailView> createState() =>
      _ActivityCycleDetailViewState();
}

class _ActivityCycleDetailViewState extends State<ActivityCycleDetailView> {
  int totalTransaction = 0;

  @override
  void initState() {
    super.initState();
    if (widget.data.buyerJsonArray?.isNotEmpty ?? false) {
      totalTransaction = widget.data.buyerJsonArray!
          .map((e) => e.sellTotalPrice)
          .reduce((value, element) => value + element);
    }
  }

  Widget statusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: cycleTypeColor(
          convertToCycleType(
            widget.isReadyHarvest ? 'ready' : widget.data.status ?? 'active',
          ),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        convertToCycleType(widget.data.status ?? 'active') == CycleType.done
            ? 'Siklus Selesai'
            : widget.isReadyHarvest
                ? 'Siklus siap panen'
                : "Siklus Sedang ${cycleTypeToString(convertToCycleType(widget.data.status ?? "active"))}",
        textAlign: TextAlign.center,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
      ),
    );
  }

  Widget textRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: appTextTheme(context).bodySmall,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget detailPakanItem(
    String title,
    String feeData,
    String valueData,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            style: appTextTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.neutral[500]),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  feeData,
                  textAlign: TextAlign.end,
                  maxLines: 3,
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[800],
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Est Total Pakan: $valueData Kg',
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.primary[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pondInfo() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Kolam',
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24.0),
          textRow(
            'Nama kolam',
            widget.data.fishpondName.handlingEmptyString(),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Alamat kolam',
            '${widget.data.fishpondAddress} Kel. ${widget.data.fishpondAddressVillageName} Kec. ${widget.data.fishpondAddressSubdistrictName} Kab. ${widget.data.fishpondAddressCityName} Prov. ${widget.data.fishpondAddressProvinceName}',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Luas kolam',
            '${double.parse(widget.data.fishpondAreaTotal ?? '0').toStringAsFixed(2)} m\u00b2',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Kedalaman kolam',
            '${double.parse(widget.data.fishpondAreaDepth ?? '0').toStringAsFixed(2)} m',
          ),
        ],
      ),
    );
  }

  Widget cycleInfo() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Siklus',
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24.0),
          textRow(
            'Tanggal Tebar',
            AppConvertDateTime()
                .dmyName(widget.data.tebarDate ?? DateTime.now()),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Jumlah Tebar',
            '${widget.data.tebarFishTotal} ekor',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Bobot Tebar',
            '${double.parse(widget.data.tebarBobot.handleEmptyStringToZero()).toStringAsFixed(2)} gram/ekor',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Densitas',
            double.parse(widget.data.densitas ?? '0').toStringAsFixed(2),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Asal Benih',
            widget.data.fishseedName.handlingEmptyString(),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Total biomassa tebar',
            '${((double.parse(
                  widget.data.tebarFishTotal.handleEmptyStringToZero(),
                ) * double.parse(
                  widget.data.tebarBobot.handleEmptyStringToZero(),
                )) / 1000).toStringAsFixed(2)} Kg',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Target Bobot Panen',
            '${double.parse(widget.data.targetPanenBobot.handleEmptyStringToZero()).toStringAsFixed(2)} gram/ekor',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Survival Rate',
            '${widget.data.srTarget} %',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Estimasi tanggal panen',
            AppConvertDateTime()
                .dmyName(widget.data.estimationPanenDate ?? DateTime.now()),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Estimasi tonnase panen',
            '${widget.data.estimationPanenTonase.handlingEmptyString()} Kg',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          detailPakanItem(
            'Pakan Starter 1',
            widget.data.fishfoodJsonObject?.starter1
                    ?.map((element) => element.name ?? '-')
                    .toList()
                    .join(', ') ??
                '-',
            appConvert3Digits(
              ((widget.data.fishfoodJsonObject?.starter1?.isEmpty ?? true
                      ? [0.0, 0.0, 0.0]
                      : widget.data.fishfoodJsonObject?.starter1
                              ?.map(
                                (element) => (element.total ?? 0),
                              )
                              .toList() ??
                          [0.0, 0.0, 0.0])
                  .reduce((value, element) => value + element)),
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          detailPakanItem(
            'Pakan Starter 2',
            widget.data.fishfoodJsonObject?.starter2
                    ?.map((element) => element.name ?? '-')
                    .toList()
                    .join(', ') ??
                '-',
            appConvert3Digits(
              ((widget.data.fishfoodJsonObject?.starter2?.isEmpty ?? true
                      ? [0.0, 0.0, 0.0]
                      : widget.data.fishfoodJsonObject?.starter2
                              ?.map(
                                (element) => (element.total ?? 0),
                              )
                              .toList() ??
                          [0.0, 0.0, 0.0])
                  .reduce((value, element) => value + element)),
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          detailPakanItem(
            'Pakan Starter 3',
            widget.data.fishfoodJsonObject?.starter3
                    ?.map((element) => element.name ?? '-')
                    .toList()
                    .join(', ') ??
                '-',
            appConvert3Digits(
              ((widget.data.fishfoodJsonObject?.starter3?.isEmpty ?? true
                      ? [0.0, 0.0, 0.0]
                      : widget.data.fishfoodJsonObject?.starter3
                              ?.map(
                                (element) => (element.total ?? 0),
                              )
                              .toList() ??
                          [0.0, 0.0, 0.0])
                  .reduce((value, element) => value + element)),
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          detailPakanItem(
            'Pakan Grower',
            widget.data.fishfoodJsonObject?.grower
                    ?.map((element) => element.name ?? '-')
                    .toList()
                    .join(', ') ??
                '-',
            appConvert3Digits(
              ((widget.data.fishfoodJsonObject?.grower?.isEmpty ?? true
                      ? [0.0, 0.0, 0.0]
                      : widget.data.fishfoodJsonObject?.grower
                              ?.map(
                                (element) => (element.total ?? 0),
                              )
                              .toList() ??
                          [0.0, 0.0, 0.0])
                  .reduce((value, element) => value + element)),
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          detailPakanItem(
            'Pakan Finisher',
            widget.data.fishfoodJsonObject?.finisher
                    ?.map((element) => element.name ?? '-')
                    .toList()
                    .join(', ') ??
                '-',
            appConvert3Digits(
              ((widget.data.fishfoodJsonObject?.finisher?.isEmpty ?? true
                      ? [0.0, 0.0, 0.0]
                      : widget.data.fishfoodJsonObject?.finisher
                              ?.map(
                                (element) => (element.total ?? 0),
                              )
                              .toList() ??
                          [0.0, 0.0, 0.0])
                  .reduce((value, element) => value + element)),
            ),
          ),
        ],
      ),
    );
  }

  // ! please make sure API
  Widget fileAttachment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'File Lampiran',
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 160.0,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.panenAttachmentJsonArray?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  // child: Image.asset(
                  //   listFile[index],
                  //   fit: BoxFit.cover,
                  // ),
                  child: InkWell(
                    onTap: () {
                      showImageViewer(
                        context,
                        Image.network(
                          widget.data.panenAttachmentJsonArray?[index] ?? '',
                        ).image,
                        immersive: false,
                        useSafeArea: true,
                        swipeDismissible: true,
                        doubleTapZoomable: true,
                        backgroundColor: Colors.black.withOpacity(0.7),
                      );
                    },
                    child: AppNetworkImage(
                      widget.data.panenAttachmentJsonArray?[index] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget harvestInfo() {
    return Container(
      color: AppColor.white,
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Panen',
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24.0),
          textRow(
            'Tanggal Panen',
            AppConvertDateTime().edmy(
              DateTime.parse(
                widget.data.actualPanenDate ?? DateTime.now().toString(),
              ),
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Total Bobot Panen',
            '${double.parse(widget.data.actualPanenBobot.handleEmptyStringToZero()).toStringAsFixed(2)} gram/ekor',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow(
            'Total Panen',
            '${double.parse(widget.data.actualPanenTonase.handleEmptyStringToZero()).toStringAsFixed(2)} Kg',
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          Text(
            'Catatan',
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.data.panenNote ?? 'Tidak ada catatan',
            style: appTextTheme(context).bodySmall,
          ),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          fileAttachment(),
        ],
      ),
    );
  }

  Widget transactionItem(BuyerData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.buyerName,
          style: appTextTheme(context).bodySmall,
        ),
        const SizedBox(height: 16.0),
        textRow(
          '${data.sellRequest} kg',
          appConvertCurrency(data.sellUnitPrice.toDouble()),
        ),
        const SizedBox(height: 8.0),
        textRow(
          'Sub Total',
          appConvertCurrency(data.sellTotalPrice.toDouble()),
        ),
        Divider(
          height: 32.0,
          thickness: 1,
          color: AppColor.neutral[100],
        ),
      ],
    );
  }

  Widget transactionInfo() {
    return Container(
      color: AppColor.white,
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi',
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          ...List.generate(
            widget.data.buyerJsonArray?.length ?? 0,
            (index) => transactionItem(widget.data.buyerJsonArray![index]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Total',
                  style: appTextTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Flexible(
                child: Text(
                  appConvertCurrency(totalTransaction.toDouble()),
                  style: appTextTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(
          top: BorderSide(
            color: AppColor.neutral[200]!,
            width: 1.0,
          ),
        ),
      ),
      child: AppPrimaryFullButton(
        'Panen Sekarang',
        () {
          Navigator.of(context).push(
            AppTransition.pushTransition(
              ActivityCycleAddHarvestPage(
                widget.data.id ?? '',
                tebarDate: widget.data.tebarDate ?? DateTime.now(),
              ),
              ActivityCycleAddHarvestPage.routeSettings(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          children: [
            const SizedBox(height: 16.0),
            statusBar(context),
            const SizedBox(height: 16.0),
            pondInfo(),
            const SizedBox(height: 16.0),
            cycleInfo(),
            convertToCycleType(widget.data.status ?? 'active') == CycleType.done
                ? harvestInfo()
                : const SizedBox(),
            convertToCycleType(widget.data.status ?? 'active') == CycleType.done
                ? transactionInfo()
                : const SizedBox(),
            convertToCycleType(widget.data.status ?? 'active') == CycleType.done
                ? const SizedBox(height: 24.0)
                : const SizedBox(height: 98.0),
          ],
        ),
        convertToCycleType(widget.data.status ?? 'active') == CycleType.done ||
                convertToCycleType(widget.data.status ?? 'active') ==
                    CycleType.onBid
            ? const SizedBox()
            : button(),
      ],
    );
  }
}
