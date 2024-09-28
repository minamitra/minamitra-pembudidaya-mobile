import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_desctiption_item.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_separated_item.dart';

class ActivityTreatmentDetailView extends StatefulWidget {
  final TreatmentResponseData data;

  const ActivityTreatmentDetailView(this.data, {super.key});

  @override
  State<ActivityTreatmentDetailView> createState() =>
      _ActivityTreatmentDetailViewState();
}

class _ActivityTreatmentDetailViewState
    extends State<ActivityTreatmentDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget columnText(String title, String value) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall!,
          ),
        ],
      );
    }

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
                  : ""),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem("Umur Ikan", widget.data.fishAge ?? ""),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem("Perlakuan", widget.data.name ?? ""),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
              "Biaya",
              widget.data.cost != null
                  ? appConvertCurrency(double.parse(widget.data.cost!))
                  : ""),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetDecriptionItem(
            "Catatan",
            widget.data.note ?? "",
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
