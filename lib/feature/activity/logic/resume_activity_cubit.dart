import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_dashboard_response.dart';

part 'resume_activity_state.dart';

class ResumeActivityCubit extends Cubit<ResumeActivityState> {
  ResumeActivityCubit(this.service) : super(const ResumeActivityState());

  final PondService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final pondDashboardResponse = await service.getPondsDashboard();
      List<Fishpond>? fishpond = [
        Fishpond(id: '0', name: 'Semua Kolam'),
        ...(pondDashboardResponse.data.data?.fishpond ?? []),
      ];
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          pondDashboardResponse: pondDashboardResponse.data,
          fishpond: fishpond,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setDashboardWithPond(String pondId) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final pondDashboardResponse =
          await service.getPondsDashboard(pondID: pondId);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          pondDashboardResponse: pondDashboardResponse.data,
          selectedPondID: pondId,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
