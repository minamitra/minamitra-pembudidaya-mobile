part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = GlobalState.initial,
    this.message = '',
  });

  final GlobalState status;
  final String message;

  AuthenticationState copyWith({
    GlobalState? status,
    String? message,
  }) {
    return AuthenticationState(
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
