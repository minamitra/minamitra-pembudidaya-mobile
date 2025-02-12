import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/view/bill_payment_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_confirmation_payed/logic/bill_payment_confirmation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_confirmation_payed/view/bill_payment_confirmation_payed_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/waiting_payment_page.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class BillPaymentConfirmationPayedPage extends StatelessWidget {
  const BillPaymentConfirmationPayedPage(
    this.selectedPayment,
    this.totalBillPayed,
    this.billResponseData, {
    super.key,
  });

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/bill-payment-confirmation-payed-page');
  }

  final SelectedPayment selectedPayment;
  final int totalBillPayed;
  final BillResponseData billResponseData;

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => BillPaymentConfirmationCubit(
        CdnServiceImpl.create(),
        BillServiceImpl.create(),
      ),
      child: BlocListener<BillPaymentConfirmationCubit,
          BillPaymentConfirmationState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.message == 'TOKEN_EXPIRED') {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.message);
            }
          }

          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }

          if (state.status.isSuccessSubmit) {
            Navigator.of(context).pushAndRemoveUntil(
              AppTransition.pushAndRemoveUntilTransition(
                WaitingPaymentPage(
                  selectedPayment,
                  state.notes,
                  totalBillPayed,
                ),
                WaitingPaymentPage.routeSettings(),
              ),
              ModalRoute.withName(BillPaymentPage.routeSettings.name!),
            );
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            'Konfirmasi Pembayaran',
          ),
          body: BillPaymentConfirmationPayedView(
            selectedPayment,
            totalBillPayed,
            billResponseData,
          ),
        ),
      ),
    );
  }
}
