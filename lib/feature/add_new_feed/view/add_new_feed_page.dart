import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feer_recomendation_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/logic/add_new_feed_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/view/add_new_feed_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddNewFeedPage extends StatelessWidget {
  const AddNewFeedPage(
    this.fishpondId,
    this.feedRecomendationResponse, {
    super.key,
  });

  static const RouteSettings routeSettings =
      RouteSettings(name: '/add-new-feed-page');

  final int fishpondId;
  final FeedRecomendationResponse? feedRecomendationResponse;

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => AddNewFeedCubit(
        FeedActivityServiceImpl.create(),
        PublicServiceImpl.create(),
      )..init(
          fishpondId,
          feedRecomendationResponse ?? FeedRecomendationResponse(),
        ),
      child: BlocListener<AddNewFeedCubit, AddNewFeedState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == 'TOKEN_EXPIRED') {
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
            AppTopSnackBar(context).showSuccess('Berhasil menambah pakan baru');
            Navigator.of(context).pop(true);
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            'Tambah Pakan Baru',
          ),
          body: const AddNewFeedView(),
        ),
      ),
    );
  }
}
