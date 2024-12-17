import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bank/bank_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/logic/checkout_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/views/dashboard_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class CheckoutPage extends StatelessWidget {
  final ProductsResponseData data;
  final bool isProductPromo;

  const CheckoutPage(
    this.data, {
    this.isProductPromo = false,
    super.key,
  });

  static const RouteSettings route = RouteSettings(name: '/checkout-page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => CheckoutCubit(
        DeliveryAddressServiceImpl.create(),
        BankServiceImpl.create(),
        TransactionServiceImpl.create(),
      )..init(data),
      child: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == 'TOKEN_EXPIRED') {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }

          if (state.status == GlobalState.successSubmit) {
            AppTopSnackBar(context).showSuccess('Pesanan berhasil dibuat');
            Navigator.of(context).pop('changeBottomNav1');
            // Navigator.of(context).popUntil(
            //   ModalRoute.withName(DashboardPage.routeSettings().name!),
            // );
          }

          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            'Checkout',
          ),
          backgroundColor: AppColor.neutral[100],
          body: CheckoutView(
            data,
            isProductPromo,
          ),
        ),
      ),
    );
  }
}
