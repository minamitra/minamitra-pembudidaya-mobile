import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'point_v2_state.dart';

class PointV2Cubit extends Cubit<PointV2State> {
  PointV2Cubit() : super(const PointV2State());

  void onChangeGridExchangeValue(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    if (index == state.selectedGridExchange) {
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          selectedGridExchange: -1,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        selectedGridExchange: index,
      ),
    );
  }

  void onChangeBodyPointV2(BodyPointV2 bodyPointV2) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        bodyPointV2: bodyPointV2,
      ),
    );
  }

  Future<void> onSubmitExchange() async {
    try {} catch (e) {}
  }
}
