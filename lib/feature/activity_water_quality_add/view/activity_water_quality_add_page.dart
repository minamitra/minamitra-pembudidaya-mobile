import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/view/activity_water_quality_add_view.dart';

class ActivityWaterQualityAddPage extends StatelessWidget {
  const ActivityWaterQualityAddPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: "/activity-water-quality-page");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MultiImageCubit()),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Tambah Kualitas Air",
        ),
        body: ActivityWaterQualityAddView(),
      ),
    );
  }
}
