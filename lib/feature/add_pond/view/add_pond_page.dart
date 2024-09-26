import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/image/multiple_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed/feed_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_first_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_second_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_third_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddPondPage extends StatelessWidget {
  const AddPondPage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/add-pond-first-step-page');
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPondCubit(
            RefServiceImpl.create(),
            PondServiceImpl.create(),
          )..init(),
        ),
        BlocProvider(create: (context) => MultipleImageCubit()),
        BlocProvider(create: (context) => AddPondFirstStepCubit()),
        BlocProvider(
          create: (context) =>
              AddPondSecondStepCubit(RefServiceImpl.create())..init(),
        ),
        BlocProvider(
            create: (context) =>
                AddPondThirdStepCubit(FeedServiceImpl.create())..init()),
      ],
      child: BlocListener<AddPondCubit, AddPondState>(
        listener: (context, state) {
          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }

          if (state.status.isError) {
            if (state.errorMessage == "TOKEN_EXPIRED") {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }

          if (state.status.isSuccessSubmit) {
            AppTopSnackBar(context)
                .showSuccess("Berhasil Membuat\nKolam Baru !");
            Navigator.of(context).pop("refresh");
          }
        },
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
      ),
    );
  }
}
