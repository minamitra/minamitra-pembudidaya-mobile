import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    this.color,
    this.thickness = 18.0,
    super.key,
  });

  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColor.neutral[100],
      thickness: thickness,
      height: 0.0,
    );
  }
}

class AppDividerLarge extends AppDivider {
  AppDividerLarge({
    super.key,
  }) : super(
          color: AppColor.neutral[100],
          thickness: 18.0,
        );
}

class AppDividerSmall extends AppDivider {
  AppDividerSmall({
    super.key,
  }) : super(
          color: AppColor.neutral[100],
          thickness: 1.0,
        );
}
