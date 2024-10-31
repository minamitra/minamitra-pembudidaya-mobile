import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'history_point_state.dart';

class HistoryPointCubit extends Cubit<HistoryPointState> {
  HistoryPointCubit() : super(const HistoryPointState());

  void onChangeFilter(int selectedFilter) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      selectedFilter: selectedFilter,
      status: GlobalState.loaded,
    ),);
  }
}
