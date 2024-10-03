import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/cycle_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
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
  List<String> listFile = [
    AppAssets.dummyActivityIncidentImage,
    AppAssets.dummyActivityIncidentImage,
    AppAssets.dummyActivityIncidentImage,
  ];

  Widget statusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: cycleTypeColor(convertToCycleType(
            widget.isReadyHarvest ? "ready" : widget.data.status ?? "active")),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        convertToCycleType(widget.data.status ?? "active") == CycleType.done
            ? "Siklus Selesai"
            : widget.isReadyHarvest
                ? "Siklus siap panen"
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

  Widget cycleInfo() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informasi Siklus",
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24.0),
          textRow("Tanggal Tebar", "7 September 2024"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Jumlah Tebar", "${widget.data.tebarFishTotal} ekor"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Bobot Tebar", "${widget.data.tebarBobot} gram/ekor"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Asal Benih", "Yogyakarta"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Target Bobot Panen Tebar",
              "${widget.data.targetPanenBobot} gram/ekor"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Survival Rate", "90%"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Pakan Starter", "PF 500, PF 800, NH 632-0.5"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Pakan Grower", "NH 835-3, NH 835-3 Hi-Pro 783-3"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Pakan Finisher", "NH 835-3, Hi-Pro 783-3, Super Patin"),
        ],
      ),
    );
  }

  Widget fileAttachment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "File Lampiran",
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
            itemCount: listFile.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.asset(
                    listFile[index],
                    fit: BoxFit.cover,
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
            "Informasi Siklus",
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24.0),
          textRow("Tanggal Panen", "18 Oktober 2024"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          textRow("Total Panen", "100 kg"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          Text(
            "Catatan",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Figma ipsum component variant main layer. Export team scrolling comment prototype edit undo. Follower inspect rotate pixel duplicate asset.",
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

  Widget transactionInfo() {
    return Container(
      color: AppColor.white,
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaksi",
            textAlign: TextAlign.center,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          Text(
            "Mitra3M",
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(height: 16.0),
          textRow("100 kg", "Rp 100,000"),
          const SizedBox(height: 8.0),
          textRow("Sub Total", "Rp 10.000.000"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          Text(
            "Pak Supriyanto",
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(height: 16.0),
          textRow("100 g", "Rp 100,000"),
          const SizedBox(height: 8.0),
          textRow("Sub Total", "Rp 10.000.000"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Total",
                  style: appTextTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Flexible(
                child: Text(
                  "Rp 20.000.000",
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
        "Panen Sekarang",
        () {
          Navigator.of(context).push(AppTransition.pushTransition(
            ActivityCycleAddHarvestPage(widget.data.id ?? ""),
            ActivityCycleAddHarvestPage.routeSettings(),
          ));
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
            cycleInfo(),
            convertToCycleType(widget.data.status ?? "active") == CycleType.done
                ? harvestInfo()
                : const SizedBox(),
            convertToCycleType(widget.data.status ?? "active") == CycleType.done
                ? transactionInfo()
                : const SizedBox(),
            convertToCycleType(widget.data.status ?? "active") == CycleType.done
                ? const SizedBox(height: 24.0)
                : const SizedBox(height: 98.0),
          ],
        ),
        convertToCycleType(widget.data.status ?? "active") == CycleType.done ||
                convertToCycleType(widget.data.status ?? "active") ==
                    CycleType.onBid
            ? const SizedBox()
            : button(),
      ],
    );
  }
}
