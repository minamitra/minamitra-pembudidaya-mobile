part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.userData,
  });

  final GlobalState status;
  final String errorMessage;
  final UserData? userData;

  UserState copyWith({
    GlobalState? status,
    String? errorMessage,
    UserData? userData,
  }) {
    return UserState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        userData,
      ];
}
