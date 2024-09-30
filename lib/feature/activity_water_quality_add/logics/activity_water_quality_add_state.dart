part of 'activity_water_quality_add_cubit.dart';

class ActivityWaterQualityAddState extends Equatable {
  const ActivityWaterQualityAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityWaterQualityAddState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityWaterQualityAddState(
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
