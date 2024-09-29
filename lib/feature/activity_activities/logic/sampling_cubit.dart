import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/sampling_response.dart';

part 'sampling_state.dart';

class SamplingCubit extends Cubit<SamplingState> {
  SamplingCubit(this.service) : super(const SamplingState());

  final ActivitySamplingService service;

  void init(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.dataSampling(
        fishpondId,
        fishpondcycleId,
        datetime,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        samplings: response.data.data,
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

  void deleteSampling(
    String id,
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      await service.deleteSampling(id);
      final samplings = await service.dataSampling(
        fishpondId,
        fishpondcycleId,
        datetime,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        samplings: samplings.data.data,
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
