import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'point_mission_v2_state.dart';

class PointMissionV2Cubit extends Cubit<PointMissionV2State> {
  PointMissionV2Cubit() : super(const PointMissionV2State());

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      Duration differenceTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      )
          .add(
            const Duration(days: 1),
          )
          .difference(DateTime.now());

      emit(
        state.copyWith(
          status: GlobalState.loaded,
          differenceTime: differenceTime,
        ),
      );
    } catch (e) {}
  }
}
