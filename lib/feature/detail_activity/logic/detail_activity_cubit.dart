import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/repositories/ongoing_cycle_feed_response.dart';

part 'detail_activity_state.dart';

class DetailActivityCubit extends Cubit<DetailActivityState> {
  DetailActivityCubit(this.service) : super(const DetailActivityState());

  final CycleService service;

  Future<void> init(String pondID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getOngoingCycle(fishpondID: pondID);
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
}
