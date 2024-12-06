import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';

part 'finance_detail_state.dart';

class FinanceDetailCubit extends Cubit<FinanceDetailState> {
  FinanceDetailCubit(
    this.service,
    this.cycleService,
  ) : super(const FinanceDetailState());

  final FinanceService service;
  final CycleService cycleService;
  String fishPondID = '0';
  String fishPondCycleID = '0';

  Future<void> init(
    String fishPondID,
    FinanceResponseData data,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      this.fishPondID = fishPondID;
      fishPondCycleID = data.fishPondCycleID ?? '0';
      final response =
          await service.fishPondCycleCost(data.fishPondCycleID ?? '0');
      final cycleDetail = await cycleService.getCycleDetail(
        fishPondCycleID: data.fishPondCycleID ?? '0',
      );
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          otherCost: response.data,
          cycleDetail: cycleDetail.data,
          data: data,
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

  Future<void> refresh() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final financeResponse = await service.finance(
        fishPondID,
        fishPondCycleID: fishPondCycleID,
      );
      final otherCostResponse =
          await service.fishPondCycleCost(fishPondCycleID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: financeResponse.data.data?.first,
          otherCost: otherCostResponse.data,
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
