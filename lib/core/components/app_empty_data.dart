import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppEmptyData extends StatelessWidget {
  final String text;
  final bool isCenter;
  final String customImage;
  final String? descriptions;

  const AppEmptyData(
    this.text, {
    this.isCenter = false,
    this.customImage = AppAssets.emptyDataImage,
    this.descriptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Image.asset(
          customImage,
          width: 84,
        ),
        const SizedBox(height: 16.0),
        Text(
          text,
          textAlign: TextAlign.center,
          style: descriptions != null
              ? appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.neutral[700],
                  )
              : appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral[500],
                  ),
        ),
        if (descriptions != null) ...[
          const SizedBox(height: 8.0),
          Text(
            descriptions ?? '-',
            textAlign: TextAlign.center,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColor.neutral[700],
                ),
          ),
        ],
      ],
    );
  }
}
