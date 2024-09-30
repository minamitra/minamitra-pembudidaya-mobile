import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_desctiption_item.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_separated_item.dart';

class ActivityWaterQualityDetailView extends StatefulWidget {
  final WaterQualityResponseData data;

  const ActivityWaterQualityDetailView(this.data, {super.key});

  @override
  State<ActivityWaterQualityDetailView> createState() =>
      _ActivityWaterQualityDetailViewState();
}

class _ActivityWaterQualityDetailViewState
    extends State<ActivityWaterQualityDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget attachmentFile(List<String>? attachmentJsonArray) {
      if (attachmentJsonArray == null || attachmentJsonArray.isEmpty) {
        return Text(
          'File tidak ada',
          textAlign: TextAlign.center,
          style: appTextTheme(context).labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.neutral[500],
              ),
        );
      } else {
        return SizedBox(
          height: 100.0,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            children: List.generate(
              attachmentJsonArray.length,
              (index) {
                return AspectRatio(
                  aspectRatio: 2 / 1,
                  child: AppNetworkImage(
                    attachmentJsonArray[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    Widget body() {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 2.0),
          AppWidgetSeparatedItem(
              "Waktu  Perlakuan",
              widget.data.datetime != null
                  ? AppConvertDateTime().dmyName(widget.data.datetime!)
                  : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem("Ketinggian Air",
              widget.data.level != null ? "${widget.data.level} cm" : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "pH", widget.data.ph != null ? widget.data.ph! : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "Satinitas",
              widget.data.salinitas != null
                  ? "${widget.data.salinitas} ppt"
                  : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "Suhu",
              widget.data.temperature != null
                  ? "${widget.data.temperature}°C"
                  : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "DO", widget.data.dO != null ? "${widget.data.dO} mg/L" : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "Kecerahan",
              widget.data.clarity != null
                  ? "${widget.data.clarity} mg/L"
                  : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem("Warna Air",
              widget.data.waterColor != null ? widget.data.waterColor! : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "Cuaca",
              widget.data.waterWeather != null
                  ? widget.data.waterWeather!
                  : "-"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetDecriptionItem(
            "Catatan",
            widget.data.note ?? "-",
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          Text(
            "File Lampiran",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 8.0),
          attachmentFile(widget.data.attachmentJsonArray),
          const SizedBox(height: 98.0),
        ],
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
        child: Row(
          children: [
            Expanded(
              child: AppPrimaryOutlineButton(
                "Hapus",
                () {},
                prefixIcon: Image.asset(
                  AppAssets.trashIcon,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: AppPrimaryOutlineButton(
                "Edit",
                () {},
                prefixIcon: Image.asset(
                  AppAssets.editIcon,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        body(),
        // button(),
      ],
    );
  }
}
