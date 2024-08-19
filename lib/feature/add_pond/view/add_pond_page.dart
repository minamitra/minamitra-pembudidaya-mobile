import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/logics/activity_incident_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_view.dart';

class AddPondPage extends StatelessWidget {
  const AddPondPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/add-pond-first-step-page');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddPondCubit()),
        BlocProvider(create: (context) => ActivityIncidentPictureCubit()),
      ],
      child: BlocProvider(
        create: (context) => AddPondCubit(),
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Tambah Kolam",
            onBackButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
          body: AddPondView(),
        ),
      ),
    );
  }
}
