import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'add_pond_state.dart';

class AddPondCubit extends Cubit<AddPondState> {
  AddPondCubit() : super(const AddPondState());

  void changeStep(int index) {
    emit(state.copyWith(status: GlobalState.initial));
    emit(state.copyWith(
      index: index,
      status: GlobalState.refresh,
    ));
  }
}
