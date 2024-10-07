import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/add_water_quality_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/update_water_quality_payload.dart';

abstract class ActivityWaterQualityService {
  Future<BaseResponse<WaterQualityResponse>> dataWaterQuality(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  );
  Future<BaseResponse<bool>> addWaterQuality(AddWaterQualityPayload payload);
  Future<BaseResponse<bool>> deleteWaterQuality(String id);
  Future<BaseResponse<bool>> updateWaterQuality(
      UpdateWaterQualityPayload payload);
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
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> deleteWaterQuality(String id) async {
    final url = endpoint.deleteWaterQuality();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      json.encode({"id": id}),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> updateWaterQuality(
      UpdateWaterQualityPayload payload) async {
    final url = endpoint.updateWaterQuality();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }
}
