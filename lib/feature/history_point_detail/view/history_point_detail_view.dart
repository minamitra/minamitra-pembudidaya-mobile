import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class HistoryPointDetailView extends StatefulWidget {
  const HistoryPointDetailView({super.key});

  @override
  State<HistoryPointDetailView> createState() => _HistoryPointDetailViewState();
}

class _HistoryPointDetailViewState extends State<HistoryPointDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget background() {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(color: AppColor.primaryDark),
          ),
          Expanded(
            flex: 6,
            child: Container(color: AppColor.neutral[100]),
          ),
        ],
      );
    }

    Widget itemBodyCard(
      String title,
      String value,
    ) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.neutral[500]),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
    }

    Widget attachmentCard() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColor.primary[100]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: AppColor.primary[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Icon(
                Icons.description_outlined,
                color: AppColor.primary[500],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                "Detail Attachment.png",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColor.primary[500]),
              ),
            ),
          ],
        ),
      );
    }

    Widget bodyCard() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary[500],
              ),
              child: Image.asset(AppAssets.withdrawalIcon),
            ),
            const SizedBox(height: 18.0),
            Text(
              "Tarik Tunai",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 36.0),
            itemBodyCard(
              "Tanggal, Waktu",
              "19 Sep 2024, 15:30",
            ),
            const SizedBox(height: 18.0),
            itemBodyCard(
              "Jumlah Penarikan",
              "Rp 50.000",
            ),
            const SizedBox(height: 18.0),
            itemBodyCard(
              "Poin",
              "-500",
            ),
            const SizedBox(height: 36.0),
            attachmentCard(),
          ],
        ),
      );
    }

    return Stack(
      children: [
        background(),
        bodyCard(),
      ],
    );
  }
}
