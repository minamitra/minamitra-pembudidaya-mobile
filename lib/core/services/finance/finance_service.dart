import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/repositories/add_other_cost_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_summary_response.dart';

abstract class FinanceService {
  Future<BaseResponse<FinanceSummaryResponse>> financeSummary(
    String fishPondID,
  );
  Future<BaseResponse<FinanceResponse>> finance(
    String fishPondID, {
    String? fishPondCycleID,
  });
  Future<BaseResponse<FishpondCycleCostResponse>> fishPondCycleCost(
    String fishPondCycleID,
  );
  Future<BaseResponse<bool>> addOtherCost(AddOtherCostBody body);
  Future<BaseResponse<bool>> updateOtherCost(AddOtherCostBody body);
  Future<BaseResponse<bool>> deleteOtherCost(String otherCostID);
}

class FinanceServiceImpl implements FinanceService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final FinanceEndpoint endpoint;

  FinanceServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory FinanceServiceImpl.create() {
    return FinanceServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: FinanceEndpoint(),
    );
  }

  @override
  Future<BaseResponse<FinanceSummaryResponse>> financeSummary(
    String fishPondID,
  ) async {
    final url = endpoint.getSummary(fishPondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final FinanceSummaryResponse data =
        FinanceSummaryResponse.fromMap(meta.result!);
    return BaseResponse(
      data: data,
      meta: meta,
    );
  }

  @override
  Future<BaseResponse<FinanceResponse>> finance(
    String fishPondID, {
    String? fishPondCycleID,
  }) async {
    final url = endpoint.getFinancePerCycle(
      fishPondID,
      fishPondCycleID: fishPondCycleID,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final FinanceResponse data = FinanceResponse.fromMap(meta.result!);
    return BaseResponse(
      data: data,
      meta: meta,
    );
  }

  @override
  Future<BaseResponse<FishpondCycleCostResponse>> fishPondCycleCost(
    String fishPondCycleID,
  ) async {
    final uri = endpoint.getFisphPondCycleCost(fishPondCycleID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final FishpondCycleCostResponse data =
        FishpondCycleCostResponse.fromMap(meta.result!);
    return BaseResponse(
      data: data,
      meta: meta,
    );
  }

  @override
  Future<BaseResponse<bool>> addOtherCost(AddOtherCostBody body) async {
    final url = endpoint.postAddOtherCost();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      body.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(
      data: true,
      meta: meta,
    );
  }

  @override
  Future<BaseResponse<bool>> updateOtherCost(AddOtherCostBody body) async {
    final url = endpoint.postUpdateOtherCost();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      body.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(
      data: true,
      meta: meta,
    );
  }

  @override
  Future<BaseResponse<bool>> deleteOtherCost(String otherCostID) async {
    final uri = endpoint.postDeleteCost();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({
        'id': int.parse(otherCostID),
      }),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(
      data: true,
      meta: meta,
    );
  }
}
