import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/logic/history_point_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/view/history_point_view.dart';

class HistoryPointPage extends StatelessWidget {
  const HistoryPointPage({super.key});

  static const RouteSettings route = RouteSettings(name: '/history-point-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryPointCubit(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Riwayat Point",
        ),
        body: const HistoryPointView(),
      ),
    );
  }
}
