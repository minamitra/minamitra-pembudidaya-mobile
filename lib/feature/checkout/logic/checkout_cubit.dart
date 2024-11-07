import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  Future<void> processCheckout() async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
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
