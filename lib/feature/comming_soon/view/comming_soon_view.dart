import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CommingSoonView extends StatefulWidget {
  const CommingSoonView({super.key});

  @override
  State<CommingSoonView> createState() => _CommingSoonViewState();
}

class _CommingSoonViewState extends State<CommingSoonView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.rocketImage,
            height: 240.0,
          ),
          const SizedBox(height: 24.0),
          Text(
            "Fitur Akan Segera Hadir",
            textAlign: TextAlign.center,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  color: AppColor.primary[600],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Fitur ini sedang dalam pengembangan. Mohon bersabar, ya!",
            textAlign: TextAlign.center,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
        ],
      ),
    );
  }
}
