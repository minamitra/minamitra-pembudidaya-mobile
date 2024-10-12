import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/add_fish_feed_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feed_data_by_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feer_recomendation_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/recommendation_feed_bulk_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/save_bulk_body.dart';

abstract class FeedActivityService {
  Future<BaseResponse<FeedActivityResponse>> getData(
    String fishPondCycleID,
    String dateTime,
  );
  Future<BaseResponse<FeedRecomendationResponse>> getRecommendation(
    String fishPondCycleID,
    String fishAge,
  );
  Future<BaseResponse<FeedDataByCycleResponse>> getFeedDataByCycle(
    String fishPondCycleID,
    String dateTime,
  );
  Future<BaseResponse<bool>> postAddFishFeed(
    AddFishFeedBody data, {
    bool isCreateData = true,
  });
  Future<BaseResponse<bool>> deleteFeedActivity(String id);
  Future<BaseResponse<RecommendationFeedBulk>> getRecommendationFeedBulk(
    String fishPondCycleID,
    String date,
  );
  Future<BaseResponse<bool>> saveFeedBulkData(SaveBulkBody saveBulkBody);
}

class FeedActivityServiceImpl implements FeedActivityService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final FeedActivityEndpoint endpoint;

  FeedActivityServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory FeedActivityServiceImpl.create() {
    return FeedActivityServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: FeedActivityEndpoint(),
    );
  }

  @override
  Future<BaseResponse<FeedActivityResponse>> getData(
    String fishPondCycleID,
    String dateTime,
  ) async {
    final uri = endpoint.getData(fishPondCycleID, dateTime);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedActivityResponse data =
        FeedActivityResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<FeedRecomendationResponse>> getRecommendation(
    String fishPondCycleID,
    String fishAge,
  ) async {
    final uri = endpoint.getRecommendation(fishPondCycleID, fishAge);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedRecomendationResponse data =
        FeedRecomendationResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<FeedDataByCycleResponse>> getFeedDataByCycle(
    String fishPondCycleID,
    String dateTime,
  ) async {
    final uri = endpoint.getFishFeedByCycle(fishPondCycleID, dateTime);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final FeedDataByCycleResponse data =
        FeedDataByCycleResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<bool>> postAddFishFeed(
    AddFishFeedBody addFishFeedBody, {
    bool isCreateData = true,
  }) async {
    final uri = endpoint.postFishFeed(isCreateData);
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      isCreateData ? addFishFeedBody.toJson() : addFishFeedBody.toEditJson(),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: metaResponse, data: true);
  }

  @override
  Future<BaseResponse<bool>> deleteFeedActivity(String id) async {
    final uri = endpoint.deleteFishActivity();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({"id": id}),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: metaResponse, data: true);
  }

  @override
  Future<BaseResponse<RecommendationFeedBulk>> getRecommendationFeedBulk(
    String fishPondCycleID,
    String date,
  ) async {
    final uri = endpoint.getFeedRecommendationBulk(fishPondCycleID, date);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final RecommendationFeedBulk data =
        RecommendationFeedBulk.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<bool>> saveFeedBulkData(SaveBulkBody saveBulkBody) async {
    final uri = endpoint.postBulkFeed();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode(saveBulkBody.toMap()),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: metaResponse, data: true);
  }
}
