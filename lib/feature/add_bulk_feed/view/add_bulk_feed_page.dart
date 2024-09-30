import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/logic/add_bulk_feed_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/view/add_bulk_feed_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddBulkFeedPage extends StatelessWidget {
  const AddBulkFeedPage(this.pondID, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/add-bulk-feed-page");

  final String pondID;

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) =>
          AddBulkFeedCubit(FeedActivityServiceImpl.create())..init(pondID),
      child: BlocListener<AddBulkFeedCubit, AddBulkFeedState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == "TOKEN_EXPIRED") {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }

          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }

          if (state.status.isSuccessSubmit) {
            AppTopSnackBar(context).showSuccess("Berhasil menambahkan pakan");
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Tambah Pakan",
          ),
          body: AddBulkFeedView(),
        ),
      ),
    );
  }
}
