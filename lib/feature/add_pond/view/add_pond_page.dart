import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/image/multiple_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_first_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_second_step_cubit.dart';
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
        BlocProvider(
          create: (context) => AddPondCubit(RefServiceImpl.create())..init(),
        ),
        BlocProvider(create: (context) => MultipleImageCubit()),
        BlocProvider(create: (context) => AddPondFirstStepCubit()),
        BlocProvider(
          create: (context) =>
              AddPondSecondStepCubit(RefServiceImpl.create())..init(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Tambah Kolam",
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: BlocBuilder<AddPondCubit, AddPondState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return AddPondView();
          },
        ),
      ),
    );
  }
}
