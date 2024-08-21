import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/product_detail/product_detail_view.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/products-detail");

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductDetailView(),
    );
  }
}
