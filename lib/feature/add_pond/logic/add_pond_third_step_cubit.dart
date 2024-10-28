import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_finisher_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_grower_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_starter_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/seed_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed/feed_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

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
  String seedID = "0";

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final feedStarter1Response = await feedService.getFeedStarter("starter1");
      final feedStarter2Response = await feedService.getFeedStarter("starter2");
      final feedStarter3Response = await feedService.getFeedStarter("starter3");
      final feedGrowerResponse = await feedService.getFeedGrower();
      final feedFinisherResponse = await feedService.getFeedFinisher();
      final seedResponse = await feedService.getSeed();
      SeedResponse seedCleaningData = seedResponse.data;
      seedCleaningData = seedCleaningData.copyWith(
        data: [
          ...seedCleaningData.data ?? [],
          SeedResponseData(id: "-1", name: "Benih Baru"),
        ],
      );
      emit(state.copyWith(
        feedStarter1Data: feedStarter1Response.data,
        feedStarter2Data: feedStarter2Response.data,
        feedStarter3Data: feedStarter3Response.data,
        feedGrowerData: feedGrowerResponse.data,
        feedFinisherData: feedFinisherResponse.data,
        seedResponse: seedCleaningData,
        status: GlobalState.loaded,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
