import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/mission_point_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_configuration_response.dart';

part 'point_mission_v2_state.dart';

class PointMissionV2Cubit extends Cubit<PointMissionV2State> {
  PointMissionV2Cubit(this.service) : super(const PointMissionV2State());

  final PointService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final pointBalance = await service.pointBalance();
      final pointConfiguration = await service.pointConfiguration();
      Duration differenceTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      )
          .add(
            const Duration(days: 1),
          )
          .difference(DateTime.now());
      final pointMission = await service.pointMission();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          differenceTime: differenceTime,
          pointBalance: pointBalance.data,
          pointConfigruation: pointConfiguration.data,
          missionPoint: pointMission.data,
        ),
      );
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
