import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'point_exchange_state.dart';

class PointExchangeCubit extends Cubit<PointExchangeState> {
  PointExchangeCubit(this.pointService) : super(const PointExchangeState());

  final PointService pointService;

  Future<void> exchangePoint({
    required String type,
    required int point,
    required int nominalRP,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await pointService.pointExchange(
        type: type,
        point: point,
        nominlaRP: nominalRP,
        notes: '',
      );
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
