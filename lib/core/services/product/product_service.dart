import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/product/product_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/product_category_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';

abstract class ProductService {
  Future<BaseResponse<ProductCategoryResponse>> categoryProduct();
  Future<BaseResponse<ProductsResponse>> dataProducts(
      String search, String categoryId);
}

class ProductServiceImpl implements ProductService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ProductEndpoint endpoint;

  ProductServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ProductServiceImpl.create() {
    return ProductServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ProductEndpoint(),
    );
  }

  @override
  Future<BaseResponse<ProductCategoryResponse>> categoryProduct() async {
    final url = endpoint.categoryProduct();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final ProductCategoryResponse productCategoryResponse =
        ProductCategoryResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: productCategoryResponse);
  }

  @override
  Future<BaseResponse<ProductsResponse>> dataProducts(
      String search, String categoryId) async {
    final url = endpoint.dataProduct(search, categoryId);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final ProductsResponse productsResponse =
        ProductsResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: productsResponse);
  }
}
