import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/logics/activity_incident_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/views/activity_incident_add_view.dart';

class ActivityIncidentAddPage extends StatelessWidget {
  const ActivityIncidentAddPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-incident-add");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityIncidentPictureCubit>(
          create: (BuildContext context) => ActivityIncidentPictureCubit(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Tambah Aktivitas",
        ),
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
        body: const ActivityIncidentAddView(),
      ),
    );
  }
}
