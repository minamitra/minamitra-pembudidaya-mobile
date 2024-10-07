import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class FeedTabView extends StatelessWidget {
  const FeedTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget feedTabItem(
      String title,
      String time,
      String value,
    ) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextTheme(context).titleSmall,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      time,
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18.0),
              Text(
                "- Rp 100.000",
                style: appTextTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColor.accent[900]),
              )
            ],
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
          feedTabItem(
            'Pakan Pagi',
            '05-08-2024 17:00 WIB',
            '- Rp 100.000',
          ),
        ],
      ),
    );
  }
}
