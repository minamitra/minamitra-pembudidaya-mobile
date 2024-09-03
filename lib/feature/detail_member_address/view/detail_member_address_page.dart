import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/view/detail_member_address_view.dart';

class DetailMemberAddressPage extends StatelessWidget {
  const DetailMemberAddressPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/detail-member-address-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Alamat",
      ),
      body: DetailMemberAddressView(),
    );
  }
}
