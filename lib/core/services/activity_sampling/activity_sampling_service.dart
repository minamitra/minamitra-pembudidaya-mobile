import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/sampling_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/repositories/add_sampling_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/repositories/update_sampling_payload.dart';

abstract class ActivitySamplingService {
  Future<BaseResponse<SamplingResponse>> dataSampling(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  );
  Future<BaseResponse<bool>> addSampling(AddSamplingPayload payload);
  Future<BaseResponse<bool>> deleteSampling(String id);
  Future<BaseResponse<bool>> updateSampling(UpdateSamplingPayload payload);
}

class ActivitySamplingServiceImpl implements ActivitySamplingService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ActivitySamplingEndpoint endpoint;

  ActivitySamplingServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ActivitySamplingServiceImpl.create() {
    return ActivitySamplingServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ActivitySamplingEndpoint(),
    );
  }

  @override
  Future<BaseResponse<SamplingResponse>> dataSampling(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    final url = endpoint.dataSampling(
      fishpondId,
      fishpondcycleId,
      datetime,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final SamplingResponse treatmentResponse =
        SamplingResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: treatmentResponse);
  }

  @override
  Future<BaseResponse<bool>> addSampling(AddSamplingPayload payload) async {
    final url = endpoint.addSampling();
    final header = await headerProvider.headers;
    final response = await httpClient.multipartPost(
      url,
      header,
      {},
      payload.toMap(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> deleteSampling(String id) async {
    final url = endpoint.deleteSampling();
    final header = await headerProvider.headers;
    final response = await httpClient.multipartPost(
      url,
      header,
      {},
      {"id": id},
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> updateSampling(
      UpdateSamplingPayload payload) async {
    final url = endpoint.updateSampling();
    final header = await headerProvider.headers;
    final response = await httpClient.multipartPost(
      url,
      header,
      {},
      payload.toMap(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }
}
