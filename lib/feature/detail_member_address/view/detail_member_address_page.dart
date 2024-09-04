import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/view/detail_member_address_view.dart';

class DetailMemberAddressPage extends StatelessWidget {
  const DetailMemberAddressPage({
    super.key,
    this.nameAddress,
    this.nameReceiver,
    this.phoneReceiver,
    this.province,
    this.district,
    this.subdistrict,
    this.village,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.isPrimaryAddress,
  });

  final String? nameAddress;
  final String? nameReceiver;
  final String? phoneReceiver;
  final String? province;
  final String? district;
  final String? subdistrict;
  final String? village;
  final String? fullAddress;
  final String? latitude;
  final String? longitude;
  final bool? isPrimaryAddress;

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
