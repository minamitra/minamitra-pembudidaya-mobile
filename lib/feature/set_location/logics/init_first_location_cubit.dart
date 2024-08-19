import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum InitFirstLocationStatus {
  initial,
  loading,
  loaded,
  error,
}

class InitFirstLocationCubit extends Cubit<InitFirstLocationStatus> {
  InitFirstLocationCubit() : super(InitFirstLocationStatus.initial);

  late LatLng latLng;

  Future<void> getLocation() async {
    emit(InitFirstLocationStatus.loading);
    try {
      final location = await Geolocator.getCurrentPosition();
      latLng = LatLng(location.latitude, location.longitude);
      emit(InitFirstLocationStatus.loaded);
    } catch (e) {
      emit(InitFirstLocationStatus.error);
    }
  }
}
