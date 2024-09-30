import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'activity_activities_state.dart';

class ActivityActivitiesCubit extends Cubit<ActivityActivitiesState> {
  ActivityActivitiesCubit() : super(const ActivityActivitiesState());

  void changeIndex(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(status: GlobalState.loaded, index: index));
  }

  void changeDatetime(String datetime) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(status: GlobalState.loaded, datetime: datetime));
  }
}
