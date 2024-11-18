import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/logic/transaction_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/views/transaction_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => TransactionCubit(
        TransactionServiceImpl.create(),
        CdnServiceImpl.create(),
      ),
      child: BlocListener<TransactionCubit, TransactionState>(
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
            context.read<TransactionCubit>().getWaitingDatas();
            context.read<TransactionCubit>().getProcessDatas();
            context.read<TransactionCubit>().getDoneDatas();
            context.read<TransactionCubit>().getCanceledDatas();
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBarWithBucket(
            context,
            'Transaksi',
            isBackButton: false,
          ),
          body: const TransactionView(),
        ),
      ),
    );
  }
}
