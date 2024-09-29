import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/add_water_quality_payload.dart';

abstract class ActivityWaterQualityService {
  Future<BaseResponse<WaterQualityResponse>> dataWaterQuality(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  );
  Future<BaseResponse<bool>> addWaterQuality(AddWaterQualityPayload payload);
}

class ActivityWaterQualityServiceImpl implements ActivityWaterQualityService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ActivityWaterQualityEndpoint endpoint;

  ActivityWaterQualityServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ActivityWaterQualityServiceImpl.create() {
    return ActivityWaterQualityServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ActivityWaterQualityEndpoint(),
    );
  }

  @override
  Future<BaseResponse<WaterQualityResponse>> dataWaterQuality(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    final url = endpoint.dataWaterQuality(
      fishpondId,
      fishpondcycleId,
      datetime,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final WaterQualityResponse treatmentResponse =
        WaterQualityResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: treatmentResponse);
  }

  @override
  Future<BaseResponse<bool>> addWaterQuality(
      AddWaterQualityPayload payload) async {
    final url = endpoint.addWaterQuality();
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
