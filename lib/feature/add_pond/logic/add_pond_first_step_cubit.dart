import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'add_pond_first_step_state.dart';

class AddPondFirstStepCubit extends Cubit<AddPondFirstStepState> {
  AddPondFirstStepCubit() : super(const AddPondFirstStepState());

  void onChangeData({
    String? pondName,
    double? pondLength,
    double? pondWidth,
    double? pondDepth,
  }) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      status: GlobalState.loaded,
      pondName: pondName,
      pondLength: pondLength,
      pondWidth: pondWidth,
      pondDepth: pondDepth,
    ));
  }
}
