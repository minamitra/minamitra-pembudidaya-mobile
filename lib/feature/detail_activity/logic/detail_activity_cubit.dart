import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/repositories/ongoing_cycle_feed_response.dart';

part 'detail_activity_state.dart';

class DetailActivityCubit extends Cubit<DetailActivityState> {
  DetailActivityCubit(
    this.service,
    this.pondService,
  ) : super(const DetailActivityState());

  final CycleService service;
  final PondService pondService;

  Future<void> init(
    String pondID,
    String lastPondCycleID,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getOngoingCycle(
        fishpondID: pondID,
        lastPondCycleID: lastPondCycleID,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        onGoingCycleFeedResponseData: response.data,
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

  Future<void> deletePond(String pondID) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await pondService.deletePond(pondID);
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
