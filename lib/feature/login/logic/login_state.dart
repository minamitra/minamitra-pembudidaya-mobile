part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = GlobalState.initial,
    this.message = '',
  });

  final GlobalState status;
  final String message;

  LoginState copyWith({
    GlobalState? status,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
