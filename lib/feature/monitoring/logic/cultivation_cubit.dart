import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/detail_parameter_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/graph_response.dart';

part 'cultivation_state.dart';

class CultivationCubit extends Cubit<CultivationState> {
  CultivationCubit(
    this.service, {
    this.tebarDate,
    this.data,
  }) : super(const CultivationState());

  final CycleService service;
  final DateTime? tebarDate;
  CompanionNotesResponseData? data;

  String pondID = '';
  String pondCycleID = '';
  final TextEditingController docStartController =
      TextEditingController(text: '0');
  final TextEditingController docEndController = TextEditingController();
  SharedPreferenceService sharedPreferenceService =
      SharedPreferenceServiceImpl.create();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  void setupData(
    String pondID,
    String pondCycleID,
  ) {
    this.pondCycleID = pondCycleID;
    this.pondID = pondID;
  }

  Future<void> setUpData({String? id}) async {
    if (id != null) {
      emit(state.copyWith(status: GlobalState.loading));
      try {
        final response = await service.getCommentDetail(id: id);
        data = response.data;
        addCommentReaded();
        emit(state.copyWith(status: GlobalState.loaded));
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

  bool isCommentReaded(String id) {
    return state.commentReaded?.contains(id) ?? false;
  }

  void addCommentReaded() async {
    if (data != null) {
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
      bool isHasReaded = commentReaded.contains(data?.id ?? '');
      if (!isHasReaded) {
        commentReaded.add(data?.id ?? '');
        await sharedPreferenceService.setSharedPreference(
          'commentReaded',
          commentReaded.join(','),
        );
      }
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
    String pondID,
    String pondCycleID,
    String filterName,
  ) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      log('tebar date $tebarDate');
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
      final response = await service.getGraphData(
        pondCycleID: pondCycleID,
        filterName: filterName,
      );
      final companionNotesResponse =
          await service.getCompanionNotes(pondCycleID: pondCycleID);
      final detailParameterResoponse = await service.getDetailParameter(
        pondCycleID: pondCycleID,
      );
      this.pondCycleID = pondCycleID;
      this.pondID = pondID;
      GraphResponseData? datas = response.data.data?.copyWith(
        data: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data?.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.data ?? [],
        ],
        tempData: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.tempData ?? [],
        ],
      );

      docEndController.text = datas?.data?.length.toString() ?? '0';
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: datas,
          companionNotesData: companionNotesResponse.data,
          commentReaded: commentReaded,
          detailParameterResponse: detailParameterResoponse.data,
        ),
      );
    } on AppException catch (e) {
      log('error $e');
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      log('error $e');
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> onChangeDate(
    DateTime date, {
    bool isClearDate = false,
  }) async {
    selectedDate = date;
    if (isClearDate) {
      selectedDate = null;
    }
    final DateTime selectedDateTemp = date;
    dateController.text =
        isClearDate ? '' : AppConvertDateTime().dmy(selectedDateTemp);
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final response = await service.getDetailParameter(
        pondCycleID: pondCycleID,
        date: AppConvertDateTime().ymdDash(selectedDateTemp),
      );
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          detailParameterResponse: response.data,
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
    // await init(pondCycleID, "mbw");
    emit(state.copyWith(status: GlobalState.loading));
    docStartController.text = '0';
    docEndController.text = state.data?.tempData?.length.toString() ?? '0';
    GraphResponseData? data = state.data?.copyWith(
      data: state.data?.tempData?.sublist(
        int.parse(docStartController.text),
        int.parse(docEndController.text),
      ),
    );
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        data: data,
      ),
    );
  }

  void cahngeDOC() {
    emit(state.copyWith(status: GlobalState.loading));
    GraphResponseData? data = state.data?.copyWith(
      data: state.data?.tempData?.sublist(
        int.parse(docStartController.text),
        int.parse(docEndController.text),
      ),
    );
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        data: data,
      ),
    );
  }

  Future<void> onChangeFilter(String filterName) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getGraphData(
        pondCycleID: pondCycleID,
        filterName: filterName,
      );
      docStartController.text = '0';
      GraphResponseData data = response.data.data!.copyWith(
        data: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.data ?? [],
        ],
        tempData: [
          GraphResponseDataItem(
            actual: 0,
            target: 0,
            doc: 0,
            date: response.data.data!.data?[0].date
                ?.subtract(const Duration(days: 1)),
          ),
          ...response.data.data!.tempData ?? [],
        ],
      );
      docEndController.text = data.data?.length.toString() ?? '0';

      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: data,
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
