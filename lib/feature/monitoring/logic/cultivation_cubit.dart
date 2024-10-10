import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/graph_response.dart';

part 'cultivation_state.dart';

class CultivationCubit extends Cubit<CultivationState> {
  CultivationCubit(this.service) : super(const CultivationState());

  final CycleService service;

  String pondCycleID = "";
  final TextEditingController docStartController =
      TextEditingController(text: "0");
  final TextEditingController docEndController = TextEditingController();

  Future<void> init(
    String pondCycleID,
    String filterName,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getGraphData(
        pondCycleID: pondCycleID,
        filterName: filterName,
      );
      this.pondCycleID = pondCycleID;
      GraphResponseData data = response.data.data?.copyWith(
        data: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.data ?? []
        ],
        tempData: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.tempData ?? []
        ],
      );
      docEndController.text = data.data?.length.toString() ?? "0";
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: data,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> reset() async {
    await init(pondCycleID, "mbw");
  }

  void cahngeDOC() {
    emit(state.copyWith(status: GlobalState.loading));
    GraphResponseData data = state.data?.copyWith(
      data: state.data?.tempData?.sublist(
        int.parse(docStartController.text),
        int.parse(docEndController.text),
      ),
    );
    emit(state.copyWith(
      status: GlobalState.loaded,
      data: data,
    ));
  }

  Future<void> onChangeFilter(String filterName) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getGraphData(
        pondCycleID: pondCycleID,
        filterName: filterName,
      );
      docStartController.text = "0";
      GraphResponseData data = response.data.data?.copyWith(
        data: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.data ?? []
        ],
        tempData: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.tempData ?? []
        ],
      );
      docEndController.text = data.data?.length.toString() ?? "0";

      emit(state.copyWith(
        status: GlobalState.loaded,
        data: data,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
