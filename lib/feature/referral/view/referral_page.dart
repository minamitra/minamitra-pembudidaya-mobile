import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/referral/view/referral_view.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/referral-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Undang Teman",
      ),
      body: ReferralView(),
    );
  }
}
