import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/repositories/delivery_status_response.dart';

part 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  TransactionDetailCubit(
    this.service,
    this.cdnService,
  ) : super(const TransactionDetailState());

  final TransactionService service;
  final CdnService cdnService;

  Future<void> init(
    bool isNeedGetDeliveryStatus, {
    String orderID = '',
  }) async {
    if (isNeedGetDeliveryStatus) {
      await getDeliveryStatus(orderID);
    }
  }

  Future<void> getDeliveryStatus(String orderID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getDeliveryStatus(orderID: orderID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          deliveryStatus: response.data,
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

  Future<void> cancelOrder(String id) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.cancelOrder(id: int.parse(id));
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

  Future<void> completeTransaction(String id) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.completeTransaction(id: int.parse(id));
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
