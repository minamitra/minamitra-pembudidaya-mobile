import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_finisher_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_grower_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_starter_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed/feed_endpoint.dart';

abstract class FeedService {
  Future<BaseResponse<FeedStarterResponse>> getFeedStarter();
  Future<BaseResponse<FeedGrowerResponse>> getFeedGrower();
  Future<BaseResponse<FeedFinisherResponse>> getFeedFinisher();
}

class FeedServiceImpl implements FeedService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final FeedEndpoint endpoint;

  FeedServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory FeedServiceImpl.create() {
    return FeedServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: FeedEndpoint(),
    );
  }

  @override
  Future<BaseResponse<FeedFinisherResponse>> getFeedFinisher() async {
    final uri = endpoint.getFeed("finisher");
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedFinisherResponse data =
        FeedFinisherResponse.fromMap(metaResponse.result!);

    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<FeedGrowerResponse>> getFeedGrower() async {
    final uri = endpoint.getFeed("grower");
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedGrowerResponse data =
        FeedGrowerResponse.fromMap(metaResponse.result!);

    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<FeedStarterResponse>> getFeedStarter() async {
    final uri = endpoint.getFeed("starter");
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedStarterResponse data =
        FeedStarterResponse.fromMap(metaResponse.result!);

    return BaseResponse(meta: metaResponse, data: data);
  }
}
