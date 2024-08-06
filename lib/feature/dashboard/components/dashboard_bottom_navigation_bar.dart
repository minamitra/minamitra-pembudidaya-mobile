import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/components/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class DashboardBottomNavigationBar extends StatelessWidget {
  const DashboardBottomNavigationBar(
    this.currentIndex,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationItem(
              () {
                onTap(0);
              },
              currentIndex == 0,
              AppAssets.homeIcon,
              "Beranda",
            ),
            NavigationItem(
              () {
                onTap(1);
              },
              currentIndex == 1,
              AppAssets.tansactionIcon,
              "Transaksi",
            ),
            NavigationItem(
              () {
                onTap(2);
              },
              currentIndex == 2,
              AppAssets.hearthIcon,
              "Aktivitas",
            ),
            NavigationItem(
              () {
                onTap(3);
              },
              currentIndex == 3,
              AppAssets.userIcon,
              "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
