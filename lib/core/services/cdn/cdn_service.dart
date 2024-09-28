import 'dart:io';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/cdn_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_endpoint.dart';

abstract class CdnService {
  Future<BaseResponse<CDNImageResponse>> uploadImage(File file);
}

class CdnServiceImpl implements CdnService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final CdnEndpoint endpoint;

  CdnServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  @override
  Future<BaseResponse<CDNImageResponse>> uploadImage(File file) async {
    final uri = endpoint.imageEndpoint();
    final header = await headerProvider.headers;
    final response = await httpClient.multipartPost(
      uri,
      header,
      {"image": file},
      {},
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: CDNImageResponse.fromMap(metaResponse.result!),
    );
  }

  factory CdnServiceImpl.create() {
    return CdnServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: CdnEndpoint(),
    );
  }
}
