import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/repositories/transaction_item_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/logic/transaction_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class TransactionDetailPage extends StatelessWidget {
  final List<ProductsResponseData> listProduct;
  final List<int> listAmountItem;
  final Address address;
  final MethodPaymentData methodPayment;
  final TransactionItemResponseData data;

  const TransactionDetailPage(
    this.listProduct,
    this.listAmountItem,
    this.address,
    this.methodPayment,
    this.data, {
    super.key,
  });

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/transaction-detail');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => TransactionDetailCubit(
        TransactionServiceImpl.create(),
        CdnServiceImpl.create(),
      )..init(
          data.status == 'Dikirim' || data.status == 'Selesai',
          orderID: data.id.toString(),
        ),
      child: BlocListener<TransactionDetailCubit, TransactionDetailState>(
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
            AppTopSnackBar(context).showSuccess('Success');
            Navigator.of(context).pop('refresh');
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            'Rincian Pesanan',
          ),
          backgroundColor: AppColor.neutral[100],
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MultiImageCubit(),
              ),
            ],
            child: TransactionDetailView(
              listProduct,
              listAmountItem,
              address,
              methodPayment,
              data,
            ),
          ),
        ),
      ),
    );
  }
}
