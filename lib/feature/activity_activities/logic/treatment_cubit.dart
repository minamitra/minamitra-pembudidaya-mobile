import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';

part 'treatment_state.dart';

class TreatmentCubit extends Cubit<TreatmentState> {
  TreatmentCubit(this.service) : super(const TreatmentState());

  final ActivityTreatmentService service;

  void init(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.dataTreatment(
        fishpondId,
        fishpondcycleId,
        datetime,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        treatments: response.data.data,
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

  void deleteTreatment(
    String id,
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      await service.deleteTreatment(id);
      final treatments = await service.dataTreatment(
        fishpondId,
        fishpondcycleId,
        datetime,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        treatments: treatments.data.data,
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
