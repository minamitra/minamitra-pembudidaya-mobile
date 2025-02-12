import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'list_bill_state.dart';

class ListBillCubit extends Cubit<ListBillState> {
  ListBillCubit(this.billService) : super(const ListBillState());

  final BillService billService;

  Future<void> init(bool isHistoryTransaction) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await billService.bill(
        filterStatus:
            isHistoryTransaction ? 'Tagihan Terbayar' : 'Semua Tagihan',
      );
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          billResponse: response.data,
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

  void changeFilter(String filter) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      log(filter);
      final response = await billService.bill(
        filterStatus: filter == '14 Hari ke Depan' ? 'Semua Tagihan' : filter,
        dueDateFilterMin: filter == '14 Hari ke Depan'
            ? AppConvertDateTime().ymdDash(DateTime.now())
            : null,
        dueDateFilterMax: filter == '14 Hari ke Depan'
            ? AppConvertDateTime()
                .ymdDash(DateTime.now().add(const Duration(days: 14)))
            : null,
      );
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          filter: filter,
          billResponse: response.data,
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
