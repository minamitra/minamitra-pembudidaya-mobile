import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'score_credit_bill_info_state.dart';

class ScoreCreditBillInfoCubit extends Cubit<ScoreCreditBillInfoState> {
  ScoreCreditBillInfoCubit() : super(const ScoreCreditBillInfoState());

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
