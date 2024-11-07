import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/logic/checkout_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class CheckoutPage extends StatelessWidget {
  final ProductsResponseData data;

  const CheckoutPage(this.data, {super.key});

  static const RouteSettings route = RouteSettings(name: '/checkout-page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => CheckoutCubit(),
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
            AppTopSnackBar(context).showSuccess('Checkout Success');
            // Navigator.of(context).pop();
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
          body: CheckoutView(data),
        ),
      ),
    );
  }
}
