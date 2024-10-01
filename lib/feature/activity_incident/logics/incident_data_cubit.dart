import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_incident/activity_incident_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';

part 'incident_data_state.dart';

class IncidentDataCubit extends Cubit<IncidentDataState> {
  IncidentDataCubit(this.service) : super(const IncidentDataState());

  final ActivityIncidentService service;

  void getIncidentData() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.dataIncident();
      emit(state.copyWith(
        status: GlobalState.loaded,
        incidents: response.data.data,
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

  void deleteIncident(String id) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      await service.deleteIncident(id);
      final incidents = await service.dataIncident();
      emit(state.copyWith(
        status: GlobalState.loaded,
        incidents: incidents.data.data,
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
