import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/location_service/location_permission.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    requestLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary[800],
      body: Center(
        child: Image.asset(
          AppAssets.logoIcon,
          height: 48.0,
        ),
      ),
    );
  }
}
