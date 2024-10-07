import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/logic/activity_activities_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/views/activity_activities_add_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ActivityActivitiesAddPage extends StatelessWidget {
  const ActivityActivitiesAddPage(
    this.fishPondID,
    this.fishPondCycleID,
    this.tebarDate, {
    this.editData,
    super.key,
  });

  final String fishPondID;
  final String fishPondCycleID;
  final DateTime tebarDate;

  final FeedActivityResponseData? editData;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/activity-activities-add");

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) =>
          ActivityActivitiesAddCubit(FeedActivityServiceImpl.create())
            ..init(
              fishPondID,
              fishPondCycleID,
              tebarDate,
              selectedDate: editData?.datetime,
            ),
      child:
          BlocConsumer<ActivityActivitiesAddCubit, ActivityActivitiesAddState>(
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
            if (editData != null) {
              AppTopSnackBar(context)
                  .showSuccess("Berhasil mengubah aktivitas");
              Navigator.of(context).pop("refresh");
              Navigator.of(context).pop("refresh");
            } else {
              AppTopSnackBar(context)
                  .showSuccess("Berhasil menambahkan aktivitas");
              Navigator.of(context).pop("refresh");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appDefaultAppBar(
              context,
              "Tambah Aktivitas",
            ),
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false,
            body: ActivityActivitiesAddView(
              tebarDate,
              editData: editData,
            ),
          );
        },
      ),
    );
  }
}
