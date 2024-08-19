import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationPermissionService {
  Future<Position> getUserCurrentPosition();
  StreamSubscription<Position> get locationStream;
}

class LocationPermissionServiceImpl implements LocationPermissionService {
  final LocationSettings locationSettings;

  LocationPermissionServiceImpl(this.locationSettings);

  @override
  Future<Position> getUserCurrentPosition() async {
    return await Geolocator.getCurrentPosition().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw TimeoutException(
          'Gagal mendapatkan lokasi anda. Silahkan keluar dari aplikasi dan buka kembali untuk me-refresh.',
        );
      },
    );
  }

  @override
  StreamSubscription<Position> get locationStream {
    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(
      (Position? position) {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');
      },
    );
  }

  factory LocationPermissionServiceImpl.create() {
    LocationSettings settings;
    if (defaultTargetPlatform == TargetPlatform.android) {
      settings = AndroidSettings(
        distanceFilter: 0,
        timeLimit: const Duration(seconds: 30),
        intervalDuration: const Duration(milliseconds: 500),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      settings = AppleSettings(
        activityType: ActivityType.automotiveNavigation,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      settings = const LocationSettings(
        distanceFilter: 10,
      );
    }
    return LocationPermissionServiceImpl(settings);
  }
}
