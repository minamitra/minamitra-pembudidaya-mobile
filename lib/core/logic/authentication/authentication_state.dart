part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.message = '',
  });

  final AuthenticationStatus status;
  final String message;

  factory AuthenticationState.initial() {
    return const AuthenticationState(
      status: AuthenticationStatus.initial,
      message: "UNKNOWN ERROR - DEFAULT",
    );
  }

  AuthenticationState copyWith({
    AuthenticationStatus? status,
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
