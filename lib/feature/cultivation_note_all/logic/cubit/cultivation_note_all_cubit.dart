import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';

part 'cultivation_note_all_state.dart';

class CultivationNoteAllCubit extends Cubit<CultivationNoteAllState> {
  CultivationNoteAllCubit(this.service)
      : super(const CultivationNoteAllState());

  final CycleService service;

  String? pickedRangeDate;
  String? pondCycleID;
  String? startDate;
  String? endDate;
  String? companionName;

  Future<void> init(
    String pondCycleID,
    List<CompanionNotesResponseData>? data,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      this.pondCycleID = pondCycleID;
      List<String> companionName =
          data?.map((value) => value.userName ?? "").toList() ?? [];
      companionName.toSet().toList();
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: data,
        companionName: companionName,
      ));
    } catch (e) {}
  }

  Future<void> pickNotesByRangeDate({
    required String startDate,
    required String endDate,
    required String pickedRangeDate,
  }) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? "",
        filterStartDate: startDate,
        filterEndDate: endDate,
        companionName: companionName,
      );
      this.pickedRangeDate = pickedRangeDate;
      this.startDate = startDate;
      this.endDate = endDate;
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: response.data.data,
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
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response =
          await service.getCompanionNotes(pondCycleID: pondCycleID ?? "");
      pickedRangeDate = null;
      startDate = null;
      endDate = null;
      companionName = null;
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: response.data.data,
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

  Future<void> filterByCompanionNmae(String name) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? "",
        filterStartDate: startDate,
        filterEndDate: endDate,
        companionName: name,
      );
      companionName = name;
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: response.data.data,
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

  Future<void> resetCompanionName() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? "",
        filterStartDate: startDate,
        filterEndDate: endDate,
      );
      companionName = null;
      emit(state.copyWith(
        status: GlobalState.loaded,
        data: response.data.data,
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
