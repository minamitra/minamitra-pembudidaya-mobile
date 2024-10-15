import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
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

  final TextEditingController totalAmountFeedFromInitController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> init(
    String fishPondID,
    String fishPondCycleID,
    DateTime tebarDate, {
    DateTime? selectedDate,
    FeedActivityResponseData? editData,
  }) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      int diferentInDays = selectedDate != null
          ? selectedDate.difference(tebarDate).inDays
          : DateTime.now().difference(tebarDate).inDays;
      final response = await service.getRecommendation(
        fishPondCycleID,
        diferentInDays.toString(),
      );
      final fishFeedByCycleResponse = await service.getFeedDataByCycle(
        fishPondCycleID,
        AppConvertDateTime().ymdDash(DateTime.now()),
      );
      this.fishPondID = fishPondID;
      this.fishPondCycleID = fishPondCycleID;
      this.tebarDate = tebarDate;

      if (editData != null) {
        amountController.text =
            (double.parse(editData.actual ?? "0") / 1000).toString();
      }

      totalAmountFeedFromInitController.text =
          (((response.data.data?.accumulationTotalFeedBefore ?? 0) +
                      double.parse(
                          amountController.text.handleEmptyStringToZero())) /
                  1000)
              .toStringAsFixed(7);

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
    emit(state.copyWith(
      status: GlobalState.loading,
      fishFoodID: null,
    ));
    try {
      int diferentInDays =
          dateTime.difference(tebarDate ?? DateTime.now()).inDays;
      final response = await service.getRecommendation(
        fishPondCycleID ?? "",
        diferentInDays.toString(),
      );
      final fishFeedByCycleResponse = await service.getFeedDataByCycle(
        fishPondCycleID ?? "",
        AppConvertDateTime().ymdDash(dateTime),
      );
      totalAmountFeedFromInitController.text =
          ((response.data.data?.accumulationTotalFeedBefore ?? 0) / 1000)
              .toStringAsFixed(7);
      emit(state.copyWith(
        status: GlobalState.loaded,
        selectedDate: dateTime,
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

  void changeTimeFeed(
    int hour,
    int minute,
  ) {
    feedHour = hour.toString();
    feedMinute = minute.toString();
  }

  void cahngeFishFoodID(int fishFoodID) {
    emit(state.copyWith(fishFoodID: fishFoodID));
  }

  Future<void> addFishFeed(AddFishFeedBody body) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.postAddFishFeed(body, isCreateData: body.dataID == null);
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
