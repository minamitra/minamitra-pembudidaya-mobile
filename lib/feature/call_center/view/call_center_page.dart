import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/call_center/logic/call_center_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/call_center/view/call_center_view.dart';

class CallCenterPage extends StatelessWidget {
  const CallCenterPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/call-center-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallCenterCubit(PublicServiceImpl.create())..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Pusat Bantuan',
        ),
        body: const CallCenterView(),
      ),
    );
  }
}
