import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/point_v2_view.dart';

class PointV2Page extends StatelessWidget {
  const PointV2Page({super.key});

  static RouteSettings route() => const RouteSettings(name: '/point-v2-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PointV2Cubit(PointServiceImpl.create()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
        ),
        body: PointV2View(),
      ),
    );
  }
}
