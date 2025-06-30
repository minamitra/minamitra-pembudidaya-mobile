import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ProductEndpoint {
  ProductEndpoint();

  Uri categoryProduct() {
    return createUrl(path: 'mitra/item-category/data');
  }

  Uri dataProduct(
    String search,
    String categoryId, {
    String? limit,
  }) {
    return createUrl(
      path: 'mitra/item/data',
      queryParameters: {
        'name[lse]': search,
        'category_id': categoryId,
        if (limit == null) 'pagination_bool': 'false',
        if (limit != null) 'limit': limit,
      },
    );
  }

  Uri detailProduct(String id) {
    return createUrl(
      path: 'mitra/item/detail',
      queryParameters: {
        'id': id,
      },
    );
  }
}
