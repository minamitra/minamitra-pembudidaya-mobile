import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/home/home_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/home_response.dart';

abstract class HomeService {
  Future<BaseResponse<HomeResponse>> homeBanner();
}

class HomeServiceImpl implements HomeService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final HomeEndpoint endpoint;

  HomeServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory HomeServiceImpl.create() {
    return HomeServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: HomeEndpoint(),
    );
  }

  @override
  Future<BaseResponse<HomeResponse>> homeBanner() async {
    final url = endpoint.getHomeBanner();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final HomeResponse homeResponse =
        HomeResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: homeResponse);
  }
}
