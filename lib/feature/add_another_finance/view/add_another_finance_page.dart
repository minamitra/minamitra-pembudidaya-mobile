import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/logic/add_another_finance_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/view/add_another_finance_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddAnotherFinancePage extends StatelessWidget {
  const AddAnotherFinancePage({
    this.fishPondCycleID,
    this.isRequiredCycleID = true,
    this.otherCostData,
    this.fishPondID,
    required this.tebarDate,
    super.key,
  });

  final String? fishPondCycleID;
  final bool isRequiredCycleID;
  final FishpondCycleCostResponseData? otherCostData;
  final String? fishPondID;
  final DateTime tebarDate;

  static RouteSettings route() =>
      const RouteSettings(name: '/Add-Another-Finance-Page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => AddAnotherFinanceCubit(
        CdnServiceImpl.create(),
        FinanceServiceImpl.create(),
      )..init(
          otherCostData,
          fishpondCycleID: int.parse(fishPondCycleID ?? '0'),
          fishpondID: int.parse(fishPondID ?? '0'),
        ),
      child: BlocListener<AddAnotherFinanceCubit, AddAnotherFinanceState>(
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
            Navigator.of(context).pop('refresh');
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            'Tambah Keuangan',
          ),
          body: AddAnotherFinanceView(
            isRequiredCycleID: isRequiredCycleID,
            otherCostData: otherCostData,
            tebarDate: tebarDate,
          ),
        ),
      ),
    );
  }
}
