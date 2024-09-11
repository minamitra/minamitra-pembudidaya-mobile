import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
part 'add_pond_state.dart';

class AddPondCubit extends Cubit<AddPondState> {
  AddPondCubit(this.refService) : super(const AddPondState());

  final RefService refService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      emit(state.copyWith(
        status: GlobalState.loaded,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void changeStep(int index) {
    emit(state.copyWith(status: GlobalState.loading));
    emit(state.copyWith(
      index: index,
      status: GlobalState.refresh,
    ));
  }
}
