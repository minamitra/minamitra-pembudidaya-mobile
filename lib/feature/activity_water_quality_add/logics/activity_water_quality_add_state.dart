part of 'activity_water_quality_add_cubit.dart';

class ActivityWaterQualityAddState extends Equatable {
  const ActivityWaterQualityAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.waterColor = const [],
    this.waterWeather = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<WaterColorResponseData> waterColor;
  final List<WaterWeatherResponseData> waterWeather;

  ActivityWaterQualityAddState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<WaterColorResponseData>? waterColor,
    List<WaterWeatherResponseData>? waterWeather,
  }) {
    return ActivityWaterQualityAddState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      waterColor: waterColor ?? this.waterColor,
      waterWeather: waterWeather ?? this.waterWeather,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        waterColor,
        waterWeather,
      ];
}
