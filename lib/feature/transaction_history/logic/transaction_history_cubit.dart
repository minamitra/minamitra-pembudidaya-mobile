import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/history_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/balance/balance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'transaction_history_state.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  TransactionHistoryCubit(this.balanceService)
      : super(const TransactionHistoryState());

  final BalanceService balanceService;
  Map<String, List<HistoryBalanceResponseData>> dataFormated = {};

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await balanceService.historyBalance();

      response.data.data?.forEach((element) {
        if (dataFormated.containsKey(
          AppConvertDateTime().dmyName(element.dateTime ?? DateTime.now()),
        )) {
          dataFormated[AppConvertDateTime()
                  .dmyName(element.dateTime ?? DateTime.now())]
              ?.add(element);
        } else {
          dataFormated[AppConvertDateTime()
              .dmyName(element.dateTime ?? DateTime.now())] = [element];
        }
      });
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          historyBalance: response.data,
          dataFormated: dataFormated,
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
