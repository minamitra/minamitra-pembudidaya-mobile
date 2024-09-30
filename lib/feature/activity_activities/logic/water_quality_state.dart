part of 'water_quality_cubit.dart';

class WaterQualityState extends Equatable {
  const WaterQualityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.waterQualities,
  });

  final GlobalState status;
  final String errorMessage;
  final List<WaterQualityResponseData>? waterQualities;

  WaterQualityState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<WaterQualityResponseData>? waterQualities,
  }) {
    return WaterQualityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      waterQualities: waterQualities ?? this.waterQualities,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        waterQualities,
      ];
}
