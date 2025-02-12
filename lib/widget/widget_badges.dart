import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

enum StatusBadge {
  blue,
  green,
  orange,
  red,
}

class AppBadges extends StatelessWidget {
  const AppBadges({
    required this.status,
    required this.text,
    super.key,
  });

  final StatusBadge status;
  final String text;

  Color badgeBorderColor() {
    switch (status) {
      case StatusBadge.blue:
        return const Color(0xFF0EA5E9);
      case StatusBadge.green:
        return AppColor.green[500]!;
      case StatusBadge.orange:
        return AppColor.accent;
      case StatusBadge.red:
        return AppColor.red[600]!;
      default:
        return const Color(0xFF0EA5E9);
    }
  }

  Color badgeColor() {
    switch (status) {
      case StatusBadge.blue:
        return const Color(0xFF0EA5E9).withOpacity(0.1);
      case StatusBadge.green:
        return AppColor.green[50]!;
      case StatusBadge.orange:
        return AppColor.accent[50]!;
      case StatusBadge.red:
        return AppColor.red[50]!;
      default:
        return const Color(0xFF0EA5E9).withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: badgeColor(),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: badgeBorderColor()),
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: appTextTheme(context).labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: badgeBorderColor(),
            ),
      ),
    );
  }
}
