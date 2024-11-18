import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/repositories/transaction_item_response.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(
    this.service,
    this.cdnService,
  ) : super(const TransactionState());

  final TransactionService service;
  final CdnService cdnService;

  Future<void> getWaitingDatas() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final waitingDatas = await service.transactions(status: 'Menunggu');
      emit(
        state.copyWith(
          waitingDatas: waitingDatas.data,
          status: GlobalState.loaded,
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

  Future<void> getProcessDatas() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final processDatas = await service.transactions(
        status: 'Diproses,Dikirim',
        isMultiple: true,
      );
      emit(
        state.copyWith(
          processDatas: processDatas.data,
          status: GlobalState.loaded,
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

  Future<void> getDoneDatas() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final doneDatas = await service.transactions(status: 'Selesai');
      emit(
        state.copyWith(
          doneDatas: doneDatas.data,
          status: GlobalState.loaded,
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

  Future<void> getCanceledDatas() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final cancelDatas = await service.transactions(
        status: 'Dibatalkan,Ditolak',
        isMultiple: true,
      );
      emit(
        state.copyWith(
          cancelDatas: cancelDatas.data,
          status: GlobalState.loaded,
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

  Future<void> uploadPaymentProof(
    String id,
    File file,
    String notes,
  ) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final uploadedImageResponse = await cdnService.uploadImage(file);
      await service.uploadPaymentProof(
        id: int.parse(id),
        imageURL: uploadedImageResponse.data.data?.fileuri ?? '',
        notes: notes,
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
}
