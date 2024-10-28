part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.isObscureOldPassword = true,
    this.isObscureNewPassword = true,
    this.isObscureConfirmPassword = true,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isObscureOldPassword;
  final bool isObscureNewPassword;
  final bool isObscureConfirmPassword;

  ChangePasswordState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isObscureOldPassword,
    bool? isObscureNewPassword,
    bool? isObscureConfirmPassword,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isObscureOldPassword: isObscureOldPassword ?? this.isObscureOldPassword,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isObscureOldPassword,
        isObscureNewPassword,
        isObscureConfirmPassword,
      ];
}
