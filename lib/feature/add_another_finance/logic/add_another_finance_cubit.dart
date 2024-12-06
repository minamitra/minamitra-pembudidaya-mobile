import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/finance/finance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/repositories/add_other_cost_body.dart';

part 'add_another_finance_state.dart';

class AddAnotherFinanceCubit extends Cubit<AddAnotherFinanceState> {
  AddAnotherFinanceCubit(
    this.cdnService,
    this.financeService,
  ) : super(const AddAnotherFinanceState());

  final CdnService cdnService;
  final FinanceService financeService;
  int? fishpondID;
  int? fishpondCycleID;

  Future<void> init(
    FishpondCycleCostResponseData? otherCostData, {
    int? fishpondID,
    int? fishpondCycleID,
  }) async {
    emit(state.copyWith(status: GlobalState.loading));
    this.fishpondID = fishpondID;
    this.fishpondCycleID = fishpondCycleID;
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        selectedDate: otherCostData?.date,
        images: otherCostData?.attachmentJsonArray ?? [],
      ),
    );
  }

  void setSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> setImage(File image) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final response = await cdnService.uploadImage(image);
      emit(
        state.copyWith(
          status: GlobalState.hideDialogLoading,
          images: [
            ...state.images,
            response.data.data?.fileuri ?? '',
          ],
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void removeImage(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<String> listImage = state.images;
    listImage.removeAt(index);
    emit(state.copyWith(images: listImage, status: GlobalState.loaded));
  }

  void addData({
    required String costType,
    required String notes,
    required int nominal,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await financeService.addOtherCost(
        AddOtherCostBody(
          fishpondId: fishpondID,
          fishpondcycleId: fishpondCycleID,
          date: state.selectedDate,
          type: costType,
          nominal: nominal,
          note: notes,
          attachmentJsonArray: state.images,
        ),
      );
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateData({
    required String id,
    required String costType,
    required String notes,
    required int nominal,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await financeService.updateOtherCost(
        AddOtherCostBody(
          id: int.parse(id),
          fishpondId: fishpondID,
          fishpondcycleId: fishpondCycleID,
          date: state.selectedDate,
          type: costType,
          nominal: nominal,
          note: notes,
          attachmentJsonArray: state.images,
        ),
      );
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void deleteData(String otherCostID) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await financeService.deleteOtherCost(otherCostID);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
