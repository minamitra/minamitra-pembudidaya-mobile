import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class HistoryWithdrawTab extends StatelessWidget {
  const HistoryWithdrawTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 18.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.pointAddIcon,
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Penambahan Poin",
                        style: appTextTheme(context)
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "16 September 2024",
                        style: appTextTheme(context).bodySmall?.copyWith(
                              color: AppColor.neutralBlueGrey[400],
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "+100 Poin",
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: AppColor.secondary[900],
                        fontWeight: FontWeight.w500,
                      ),
                )
              ],
            ),
            const SizedBox(height: 18.0),
            AppDividerSmall(),
          ],
        );
      },
    );
  }
}
