import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/add_fish_feed_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feed_data_by_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feer_recomendation_response.dart';

part 'activity_activities_add_state.dart';

class ActivityActivitiesAddCubit extends Cubit<ActivityActivitiesAddState> {
  ActivityActivitiesAddCubit(this.service)
      : super(const ActivityActivitiesAddState());
  final FeedActivityService service;

  String? fishPondID;
  String? fishPondCycleID;
  DateTime? tebarDate;
  String? feedHour;
  String? feedMinute;

  Future<void> init(
    String fishPondID,
    String fishPondCycleID,
    DateTime tebarDate,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      int diferentInDays = DateTime.now().difference(tebarDate).inDays;
      final response = await service.getRecommendation(
        fishPondCycleID,
        diferentInDays.toString(),
      );
      final fishFeedByCycleResponse =
          await service.getFeedDataByCycle(fishPondCycleID);
      this.fishPondID = fishPondID;
      this.fishPondCycleID = fishPondCycleID;
      this.tebarDate = tebarDate;
      emit(state.copyWith(
        status: GlobalState.loaded,
        selectedDate: DateTime.now(),
        feedRecomendationResponse: response.data,
        feedDataByCycleResponse: fishFeedByCycleResponse.data,
        fishAge: diferentInDays,
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

  Future<void> changeDateTime(DateTime dateTime) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      int diferentInDays =
          dateTime.difference(tebarDate ?? DateTime.now()).inDays;
      final response = await service.getRecommendation(
        fishPondCycleID ?? "",
        diferentInDays.toString(),
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        selectedDate: dateTime,
        feedRecomendationResponse: response.data,
        fishAge: diferentInDays,
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

  void changeTimeFeed(String time) {
    final timeSplit = time.split(":");
    feedHour = timeSplit[0];
    feedMinute = timeSplit[1];
  }

  void cahngeFishFoodID(int fishFoodID) {
    emit(state.copyWith(fishFoodID: fishFoodID));
  }

  Future<void> addFishFeed(AddFishFeedBody body) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.postAddFishFeed(body);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
