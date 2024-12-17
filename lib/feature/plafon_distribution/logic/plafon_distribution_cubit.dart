import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'plafon_distribution_state.dart';

class PlafonDistributionCubit extends Cubit<PlafonDistributionState> {
  PlafonDistributionCubit() : super(const PlafonDistributionState());

  void changeShowMore(bool isShowingShowMore) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        showingShowMore: isShowingShowMore,
      ),
    );
  }
}
