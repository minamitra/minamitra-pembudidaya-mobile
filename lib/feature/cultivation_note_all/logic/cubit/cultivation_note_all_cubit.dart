import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
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
  SharedPreferenceService sharedPreferenceService =
      SharedPreferenceServiceImpl.create();

  bool isCommentReaded(String id) {
    return state.commentReaded?.contains(id) ?? false;
  }

  void addCommentReaded(String id) async {
    final List<String> commentReaded =
        await sharedPreferenceService.getSharedPreference('commentReaded').then(
      (String? value) {
        if (value != null) {
          return value.split(',');
        }
        return [];
      },
    );
    bool isHasReaded = commentReaded.contains(id);
    if (!isHasReaded) {
      commentReaded.add(id);
      await sharedPreferenceService.setSharedPreference(
        'commentReaded',
        commentReaded.join(','),
      );
    }
  }

  void refreshCommentReaded() async {
    emit(state.copyWith(status: GlobalState.loading));
    final List<String> commentReaded =
        await sharedPreferenceService.getSharedPreference('commentReaded').then(
      (String? value) {
        if (value != null) {
          return value.split(',');
        }
        return [];
      },
    );
    emit(
      state.copyWith(
        commentReaded: commentReaded,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> init(
    String pondCycleID,
    List<CompanionNotesResponseData>? data,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final List<String> commentReaded = await sharedPreferenceService
          .getSharedPreference('commentReaded')
          .then(
        (String? value) {
          if (value != null) {
            return value.split(',');
          }
          return [];
        },
      );
      this.pondCycleID = pondCycleID;
      List<String> companionName =
          data?.map((value) => value.userName ?? '').toList() ?? [];
      companionName.toSet().toList();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: data,
          companionName: companionName,
          commentReaded: commentReaded,
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

  Future<void> pickNotesByRangeDate({
    required String startDate,
    required String endDate,
    required String pickedRangeDate,
  }) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? '',
        filterStartDate: startDate,
        filterEndDate: endDate,
        companionName: companionName,
      );
      this.pickedRangeDate = pickedRangeDate;
      this.startDate = startDate;
      this.endDate = endDate;
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data.data,
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

  Future<void> reset() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response =
          await service.getCompanionNotes(pondCycleID: pondCycleID ?? '');
      pickedRangeDate = null;
      startDate = null;
      endDate = null;
      companionName = null;
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data.data,
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

  Future<void> filterByCompanionNmae(String name) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? '',
        filterStartDate: startDate,
        filterEndDate: endDate,
        companionName: name,
      );
      companionName = name;
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data.data,
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

  Future<void> resetCompanionName() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getCompanionNotes(
        pondCycleID: pondCycleID ?? '',
        filterStartDate: startDate,
        filterEndDate: endDate,
      );
      companionName = null;
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data.data,
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
