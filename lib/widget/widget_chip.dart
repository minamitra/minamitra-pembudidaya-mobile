import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppWidgetChip extends StatelessWidget {
  const AppWidgetChip({
    required this.text,
    required this.chipColor,
    required this.textColor,
    required this.onTap,
    this.customPadding,
    super.key,
  });

  final String text;
  final Color chipColor;
  final Color textColor;
  final Function() onTap;
  final EdgeInsetsGeometry? customPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: customPadding ??
            const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(
          text,
          style: appTextTheme(context).titleSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class AppWidgetSecondaryChip extends AppWidgetChip {
  AppWidgetSecondaryChip({
    required super.text,
    required super.onTap,
    super.key,
  }) : super(
          textColor: AppColor.primary[500]!,
          chipColor: AppColor.primary[50]!,
        );
}
