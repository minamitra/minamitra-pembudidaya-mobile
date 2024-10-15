import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_desctiption_item.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_separated_item.dart';

class ActivityActivitiesDetailView extends StatelessWidget {
  const ActivityActivitiesDetailView(this.data, {super.key});

  final FeedActivityResponseData data;

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

    Widget body() {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 2.0),
          AppWidgetSeparatedItem(
            "Waktu Pakan",
            AppConvertDateTime().ddmmyyyyhhmm(data.datetime ?? DateTime.now()),
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
            "Umur Ikan",
            "${data.fishAge} hari",
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
            "Jumlah Pakan",
            "${(double.parse(data.actual?.handleEmptyStringToZero() ?? "0") / 1000).toStringAsFixed(7)} gram",
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetSeparatedItem(
            "Merk Pakan",
            data.fishfoodName ?? "-",
          ),
          // const SizedBox(height: 18.0),
          // AppDividerSmall(),
          // const SizedBox(height: 18.0),
          // AppWidgetSeparatedItem("Total Pakan", "4500 gram"),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          AppWidgetDecriptionItem(
            "Catatan",
            data.note ?? "-",
          ),
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
