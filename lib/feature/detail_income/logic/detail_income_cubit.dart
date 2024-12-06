import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';

part 'detail_income_state.dart';

class DetailIncomeCubit extends Cubit<DetailIncomeState> {
  DetailIncomeCubit(this.cycleService) : super(const DetailIncomeState());

  final CycleService cycleService;

  Future<void> init(String fishPondCycleID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response =
          await cycleService.getCycleDetail(fishPondCycleID: fishPondCycleID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data,
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
