import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'activity_activities_detail_state.dart';

class ActivityActivitiesDetailCubit
    extends Cubit<ActivityActivitiesDetailState> {
  ActivityActivitiesDetailCubit()
      : super(const ActivityActivitiesDetailState());

  void init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      // get activity detail
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
