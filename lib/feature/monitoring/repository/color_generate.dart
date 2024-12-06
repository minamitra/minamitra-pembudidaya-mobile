import 'dart:ui';

import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

extension StringColor on String {
  Color generateResumeColor() {
    switch (toLowerCase()) {
      case 'kurang baik':
      case 'kurang ideal':
      case 'kurang optimal':
        return AppColor.red[500]!;
      case 'baik':
      case 'ideal':
      case 'optimal':
        return AppColor.green[500]!;
      case 'sangat baik':
      case 'sangat ideal':
      case 'sangat optimal':
        return AppColor.secondary[900]!;
      default:
        return AppColor.red;
    }
  }
}
