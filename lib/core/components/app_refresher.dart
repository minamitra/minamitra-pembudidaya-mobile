import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresher extends StatefulWidget {
  const AppRefresher({
    required this.child,
    required this.onRefresh,
    this.offset = 0.0,
    super.key,
  });

  final Widget child;
  final void Function() onRefresh;
  final double? offset;

  @override
  State<AppRefresher> createState() => _AppRefresherState();
}

class _AppRefresherState extends State<AppRefresher> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final GlobalKey _refresherKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: WaterDropMaterialHeader(
        backgroundColor: AppColor.primary[600]!,
        color: AppColor.white,
        distance: 55.0,
        offset: widget.offset ?? 0.0,
      ),
      key: _refresherKey,
      controller: _refreshController,
      onRefresh: () async {
        widget.onRefresh();
        await Future.delayed(const Duration(milliseconds: 1500));
        _refreshController.refreshCompleted();
      },
      child: widget.child,
    );
  }
}
