part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
  });

  final GlobalState status;
  final String errorMessage;

  ProfileState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ProfileState(
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
