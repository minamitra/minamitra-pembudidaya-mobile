import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/repositories/ongoing_cycle_feed_response.dart';

abstract class CycleService {
  Future<BaseResponse<OnGoingCycleFeedResponse>> getOngoingCycle({
    String status = "active",
    String? fishpondID,
  });
  Future<BaseResponse<FeedCycleHistoryResponse>> getFeedCycleHistory({
    required String pondID,
    String status = "active",
  });
  Future<BaseResponse<bool>> addHarvest();
}

class CycleServiceImpl implements CycleService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final CycleEndpoint endpoint;

  CycleServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory CycleServiceImpl.create() {
    return CycleServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: CycleEndpoint(),
    );
  }

  @override
  Future<BaseResponse<OnGoingCycleFeedResponse>> getOngoingCycle({
    String status = "active",
    String? fishpondID,
  }) async {
    final uri = endpoint.getOngoingCycle(
      status: status,
      fishpondID: fishpondID,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final OnGoingCycleFeedResponse data =
        OnGoingCycleFeedResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<FeedCycleHistoryResponse>> getFeedCycleHistory({
    String status = "active",
    required String pondID,
  }) async {
    final uri = status == "ready"
        ? endpoint.getFeedCycleHistory(
            pondID: pondID,
            status: "active",
            firstDate: AppConvertDateTime().ymdDash(DateTime.now()),
            lastDate: AppConvertDateTime()
                .ymdDash(DateTime.now().add(const Duration(days: 30))),
          )
        : endpoint.getFeedCycleHistory(
            pondID: pondID,
            status: status,
          );
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final FeedCycleHistoryResponse feedCycleHistoryResponse =
        FeedCycleHistoryResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: feedCycleHistoryResponse);
  }

  @override
  Future<BaseResponse<bool>> addHarvest() async {
    final uri = endpoint.postHarvest();
    final header = await headerProvider.headers;
    final response = await httpClient.post(uri, header, jsonEncode({}));
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }
}
