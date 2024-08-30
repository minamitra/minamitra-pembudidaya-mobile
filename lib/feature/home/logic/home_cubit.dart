import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      // get feature
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
}
