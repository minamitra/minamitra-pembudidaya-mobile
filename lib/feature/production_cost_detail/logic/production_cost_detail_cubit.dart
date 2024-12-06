import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';

part 'production_cost_detail_state.dart';

class ProductionCostDetailCubit extends Cubit<ProductionCostDetailState> {
  ProductionCostDetailCubit(this.financeService)
      : super(const ProductionCostDetailState());

  final FinanceService financeService;

  String fishPondCycleID = '0';

  void init(
    FinanceResponseData financeResponseData,
    FishpondCycleCostResponse otherCostData,
    String fishPondID,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      fishPondCycleID = financeResponseData.fishPondCycleID ?? '0';
      final financeResponse = await financeService.finance(
        fishPondID,
        fishPondCycleID: financeResponseData.fishPondCycleID ?? '0',
      );
      final otherCostResponse = await financeService
          .fishPondCycleCost(financeResponseData.fishPondCycleID ?? '0');
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          financeResponseData: financeResponse.data.data?.first,
          otherCostData: otherCostResponse.data,
          fishPondID: fishPondID,
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

  void refresh() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final financeResponse = await financeService.finance(
        state.fishPondID,
        fishPondCycleID: fishPondCycleID,
      );
      final otherCostResponse =
          await financeService.fishPondCycleCost(fishPondCycleID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          financeResponseData: financeResponse.data.data?.first,
          otherCostData: otherCostResponse.data,
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
