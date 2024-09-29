import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';

part 'water_quality_state.dart';

class WaterQualityCubit extends Cubit<WaterQualityState> {
  WaterQualityCubit(this.service) : super(const WaterQualityState());

  final ActivityWaterQualityService service;

  void init(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.dataWaterQuality(
        fishpondId,
        fishpondcycleId,
        datetime,
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        waterQualities: response.data.data,
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
