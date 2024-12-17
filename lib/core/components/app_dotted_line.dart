import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class AppDottedLine extends StatelessWidget {
  const AppDottedLine({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      lineThickness: 2.0,
      dashLength: 16.0,
      dashColor: color ?? AppColor.black[100]!,
      dashGapLength: 8.0,
    );
  }
}
