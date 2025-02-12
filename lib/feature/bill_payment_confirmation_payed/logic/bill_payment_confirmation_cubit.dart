import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';

part 'bill_payment_confirmation_state.dart';

class BillPaymentConfirmationCubit extends Cubit<BillPaymentConfirmationState> {
  BillPaymentConfirmationCubit(
    this.cdnService,
    this.billService,
  ) : super(const BillPaymentConfirmationState());

  final CdnService cdnService;
  final BillService billService;

  Future<void> payBill({
    required BillResponseData billResponseData,
    required SelectedPayment selectedPayment,
    required int totalBillPayed,
    required File image,
    required String notes,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final uploadImageResponse = await cdnService.uploadImage(image);
      final payBillResponse = await billService.pay(
        plafonSubmissionID: int.parse(billResponseData.id ?? ''),
        method: (selectedPayment.paymentMethod ?? '') == 'Tunai'
            ? 'Tunai'
            : 'Transfer',
        nominal: totalBillPayed,
        tfBankID: (selectedPayment.paymentMethod ?? '') == 'Tunai'
            ? null
            : int.parse(selectedPayment.id ?? '0'),
      );
      final uploadProofResponse = await billService.uploadPaymentProof(
        id: payBillResponse.data,
        proofImageURL: uploadImageResponse.data.data?.fileuri ?? '',
        proofNote: notes,
      );
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.successSubmit,
          notes: notes,
          message: uploadProofResponse.toString(),
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          message: e.toString(),
        ),
      );
    }
  }
}
