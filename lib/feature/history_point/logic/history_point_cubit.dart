import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'history_point_state.dart';

class HistoryPointCubit extends Cubit<HistoryPointState> {
  HistoryPointCubit() : super(const HistoryPointState());

  void onChangeFilter(String selectedFilter) {
    emit(state.copyWith(status: GlobalState.loading));
    emit(
      state.copyWith(
        selectedFilter: selectedFilter,
        selectedDate: state.selectedDate,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> onFilterByDate(DateTime? date) async {
    emit(state.copyWith(status: GlobalState.loading));
    emit(
      state.copyWith(
        selectedDate: date,
        status: GlobalState.loaded,
      ),
    );
  }
}
