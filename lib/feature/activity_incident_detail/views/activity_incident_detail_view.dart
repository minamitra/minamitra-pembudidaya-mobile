import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityIncidentDetailView extends StatefulWidget {
  const ActivityIncidentDetailView({super.key});

  @override
  State<ActivityIncidentDetailView> createState() =>
      _ActivityIncidentDetailViewState();
}

class _ActivityIncidentDetailViewState
    extends State<ActivityIncidentDetailView> {
  List<String> listFile = [
    AppAssets.dummyActivityIncidentImage,
    AppAssets.dummyActivityIncidentImage,
    AppAssets.dummyActivityIncidentImage,
  ];

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

    Widget body() {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          columnText("Tanggal", "05 Agustus 2024 17:00"),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          columnText("Catatan",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
          Divider(
            height: 32.0,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          fileAttachment(),
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
        button(),
      ],
    );
  }
}
