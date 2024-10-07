import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppEmptyData extends StatelessWidget {
  final String text;

  const AppEmptyData(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.emptyDataImage,
          width: 84,
        ),
        const SizedBox(height: 16.0),
        Text(
          text,
          textAlign: TextAlign.center,
          style: appTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.neutral[500],
              ),
        ),
      ],
    );
  }
}
