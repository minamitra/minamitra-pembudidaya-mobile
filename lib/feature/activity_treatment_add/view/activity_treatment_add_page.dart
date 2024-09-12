import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_view.dart';

class ActivityTreatmentAddPage extends StatelessWidget {
  const ActivityTreatmentAddPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: "/activity-treatment-add-page");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MultiImageCubit())],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Tambah Perlakuaan",
        ),
        body: ActivityTreatmentAddView(),
      ),
    );
  }
}
