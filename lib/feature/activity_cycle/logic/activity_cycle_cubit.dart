import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';

part 'activity_cycle_state.dart';

class ActivityCycleCubit extends Cubit<ActivityCycleState> {
  ActivityCycleCubit(this.service) : super(const ActivityCycleState());

  final CycleService service;

  Future<void> init(String pondID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final activeData = await service.getFeedCycleHistory(
        pondID: pondID,
        status: "active",
      );
      final readyHarvestData = await service.getFeedCycleHistory(
        pondID: pondID,
        status: "ready",
      );
      // Cleaning active data
      readyHarvestData.data.data?.forEach((element) {
        activeData.data.data
            ?.removeWhere((element2) => element2.id == element.id);
      });
      final harvestData = await service.getFeedCycleHistory(
        pondID: pondID,
        status: "harvest",
      );
      final doneData = await service.getFeedCycleHistory(
        pondID: pondID,
        status: "done",
      );
      emit(state.copyWith(
        activeData: activeData.data,
        readyHarvestData: readyHarvestData.data,
        harvestData: harvestData.data,
        doneData: doneData.data,
        status: GlobalState.loaded,
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
}
