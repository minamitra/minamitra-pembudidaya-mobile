import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/logic/address_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/view/address_member_view.dart';

class AddressMemberPage extends StatelessWidget {
  const AddressMemberPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/address-member-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressMemberCubit(DeliveryAddressServiceImpl.create())..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Alamat Saya',
        ),
        body: const AddressMemberView(),
      ),
    );
  }
}
