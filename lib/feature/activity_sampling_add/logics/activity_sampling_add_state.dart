part of 'activity_sampling_add_cubit.dart';

class ActivitySamplingAddState extends Equatable {
  const ActivitySamplingAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivitySamplingAddState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivitySamplingAddState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
