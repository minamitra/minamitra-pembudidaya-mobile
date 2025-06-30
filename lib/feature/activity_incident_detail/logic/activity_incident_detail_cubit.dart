import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_incident/activity_incident_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';

part 'activity_incident_detail_state.dart';

class ActivityIncidentDetailCubit extends Cubit<ActivityIncidentDetailState> {
  ActivityIncidentDetailCubit({
    this.incident,
  }) : super(const ActivityIncidentDetailState());

  final ActivityIncidentService service = ActivityIncidentServiceImpl.create();

  IncidentResponseData? incident;

  Future<void> init({
    String? incidentID,
  }) async {
    if (incident != null) return;
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.dataIncidentDetail(
        incidentID: incidentID ?? '',
      );
      incident = response.data;
      emit(state.copyWith(status: GlobalState.loaded));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
