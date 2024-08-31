part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
  });

  final GlobalState status;
  final String errorMessage;

  RegisterState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
