part of 'treatment_cubit.dart';

class TreatmentState extends Equatable {
  const TreatmentState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.treatments,
  });

  final GlobalState status;
  final String errorMessage;
  final List<TreatmentResponseData>? treatments;

  TreatmentState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<TreatmentResponseData>? treatments,
  }) {
    return TreatmentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      treatments: treatments ?? this.treatments,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        treatments,
      ];
}
