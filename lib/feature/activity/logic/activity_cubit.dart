import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_dashboard_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit(this.pondService) : super(const ActivityState());

  final PondService pondService;

  void init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      BaseResponse<PondResponse> response = await pondService.getPonds();
      response.data.data = [
        PondResponseData(
          id: "0",
          name: "Semua Kolam",
        ),
        ...response.data.data!,
      ];
      final pondDashboardResponse = await pondService.getPondsDashboard();
      emit(state.copyWith(
        status: GlobalState.loaded,
        pondReponse: response.data,
        pondDashboardResponse: pondDashboardResponse.data,
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

  Future<void> setDashboardWithPond(String pondId) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final pondDashboardResponse =
          await pondService.getPondsDashboard(pondID: pondId);
      emit(state.copyWith(
        status: GlobalState.loaded,
        pondDashboardResponse: pondDashboardResponse.data,
        selectedPondID: pondId,
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
