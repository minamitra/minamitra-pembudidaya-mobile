import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';

Future<bool> requestLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permissionGranted;

  Future<void> getServiceLocation() async {
    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied ||
        permissionGranted == LocationPermission.deniedForever) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.denied ||
          permissionGranted == LocationPermission.deniedForever) {
        if (Platform.isAndroid) {
          await Geolocator.openAppSettings();
        }
        permissionGranted = await Geolocator.checkPermission();
        if (permissionGranted == LocationPermission.denied ||
            permissionGranted == LocationPermission.deniedForever) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          throw AppException("Permission Danied");
        }
      }
    }
  }

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    if (Platform.isAndroid) await Geolocator.openLocationSettings();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      throw AppException("Permission Danied");
    } else {
      getServiceLocation();
    }
  } else {
    await getServiceLocation();
  }

  return true;
}

enum LocationPermissionStatus {
  denied,
  deniedForever,
  granted,
  unknown,
}

class RequesLocationCubit extends Cubit<LocationPermissionStatus> {
  RequesLocationCubit() : super(LocationPermissionStatus.unknown);

  Future<void> checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      emit(LocationPermissionStatus.denied);
    } else {
      emit(LocationPermissionStatus.granted);
    }
  }
}
