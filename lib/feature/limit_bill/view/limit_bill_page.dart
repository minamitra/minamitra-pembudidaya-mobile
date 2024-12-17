import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/feature/limit_bill/limit_bill/limit_bill_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/limit_bill/view/limit_bill_view.dart';

class LimitBillPage extends StatelessWidget {
  const LimitBillPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/limit-bill-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LimitBillCubit(),
      child: Scaffold(
        body: LimitBillView(),
      ),
    );
  }
}
