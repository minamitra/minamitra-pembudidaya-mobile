part of 'profile_member_cubit.dart';

class ProfileMemberState extends Equatable {
  const ProfileMemberState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.tabIndex = 0,
  });

  final GlobalState status;
  final String errorMessage;
  final int tabIndex;

  ProfileMemberState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? tabIndex,
  }) {
    return ProfileMemberState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        tabIndex,
      ];
}
