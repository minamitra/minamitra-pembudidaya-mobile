import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/finance_summary_response.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  FinanceCubit(this.service) : super(const FinanceState());

  final FinanceService service;

  String fishPondID = '';

  Future<void> init(String fishPondID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      this.fishPondID = fishPondID;
      final summaryResponse = await service.financeSummary(fishPondID);
      final financeResponse = await service.finance(fishPondID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          financeSummary: summaryResponse.data,
          finance: financeResponse.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final summaryResponse = await service.financeSummary(fishPondID);
      final financeResponse = await service.finance(fishPondID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          financeSummary: summaryResponse.data,
          finance: financeResponse.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          error: e.toString(),
        ),
      );
    }
  }
}
