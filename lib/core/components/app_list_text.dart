import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppListText extends StatelessWidget {
  const AppListText(this.title, this.text, {this.topPadding = 0, super.key});

  final Widget title;
  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral[600],
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
