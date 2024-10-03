import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/logics/activity_treatment_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/view/activity_treatment_add_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ActivityTreatmentAddPage extends StatelessWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final DateTime dateDistribution;
  final bool isEdit;
  final TreatmentResponseData? data;

  const ActivityTreatmentAddPage(
    this.fishpondId,
    this.fishpondcycleId,
    this.dateDistribution, {
    this.isEdit = false,
    this.data,
    super.key,
  });

  static const RouteSettings routeSettings =
      RouteSettings(name: "/activity-treatment-add-page");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MultiImageCubit()),
        BlocProvider(
          create: (context) => ActivityTreatmentAddCubit(
            ActivityTreatmentServiceImpl.create(),
            CdnServiceImpl.create(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          isEdit ? "Edit Perlakuan" : "Tambah Perlakuaan",
        ),
        body:
            BlocConsumer<ActivityTreatmentAddCubit, ActivityTreatmentAddState>(
          listener: (context, state) {
            if (state.status.isShowDialogLoading) {
              AppDialog().showLoadingDialog(context, dialog);
            }

            if (state.status.isHideDialogLoading) {
              dialog.hide();
            }

            if (state.status.isError) {
              if (state.errorMessage == "TOKEN_EXPIRED") {
                RepositoryProvider.of<AuthenticationRepository>(context)
                    .logout();
              } else {
                AppTopSnackBar(context).showDanger(state.errorMessage);
              }
            }

            if (state.status.isSuccessSubmit) {
              AppTopSnackBar(context).showSuccess(isEdit
                  ? "Berhasil Edit\nPerlakuan!"
                  : "Berhasil Membuat\nPerlakuan Baru!");
              Navigator.of(context).pop("refresh");
              if (isEdit) {
                Navigator.of(context).pop("refresh");
              }
            }
          },
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ActivityTreatmentAddView(
              fishpondId,
              fishpondcycleId,
              dateDistribution,
              isEdit,
              data,
            );
          },
        ),
      ),
    );
  }
}
