import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_endpoint.dart';

abstract class LiteracyInformationService {
  Future<BaseResponse<LiteracyInformationResponse>> literacyInformations({
    String? page,
    String? limit,
  });
  Future<BaseResponse<LiteracyInformationResponseData>>
      literacyInformationDetail({required String id});
}

class LiteracyInformationServiceImpl implements LiteracyInformationService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final LiteracyInformationEndpoint endpoint;

  LiteracyInformationServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory LiteracyInformationServiceImpl.create() {
    return LiteracyInformationServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: LiteracyInformationEndpoint(),
    );
  }

  @override
  Future<BaseResponse<LiteracyInformationResponse>> literacyInformations({
    String? page,
    String? limit,
  }) async {
    final uri = endpoint.getLiteracyInformations(
      page: page ?? '1',
      limit: limit ?? '7',
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final LiteracyInformationResponse literacyInformationResponse =
        LiteracyInformationResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: literacyInformationResponse,
    );
  }

  @override
  Future<BaseResponse<LiteracyInformationResponseData>>
      literacyInformationDetail({required String id}) async {
    final uri = endpoint.getLiteracyInformationDetail(id);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final LiteracyInformationResponseData data =
        LiteracyInformationResponseData.fromMap(meta.result!['data']);
    return BaseResponse(
      meta: meta,
      data: data,
    );
  }
}
