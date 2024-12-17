import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bank/bank_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';

part 'bill_payment_pay_state.dart';

class BillPaymentPayCubit extends Cubit<BillPaymentPayState> {
  BillPaymentPayCubit(this.bankService) : super(const BillPaymentPayState());

  final BankService bankService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final banks = await bankService.getBanks();
      const SelectedPayment cashPayment = SelectedPayment(
        id: '0',
        imageAsset: AppAssets.cashSquareIcon,
        name: 'Tunai',
        paymentMethod: 'Tunai',
        description: 'Bayar menggunakan uang tunai',
      );
      final List<SelectedPayment> payments = [
        cashPayment,
        ...banks.data.data
                ?.map((element) => element.convertToSelectedPayment())
                .toList() ??
            [],
      ];
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          payments: payments,
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

  void onChangeSelectedPayment(SelectedPayment payment) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(status: GlobalState.loaded, selectedPayment: payment));
  }
}
