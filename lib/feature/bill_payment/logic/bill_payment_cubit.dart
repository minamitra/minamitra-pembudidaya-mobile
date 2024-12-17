import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'bill_payment_state.dart';

class BillPaymentCubit extends Cubit<BillPaymentState> {
  BillPaymentCubit() : super(const BillPaymentState());

  void showBackgroundAppBar(bool isShowing) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        isShowingBackgroundAppBar: isShowing,
      ),
    );
  }
}
