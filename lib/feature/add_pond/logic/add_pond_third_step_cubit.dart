import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_finisher_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_grower_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_starter_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/seed_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed/feed_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/commodity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/ahp/ahp.dart';

part 'add_pond_third_step_state.dart';

class AddPondThirdStepCubit extends Cubit<AddPondThirdStepState> {
  AddPondThirdStepCubit(this.feedService)
      : super(const AddPondThirdStepState());

  final FeedService feedService;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController fishCountController = TextEditingController();
  final TextEditingController spreadController = TextEditingController();
  final TextEditingController seedOriginController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController pakanStarter1Controller = TextEditingController();
  final TextEditingController pakanStarter2Controller = TextEditingController();
  final TextEditingController pakanStarter3Controller = TextEditingController();
  final TextEditingController survivalRateController = TextEditingController();
  final TextEditingController pakanGrowerController = TextEditingController();
  final TextEditingController pakanFinisherController = TextEditingController();
  final TextEditingController commodityController = TextEditingController();
  String seedID = '0';
  String commodityID = '0';

  Future<FeedStarterResponse> loadJsonAssetStarter(String asset) async {
    final String jsonString = await rootBundle.loadString(asset);
    FeedStarterResponse feedStarterResponse =
        FeedStarterResponse.fromMap(jsonDecode(jsonString));
    return feedStarterResponse;
  }

  Future<FeedGrowerResponse> loadJsonAssetGrower(String asset) async {
    final String jsonString = await rootBundle.loadString(asset);
    FeedGrowerResponse feedGrowerResponse =
        FeedGrowerResponse.fromMap(jsonDecode(jsonString));
    return feedGrowerResponse;
  }

  Future<FeedFinisherResponse> loadJsonAssetFinisher(String asset) async {
    final String jsonString = await rootBundle.loadString(asset);
    FeedFinisherResponse feedFinisherResponse =
        FeedFinisherResponse.fromMap(jsonDecode(jsonString));
    return feedFinisherResponse;
  }

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final feedStarter1Response =
          await loadJsonAssetStarter('assets/json/pakan_starter_1.json');
      final feedStarter2Response =
          await loadJsonAssetStarter('assets/json/pakan_starter_2.json');
      final feedStarter3Response =
          await loadJsonAssetStarter('assets/json/pakan_starter_3.json');
      final feedGrowerResponse =
          await loadJsonAssetGrower('assets/json/pakan_grower.json');
      final feedFinisherResponse =
          await loadJsonAssetFinisher('assets/json/pakan_finisher.json');

      // final feedStarter1Response = await feedService.getFeedStarter('starter1');
      // final feedStarter2Response = await feedService.getFeedStarter('starter2');
      // final feedStarter3Response = await feedService.getFeedStarter('starter3');
      // final feedGrowerResponse = await feedService.getFeedGrower();
      // final feedFinisherResponse = await feedService.getFeedFinisher();
      final seedResponse = await feedService.getSeed();
      final commodityResponse = await feedService.getCommodity();
      SeedResponse seedCleaningData = seedResponse.data;
      seedCleaningData = seedCleaningData.copyWith(
        data: [
          ...seedCleaningData.data ?? [],
          SeedResponseData(id: '-1', name: 'Benih Baru'),
        ],
      );

      // calculate AHP
      List<String> tempResult = ahp();

      final feedStarter1Recommend = feedStarter1Response.data?.firstWhere(
        (element) => element.name == tempResult[0],
      );
      final feedStarter2Recommend = feedStarter2Response.data?.firstWhere(
        (element) => element.name == tempResult[1],
      );
      final feedStarter3Recommend = feedStarter3Response.data?.firstWhere(
        (element) => element.name == tempResult[2],
      );
      final feedGrowerRecommend = feedGrowerResponse.data?.firstWhere(
        (element) => element.name == tempResult[3],
      );
      final feedFinisherRecommend = feedFinisherResponse.data?.firstWhere(
        (element) => element.name == tempResult[4],
      );

      emit(
        // state.copyWith(
        //   feedStarter1Data: feedStarter1Response.data,
        //   feedStarter2Data: feedStarter2Response.data,
        //   feedStarter3Data: feedStarter3Response.data,
        //   feedGrowerData: feedGrowerResponse.data,
        //   feedFinisherData: feedFinisherResponse.data,
        //   seedResponse: seedCleaningData,
        //   commodityData: commodityResponse.data.data,
        //   status: GlobalState.loaded,
        // ),
        state.copyWith(
          feedStarter1Data: feedStarter1Response,
          feedStarter2Data: feedStarter2Response,
          feedStarter3Data: feedStarter3Response,
          feedGrowerData: feedGrowerResponse,
          feedFinisherData: feedFinisherResponse,
          seedResponse: seedCleaningData,
          commodityData: commodityResponse.data.data,
          recommendStarter1: feedStarter1Recommend,
          recommendStarter2: feedStarter2Recommend,
          recommendStarter3: feedStarter3Recommend,
          recommendGrower: feedGrowerRecommend,
          recommendFinisher: feedFinisherRecommend,
          status: GlobalState.loaded,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
