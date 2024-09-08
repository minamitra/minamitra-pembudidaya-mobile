import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_response.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(
    this.repository,
    this.sharedPreferenceService,
  ) : super(const UserState());

  final AuthenticationRepository repository;
  final SharedPreferenceService sharedPreferenceService;

  void refreshUser() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      await repository.refreshUserData();
      final userData = await sharedPreferenceService.getUserData();
      emit(state.copyWith(status: GlobalState.loaded, userData: userData));
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
