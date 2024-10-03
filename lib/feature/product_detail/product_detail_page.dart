import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/product_detail/product_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductsResponseData data;

  const ProductDetailPage(this.data, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/products-detail");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral[50],
      body: ProductDetailView(data),
    );
  }
}
