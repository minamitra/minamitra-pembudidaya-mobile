import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'limit_bill_state.dart';

class LimitBillCubit extends Cubit<LimitBillState> {
  LimitBillCubit() : super(const LimitBillState());

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
