import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';

part 'activity_activities_state.dart';

class ActivityActivitiesCubit extends Cubit<ActivityActivitiesState> {
  ActivityActivitiesCubit(this.feedActivityService)
      : super(const ActivityActivitiesState());

  final FeedActivityService feedActivityService;

  Future<void> init(String fishPondCycleID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await feedActivityService.getData(
        fishPondCycleID,
        AppConvertDateTime().ymdDash(DateTime.now()),
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        feedActivityResponse: response.data,
        selectedDate: DateTime.now(),
        pondCycleID: fishPondCycleID,
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
      final response = await feedActivityService.getData(
        state.pondCycleID ?? "",
        AppConvertDateTime().ymdDash(dateTime),
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        feedActivityResponse: response.data,
        selectedDate: dateTime,
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

  Future<void> refreshData() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await feedActivityService.getData(
        state.pondCycleID ?? "",
        AppConvertDateTime().ymdDash(state.selectedDate ?? DateTime.now()),
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        feedActivityResponse: response.data,
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

  void changeIndex(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(status: GlobalState.loaded, index: index));
  }

  // void changeDatetime(String datetime) {
  //   emit(state.copyWith(status: GlobalState.onUpdating));
  //   emit(state.copyWith(status: GlobalState.loaded, datetime: datetime));
  // }
}
