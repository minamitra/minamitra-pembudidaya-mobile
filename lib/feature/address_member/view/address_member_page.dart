import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/view/address_member_view.dart';

class AddressMemberPage extends StatelessWidget {
  const AddressMemberPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/address-member-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Alamat Saya",
      ),
      body: const AddressMemberView(),
    );
  }
}
