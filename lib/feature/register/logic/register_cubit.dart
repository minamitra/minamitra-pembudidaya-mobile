import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationService) : super(const RegisterState());

  final AuthenticationService authenticationService;

  void register({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: GlobalState.showDialogLoading));
      final response = await authenticationService.register(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
      if (response ?? false) {
        emit(state.copyWith(status: GlobalState.hideDialogLoading));
        emit(state.copyWith(status: GlobalState.successSubmit));
      } else {
        emit(state.copyWith(status: GlobalState.hideDialogLoading));
        emit(state.copyWith(
          status: GlobalState.error,
          errorMessage: "Gagal mendaftar",
        ));
      }
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
