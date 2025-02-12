import 'package:flutter/material.dart';

import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:text_scroll/text_scroll.dart';

class WidgetFeatureOnProgress extends StatelessWidget {
  const WidgetFeatureOnProgress({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColor.accent.withOpacity(0.15),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              const Icon(
                Icons.campaign_outlined,
                color: AppColor.accent,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextScroll(
                  'Fitur ini sedang dalam pengembangan. Nantikan fitur ini dalam waktu dekat !!!     ',
                  velocity: const Velocity(pixelsPerSecond: Offset(32.0, 0)),
                  delayBefore: const Duration(milliseconds: 500),
                  pauseBetween: const Duration(milliseconds: 500),
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.accent,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class WidgetFeatureOnProgressComponent extends StatelessWidget {
  const WidgetFeatureOnProgressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.accent.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          const Icon(
            Icons.campaign_outlined,
            color: AppColor.accent,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextScroll(
              'Fitur ini sedang dalam pengembangan. Nantikan fitur ini dalam waktu dekat !!!     ',
              velocity: const Velocity(pixelsPerSecond: Offset(32.0, 0)),
              delayBefore: const Duration(milliseconds: 500),
              pauseBetween: const Duration(milliseconds: 500),
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.accent,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
