import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'set_location_state.dart';

class SetLocationCubit extends Cubit<SetLocationState> {
  SetLocationCubit() : super(SetLocationState.initial());

  void updateLocation(LatLng latLng) {
    try {
      emit(state.copyWith(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SetLocationStateStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> takeSnapshotMap() async {
    emit(state.copyWith(status: SetLocationStateStatus.loading));
  }

  void startUpdatingLocation() {
    try {
      emit(state.copyWith(status: SetLocationStateStatus.loadingUpdateLatLong));
    } catch (e) {
      emit(state.copyWith(
        status: SetLocationStateStatus.error,
        error: e.toString(),
      ));
    }
  }

  void endUpdatingLocation() {
    try {
      emit(
          state.copyWith(status: SetLocationStateStatus.loadedUpdatingLatLong));
    } catch (e) {
      emit(state.copyWith(
        status: SetLocationStateStatus.error,
        error: e.toString(),
      ));
    }
  }
}
