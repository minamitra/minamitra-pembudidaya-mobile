import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/list_bill_payed_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_another_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_feed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_seed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_treatment_use_response.dart';

part 'bill_detail_state.dart';

class BillDetailCubit extends Cubit<BillDetailState> {
  BillDetailCubit(
    this.plafonService,
    this.billService,
  ) : super(const BillDetailState());

  final PlafonDistributionService plafonService;
  final BillService billService;

  String fishpondID = '';
  String billID = '';

  Future<void> init(
    String fishpondID,
    String billID,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      this.fishpondID = fishpondID;
      this.billID = billID;
      final plafonUseSummary = await plafonService.detailSummaryUse(fishpondID);
      final plafonFeedUse = await plafonService.detailFeedUse(fishpondID);
      final plafonTreatmentUse =
          await plafonService.detailTreatmentUse(fishpondID);
      final plafonSeedUse = await plafonService.detailSeedUse(fishpondID);
      final plafonAnotherUse = await plafonService.detailAnotherUse(fishpondID);
      final listBillPayed = await billService.listBillPayed(billID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          plafonUseSummary: plafonUseSummary.data,
          plafonFeedUse: plafonFeedUse.data,
          plafonTreatmentUse: plafonTreatmentUse.data,
          plafonSeedUse: plafonSeedUse.data,
          plafonAnotherUse: plafonAnotherUse.data,
          listBillPayed: listBillPayed.data,
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

  Future<void> refresh() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final plafonUseSummary = await plafonService.detailSummaryUse(fishpondID);
      final plafonFeedUse = await plafonService.detailFeedUse(fishpondID);
      final plafonTreatmentUse =
          await plafonService.detailTreatmentUse(fishpondID);
      final plafonSeedUse = await plafonService.detailSeedUse(fishpondID);
      final plafonAnotherUse = await plafonService.detailAnotherUse(fishpondID);
      final listBillPayed = await billService.listBillPayed(billID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          plafonUseSummary: plafonUseSummary.data,
          plafonFeedUse: plafonFeedUse.data,
          plafonTreatmentUse: plafonTreatmentUse.data,
          plafonSeedUse: plafonSeedUse.data,
          plafonAnotherUse: plafonAnotherUse.data,
          listBillPayed: listBillPayed.data,
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
