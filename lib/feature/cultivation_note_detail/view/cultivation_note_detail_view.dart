import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CultivationNoteDetailView extends StatefulWidget {
  const CultivationNoteDetailView(this.data, {super.key});

  final CompanionNotesResponseData data;

  @override
  State<CultivationNoteDetailView> createState() =>
      _CultivationNoteDetailViewState();
}

class _CultivationNoteDetailViewState extends State<CultivationNoteDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            child: Image.asset(
              AppAssets.profileImageDummy,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.userName.handlingEmptyString(),
                style: appTextTheme(context).titleSmall,
              ),
              const SizedBox(height: 4.0),
              Text(
                AppConvertDateTime()
                    .edmy(widget.data.createDatetime ?? DateTime.now()),
                style: appTextTheme(context)
                    .labelLarge
                    ?.copyWith(color: AppColor.neutral[400]),
              )
            ],
          ),
        ],
      );
    }

    List<Widget> attachment() {
      return (widget.data.attachmentJsonArray?.isEmpty ?? true)
          ? [
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: AppEmptyData(
                  "Belum ada catatan\ndari pendamping",
                  isCenter: true,
                ),
              ),
            ]
          : List.generate(
              widget.data.attachmentJsonArray?.length ?? 0,
              (index) {
                return Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: Image.network(
                    widget.data.attachmentJsonArray?[index],
                    errorBuilder: (
                      BuildContext context,
                      Object obj,
                      StackTrace? trace,
                    ) {
                      return const SizedBox();
                    },
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        header(),
        const SizedBox(height: 18.0),
        Text(
          "PIC: Unknown",
          style: appTextTheme(context).bodySmall,
        ),
        const SizedBox(height: 18.0),
        AppDividerSmall(),
        const SizedBox(height: 18.0),
        Text(
          widget.data.content.handlingEmptyString(),
          style: appTextTheme(context).bodySmall,
        ),
        ...attachment(),
      ],
    );
  }
}
