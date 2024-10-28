import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/harvest_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/repositories/ongoing_cycle_feed_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/graph_response.dart';

abstract class CycleService {
  Future<BaseResponse<OnGoingCycleFeedResponse>> getOngoingCycle({
    String status = "active",
    String? fishpondID,
    String? lastPondCycleID,
  });
  Future<BaseResponse<FeedCycleHistoryResponse>> getFeedCycleHistory({
    required String pondID,
    String status = "active",
  });
  Future<BaseResponse<bool>> addHarvest({required HarvestBody body});
  Future<BaseResponse<bool>> updateHarvestDone({required String id});
  Future<BaseResponse<GraphResponse>> getGraphData({
    required String pondCycleID,
    required String filterName,
  });
  Future<BaseResponse<CompanionNotesResponse>> getCompanionNotes({
    required String pondCycleID,
    String? filterStartDate,
    String? filterEndDate,
    String? companionName,
  });
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
    String? lastPondCycleID,
  }) async {
    final uri = endpoint.getOngoingCycle(
      status: status,
      fishpondID: fishpondID,
      lastPondCycleID: lastPondCycleID,
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
  Future<BaseResponse<bool>> addHarvest({required HarvestBody body}) async {
    final uri = endpoint.postHarvest();
    final header = await headerProvider.headers;
    final response = await httpClient.post(uri, header, body.toJson());
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> updateHarvestDone({required String id}) async {
    final uri = endpoint.updateHarvestDone();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode(
        {
          "id": id,
          "status": "done",
        },
      ),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<GraphResponse>> getGraphData({
    required String pondCycleID,
    required String filterName,
  }) async {
    final uri = endpoint.getGraph(
      pondCycleID: pondCycleID,
      filterName: filterName,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final GraphResponse data = GraphResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<CompanionNotesResponse>> getCompanionNotes({
    required String pondCycleID,
    String? filterStartDate,
    String? filterEndDate,
    String? companionName,
  }) async {
    final uri = endpoint.getCompanionNotes(
      pondCycleID,
      filterStartDate: filterStartDate,
      filterEndDate: filterEndDate,
      companionName: companionName,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final CompanionNotesResponse data =
        CompanionNotesResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }
}
