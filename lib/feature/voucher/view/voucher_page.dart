import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/voucher/view/voucher_view.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/voucher-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Voucher 3M',
      ),
      backgroundColor: AppColor.neutral[50],
      body: WidgetFeatureOnProgress(child: const VoucherView()),
    );
  }
}
