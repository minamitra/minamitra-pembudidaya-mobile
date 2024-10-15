import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.service) : super(const ChangePasswordState());

  final ProfileService service;

  void onChangeObscure({
    bool? isObscureOldPassword,
    bool? isObscureNewPassword,
    bool? isObscureConfirmPassword,
  }) {
    emit(state.copyWith(
      isObscureOldPassword: isObscureOldPassword,
      isObscureNewPassword: isObscureNewPassword,
      isObscureConfirmPassword: isObscureConfirmPassword,
    ));
  }

  Future<void> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.updatePassword(oldPassword, newPassword);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
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
