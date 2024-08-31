part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  const ActivityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityState(
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
