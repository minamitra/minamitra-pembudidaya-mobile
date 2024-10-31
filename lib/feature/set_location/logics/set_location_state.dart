part of 'set_location_cubit.dart';

enum SetLocationStateStatus {
  initial,
  loading,
  loadingUpdateLatLong,
  loadedUpdatingLatLong,
  loaded,
  error,
}

class SetLocationState extends Equatable {
  const SetLocationState({
    required this.status,
    required this.error,
    this.latitude,
    this.longitude,
    this.snapshotMap,
    this.mapType = MapType.normal,
  });

  final SetLocationStateStatus status;
  final String error;
  final double? latitude;
  final double? longitude;
  final Uint8List? snapshotMap;
  final MapType? mapType;

  factory SetLocationState.initial() {
    return const SetLocationState(
      status: SetLocationStateStatus.initial,
      error: 'Default Error',
      latitude: null,
      longitude: null,
      snapshotMap: null,
      mapType: MapType.normal,
    );
  }

  SetLocationState copyWith({
    SetLocationStateStatus? status,
    String? error,
    double? latitude,
    double? longitude,
    Uint8List? snapshotMap,
    MapType? mapType,
  }) {
    return SetLocationState(
      status: status ?? this.status,
      error: error ?? this.error,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      snapshotMap: snapshotMap ?? this.snapshotMap,
      mapType: mapType ?? this.mapType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        latitude,
        longitude,
        snapshotMap,
        mapType,
      ];
}
