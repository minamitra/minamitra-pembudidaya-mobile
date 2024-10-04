import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/buyer_data.dart';

part 'activity_cycle_add_harvest_state.dart';

class ActivityCycleAddHarvestCubit extends Cubit<ActivityCycleAddHarvestState> {
  ActivityCycleAddHarvestCubit(this.service)
      : super(const ActivityCycleAddHarvestState());

  final CycleService service;

  void init() {
    emit(state.copyWith(status: GlobalState.loading));
    final BuyerData initData = BuyerData(
      isBuyerFrom3m: false,
      buyerName: "",
      sellRequest: 0,
      sellUnitPrice: 0,
      sellTotalPrice: 0,
      buyerNameController: TextEditingController(),
      sellRequestController: TextEditingController(),
      sellUnitPriceController: TextEditingController(),
      sellerNotesController: TextEditingController(),
      sellTotalPriceController: TextEditingController(),
    );
    emit(state.copyWith(
      status: GlobalState.loaded,
      buyerData: [initData],
    ));
  }

  void onChnageBuyerType(int index, bool isBuyerFrom3m) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<BuyerData> buyerData = state.buyerData;
    buyerData[index] = buyerData[index].copyWith(
        isBuyerFrom3m: isBuyerFrom3m,
        buyerID: null,
        buyerName: "",
        sellRequest: 0,
        sellUnitPrice: 0,
        sellerNotes: "");
    emit(state.copyWith(buyerData: buyerData, status: GlobalState.loaded));
  }

  void onChangeBuyerName(int index, String buyerName) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<BuyerData> buyerData = state.buyerData;
    buyerData[index] = buyerData[index].copyWith(buyerName: buyerName);
    emit(state.copyWith(buyerData: buyerData, status: GlobalState.loaded));
  }

  void onChangeSellRequest(int index, int sellRequest) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<BuyerData> buyerData = state.buyerData;
    buyerData[index] = buyerData[index].copyWith(sellRequest: sellRequest);
    emit(state.copyWith(buyerData: buyerData, status: GlobalState.loaded));
  }

  void onChangeSellUnitPrice(int index, int sellUnitPrice) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<BuyerData> buyerData = state.buyerData;
    buyerData[index] = buyerData[index].copyWith(sellUnitPrice: sellUnitPrice);
    emit(state.copyWith(buyerData: buyerData, status: GlobalState.loaded));
  }

  void addAnotherBuyyer() {
    emit(state.copyWith(status: GlobalState.loading));
    final BuyerData initData = BuyerData(
      isBuyerFrom3m: false,
      buyerName: "",
      sellRequest: 0,
      sellUnitPrice: 0,
      sellTotalPrice: 0,
      buyerNameController: TextEditingController(),
      sellRequestController: TextEditingController(),
      sellUnitPriceController: TextEditingController(),
      sellerNotesController: TextEditingController(),
      sellTotalPriceController: TextEditingController(),
    );
    emit(state.copyWith(
      status: GlobalState.loaded,
      buyerData: [...state.buyerData, initData],
    ));
  }

  void createHarvest({
    required String id,
    required DateTime harvestDate,
    required int harvestFishWeight,
    required int totalHarvestActual,
    required String harvestNotes,
    required List<String> images,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      await service.addHarvest();
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
