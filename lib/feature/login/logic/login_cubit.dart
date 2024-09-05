import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());
    try {
      await authenticationRepository.login(request);
      emit(LoginLoaded());
    } on AppException catch (e) {
      emit(LoginFailed(e.message));
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
