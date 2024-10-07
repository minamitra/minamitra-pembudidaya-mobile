import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class PromoDummy {
  final String title;
  final String iconAsset;
  final Color cardColor;
  final Color chipColor;
  final Function() onTap;

  PromoDummy({
    required this.title,
    required this.iconAsset,
    required this.cardColor,
    required this.chipColor,
    required this.onTap,
  });
}

final List<PromoDummy> promoDummyList = [
  PromoDummy(
    title: "HARGA\nSPESIAL",
    iconAsset: AppAssets.specialPriceIcon,
    cardColor: AppColor.primary[900]!,
    chipColor: AppColor.primary[700]!,
    onTap: () {},
  ),
  PromoDummy(
    title: "PAKAN\nHEMAT",
    iconAsset: AppAssets.economicalFeedIcon,
    cardColor: AppColor.secondary[900]!,
    chipColor: AppColor.secondary[700]!,
    onTap: () {},
  ),
  PromoDummy(
    title: "PAKET\nBENIH",
    iconAsset: AppAssets.feedPackageIcon,
    cardColor: AppColor.primary[900]!,
    chipColor: AppColor.primary[700]!,
    onTap: () {},
  ),
  PromoDummy(
    title: "VOUCHER\nKONSUL",
    iconAsset: AppAssets.cosulVoucherIcon,
    cardColor: AppColor.secondary[900]!,
    chipColor: AppColor.secondary[700]!,
    onTap: () {},
  )
];
