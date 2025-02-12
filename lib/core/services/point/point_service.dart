import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/repositories/point_exchange_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/mission_point_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_configuration_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_history_response.dart';

abstract class PointService {
  Future<BaseResponse<PointBalanceResponse>> pointBalance();
  Future<BaseResponse<PointHistoryResponse>> pointHistory({String? dateTime});
  Future<BaseResponse<PointConfigurationResponse>> pointConfiguration();
  Future<BaseResponse<bool>> pointExchange({
    required String type,
    required int point,
    required int nominlaRP,
    required String notes,
  });
  Future<BaseResponse<PointExchangeHistoryResponse>> pointExchangeHistory({
    required String type,
    String? status,
    String? createdDateTime,
  });
  Future<BaseResponse<MissionPointResponse>> pointMission();
}

class PointServiceImpl implements PointService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final PointEndpoint endpoint;

  PointServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory PointServiceImpl.create() {
    return PointServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: PointEndpoint(),
    );
  }

  @override
  Future<BaseResponse<PointBalanceResponse>> pointBalance() async {
    final url = endpoint.getPointBalance();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PointBalanceResponse pointBalanceResponse =
        PointBalanceResponse.fromMap(meta.result!);
    return BaseResponse(
      meta: meta,
      data: pointBalanceResponse,
    );
  }

  @override
  Future<BaseResponse<PointHistoryResponse>> pointHistory({
    String? dateTime,
  }) async {
    final url = endpoint.getPointHistory(dateTime);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PointHistoryResponse pointHistoryResponse =
        PointHistoryResponse.fromMap(meta.result!);
    return BaseResponse(
      meta: meta,
      data: pointHistoryResponse,
    );
  }

  @override
  Future<BaseResponse<PointConfigurationResponse>> pointConfiguration() async {
    final url = endpoint.getPointConfiguration();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PointConfigurationResponse pointConfigurationResponse =
        PointConfigurationResponse.fromMap(meta.result!);
    return BaseResponse(
      meta: meta,
      data: pointConfigurationResponse,
    );
  }

  @override
  Future<BaseResponse<bool>> pointExchange({
    required String type,
    required int point,
    required int nominlaRP,
    required String notes,
  }) async {
    final url = endpoint.postPointExchange();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      json.encode({
        'type': type,
        'nominal_poin': point,
        'nominal_rp': nominlaRP,
        'note': notes,
        'attachment_json_array': [],
      }),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: meta,
      data: meta.status == 200,
    );
  }

  @override
  Future<BaseResponse<PointExchangeHistoryResponse>> pointExchangeHistory({
    required String type,
    String? status,
    String? createdDateTime,
  }) async {
    final url = endpoint.getPointExchangeHistory(
      status,
      type,
      createdDateTime,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PointExchangeHistoryResponse pointExchangeHistoryResponse =
        PointExchangeHistoryResponse.fromMap(meta.result!);
    return BaseResponse(
      meta: meta,
      data: pointExchangeHistoryResponse,
    );
  }

  @override
  Future<BaseResponse<MissionPointResponse>> pointMission() async {
    final url = endpoint.getPointMission();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final MissionPointResponse missionPointResponse =
        MissionPointResponse.fromMap(meta.result!);
    return BaseResponse(
      meta: meta,
      data: missionPointResponse,
    );
  }
}
