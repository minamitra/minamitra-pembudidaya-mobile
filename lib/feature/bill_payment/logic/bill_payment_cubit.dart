import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'bill_payment_state.dart';

class BillPaymentCubit extends Cubit<BillPaymentState> {
  BillPaymentCubit(
    this.billService,
    this.plafonDistributionService,
  ) : super(const BillPaymentState());

  final BillService billService;
  final PlafonDistributionService plafonDistributionService;

  Future<void> init() async {
    emit(
      state.copyWith(status: GlobalState.loading),
    );
    try {
      final billResponse = await billService.billSummary();
      final plafonSummaryResponse =
          await plafonDistributionService.plafonSummary();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          billSummaryResponse: billResponse.data,
          plafonSummaryResponse: plafonSummaryResponse.data,
        ),
      );
      emit(state.copyWith(status: GlobalState.onUpdating));
      await Future.delayed(const Duration(milliseconds: 50));
      emit(state.copyWith(status: GlobalState.loaded));
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

  void showBackgroundAppBar(bool isShowing) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        isShowingBackgroundAppBar: isShowing,
      ),
    );
  }
}
