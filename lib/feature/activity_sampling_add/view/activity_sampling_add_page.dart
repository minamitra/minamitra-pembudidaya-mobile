import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/sampling_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/logics/activity_sampling_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/view/activity_sampling_add_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ActivitySamplingAddPage extends StatelessWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final bool isEdit;
  final SamplingResponseData? data;

  const ActivitySamplingAddPage(
    this.fishpondId,
    this.fishpondcycleId, {
    this.isEdit = false,
    this.data,
    super.key,
  });

  static const RouteSettings routeSettings =
      RouteSettings(name: "/activity-sampling-add-page");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MultiImageCubit(),
        ),
        BlocProvider(
          create: (context) => ActivitySamplingAddCubit(
            ActivitySamplingServiceImpl.create(),
            CdnServiceImpl.create(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          isEdit ? "Edit Sampling" : "Tambah Sampling",
        ),
        body: BlocConsumer<ActivitySamplingAddCubit, ActivitySamplingAddState>(
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
                  ? "Berhasil Edit\nSampling!"
                  : "Berhasil Membuat\nSampling Baru!");
              Navigator.of(context).pop();
              if (isEdit) {
                Navigator.of(context).pop("refresh");
              }
            }
          },
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ActivitySamplingAddView(
              fishpondId,
              fishpondcycleId,
              isEdit,
              data,
            );
          },
        ),
      ),
    );
  }
}
