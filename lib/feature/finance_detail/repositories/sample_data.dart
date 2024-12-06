import 'dart:ui';

import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class ChartSampleData {
  ChartSampleData({
    required this.x,
    required this.y,
    required this.text,
    this.color = AppColor.primary,
  });

  final String x;
  final double y;
  final String text;
  final Color color;
}
