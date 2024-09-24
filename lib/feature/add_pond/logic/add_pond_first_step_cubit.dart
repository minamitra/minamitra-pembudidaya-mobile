import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'add_pond_first_step_state.dart';

class AddPondFirstStepCubit extends Cubit<AddPondFirstStepState> {
  AddPondFirstStepCubit() : super(const AddPondFirstStepState());

  final TextEditingController pondNameController = TextEditingController();
  final TextEditingController pondlengthController = TextEditingController();
  final TextEditingController pondWidthController = TextEditingController();
  final TextEditingController pondWideController = TextEditingController();
  final TextEditingController pondDeepController = TextEditingController();

  void onChangeData() {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      status: GlobalState.loaded,
      pondName: pondNameController.text,
      pondLength: double.parse(pondlengthController.text),
      pondWidth: double.parse(pondWidthController.text),
      pondDepth: double.parse(pondDeepController.text),
    ));
  }
}
