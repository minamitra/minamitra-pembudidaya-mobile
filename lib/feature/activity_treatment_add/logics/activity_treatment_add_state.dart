part of 'activity_treatment_add_cubit.dart';

class ActivityTreatmentAddState extends Equatable {
  const ActivityTreatmentAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityTreatmentAddState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityTreatmentAddState(
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
