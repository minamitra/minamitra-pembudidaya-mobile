import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/add_pond_cycle_payload.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_dashboard_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/add_pond_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/add_pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/update_pond_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/update_pond_response.dart';

abstract class PondService {
  Future<BaseResponse<AddPondResponse>> addPond(AddPondPayload payload);
  Future<BaseResponse<bool>> addPondCycle(AddPondCyclePayload payload);
  Future<BaseResponse<PondResponse>> getPonds();
  Future<BaseResponse<PondDashboardResponse>> getPondsDashboard(
      {String? pondID});
  Future<BaseResponse<bool>> deletePond(String pondID);
  Future<BaseResponse<UpdatePondResponse>> updatePond(
      UpdatePondPayload payload);
}

class PondServiceImpl implements PondService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final PondEndpoint endpoint;

  PondServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory PondServiceImpl.create() {
    return PondServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: PondEndpoint(),
    );
  }

  @override
  Future<BaseResponse<AddPondResponse>> addPond(AddPondPayload payload) async {
    final url = endpoint.addPond();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final AddPondResponse data = AddPondResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<bool>> addPondCycle(AddPondCyclePayload payload) async {
    final url = endpoint.addPondCycle();
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
  Future<BaseResponse<PondResponse>> getPonds() async {
    final url = endpoint.getPond();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PondResponse data = PondResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<PondDashboardResponse>> getPondsDashboard(
      {String? pondID}) async {
    final url = endpoint.getPondDashboard(pondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final PondDashboardResponse data =
        PondDashboardResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<bool>> deletePond(String pondID) async {
    final url = endpoint.deletePond();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      json.encode({"id": int.parse(pondID)}),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<UpdatePondResponse>> updatePond(
      UpdatePondPayload payload) async {
    final url = endpoint.updatePond();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final UpdatePondResponse data = UpdatePondResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }
}
