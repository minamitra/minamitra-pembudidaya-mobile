import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/repositories/point_exchange_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_history_response.dart';

part 'history_point_state.dart';

class HistoryPointCubit extends Cubit<HistoryPointState> {
  HistoryPointCubit(this.service) : super(const HistoryPointState());

  final PointService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final successData = await service.pointHistory();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          pointHistoryResponse: successData.data,
          selectedFilter: 'Selesai',
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

  Future<void> getSuccessData({String? filterDate}) async {
    final pointHistoryData = await service.pointHistory(
      dateTime: filterDate,
    );
    emit(state.copyWith(pointHistoryResponse: pointHistoryData.data));
  }

  Future<void> getWithdrawalData({String? filterDate}) async {
    final withdrawalData = await service.pointExchangeHistory(
      type: 'Tarik Tunai',
      createdDateTime: filterDate,
    );
    emit(state.copyWith(withdrawalData: withdrawalData.data));
  }

  Future<void> getConvertBalanceData({String? filterDate}) async {
    final convertBalanceData = await service.pointExchangeHistory(
      type: 'Konversi Saldo',
      createdDateTime: filterDate,
    );
    emit(
      state.copyWith(
        convertBalanceData: convertBalanceData.data,
      ),
    );
  }

  Future<void> onChangeFilter(String selectedFilter) async {
    log(state.selectedDate.toString());
    emit(
      state.copyWith(
        status: GlobalState.loading,
        selectedDate: state.selectedDate,
      ),
    );
    try {
      // For success data
      if (selectedFilter == 'Selesai') {
        await getSuccessData();
        emit(
          state.copyWith(
            status: GlobalState.loaded,
            selectedFilter: selectedFilter,
          ),
        );
      }
      // For withdrawal
      if (selectedFilter == 'Tarik Tunai') {
        await getWithdrawalData();

        emit(
          state.copyWith(
            status: GlobalState.loaded,
            selectedFilter: selectedFilter,
          ),
        );
      }
      // For convert balnace
      if (selectedFilter == 'Konversi Saldo') {
        await getConvertBalanceData();
        emit(
          state.copyWith(
            status: GlobalState.loaded,
            selectedFilter: selectedFilter,
          ),
        );
      }
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

    emit(
      state.copyWith(
        selectedFilter: selectedFilter,
        selectedDate: state.selectedDate,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> onFilterByDate(DateTime? date) async {
    emit(state.copyWith(status: GlobalState.loading));
    if (state.selectedFilter == 'Selesai') {
      await getSuccessData(
        filterDate: date == null ? null : AppConvertDateTime().ymdDash(date),
      );
    }
    if (state.selectedFilter == 'Tarik Tunai') {
      await getWithdrawalData(
        filterDate: date == null ? null : AppConvertDateTime().ymdDash(date),
      );
    }
    if (state.selectedFilter == 'Konversi Saldo') {
      await getConvertBalanceData(
        filterDate: date == null ? null : AppConvertDateTime().ymdDash(date),
      );
    }
    emit(
      state.copyWith(
        selectedDate: date,
        status: GlobalState.loaded,
      ),
    );
  }
}
