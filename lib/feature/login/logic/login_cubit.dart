import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login({
    required String email,
    required String password,
  }) {
    emit(state.copyWith(status: GlobalState.loading));
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // emit(state.copyWith(status: GlobalState.success));
      },
    );
    emit(state.copyWith(status: GlobalState.error));
  }
}
