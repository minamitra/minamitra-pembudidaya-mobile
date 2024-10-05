import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_view.dart';

class TransactionDetailPage extends StatelessWidget {
  final List<ProductsResponseData> listProduct;
  final List<int> listAmountItem;
  final Address address;
  final MethodPaymentData methodPayment;

  const TransactionDetailPage(
    this.listProduct,
    this.listAmountItem,
    this.address,
    this.methodPayment, {
    super.key,
  });

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/transaction-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Rincian Pesanan",
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
        ),
      ),
    );
  }
}
