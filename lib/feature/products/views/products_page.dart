import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/product/product_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/logics/product_category_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/logics/products_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_view.dart';

class ProductsPage extends StatelessWidget {
  final bool isPick;

  const ProductsPage({this.isPick = false, super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Belanja",
        actions: [
          Image.asset(
            AppAssets.basketIcon,
            height: 20.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
          Image.asset(
            AppAssets.bellIcon,
            height: 20.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsCubit(
              ProductServiceImpl.create(),
            )..getProducts(),
          ),
          BlocProvider(
            create: (context) => ProductCategoryCubit(
              ProductServiceImpl.create(),
            )..getCategoryProduct(),
          ),
        ],
        child: ProductsView(isPick),
      ),
    );
  }
}
