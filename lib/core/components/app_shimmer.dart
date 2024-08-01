import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? height, width, rounded;
  final EdgeInsetsGeometry? margin;
  const AppShimmer(
    this.height,
    this.width,
    this.rounded, {
    Key? key,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.white,
      highlightColor: AppColor.primary,
      child: Container(
        height: height ?? 30,
        width: width ?? 100,
        margin: margin ?? const EdgeInsets.only(bottom: 3.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(rounded ?? 0),
        ),
      ),
    );
  }
}
