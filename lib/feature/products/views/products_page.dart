import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
      body: const ProductsView(),
    );
  }
}
