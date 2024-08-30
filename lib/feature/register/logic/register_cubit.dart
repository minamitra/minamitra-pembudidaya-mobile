import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void register({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) {
    try {
      emit(state.copyWith(status: GlobalState.loading));
      Future.delayed(
        const Duration(seconds: 3),
        () {
          // emit(state.copyWith(status: GlobalState.success));
        },
      );
      emit(state.copyWith(status: GlobalState.error));
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
