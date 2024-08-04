import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color_scheme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.lightTextTheme,
      primaryColor: AppColor.primary,
      colorScheme: ApptColorScheme.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColor.primary,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.darkTextTheme,
      useMaterial3: true,
    );
  }
}
