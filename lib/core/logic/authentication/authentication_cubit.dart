import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this.authenticationRepository,
    // this.fcmTokenRepository,
  ) : super(AuthenticationState.initial());

  final AuthenticationRepository authenticationRepository;
  // final FCMTokenRepository fcmTokenRepository;

  late StreamSubscription<AuthenticationStatus>
      authenticationStatusSubscription;

  Future<void> listeningStatus() async {
    try {
      authenticationStatusSubscription =
          authenticationRepository.streamedStatus.listen(
        (status) => emit(state.copyWith(status: status)),
      );
      await authenticationRepository.initAuthenticationStatus();
      // await fcmTokenRepository.syncFCMToken();
    } on TokenExpired catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.unauthenticated,
        message: e.message.toString(),
      ));
    } on TokenNotFound catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.unknown,
        message: e.message.toString(),
      ));
    } on FailedAuthorizingProfile catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.error,
        message: e.message.toString(),
      ));
    } on FailedSaveUserProfile catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.error,
        message: e.message.toString(),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.error,
        message: e.message.toString(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.error,
        message: e.toString(),
      ));
    }
  }
}
