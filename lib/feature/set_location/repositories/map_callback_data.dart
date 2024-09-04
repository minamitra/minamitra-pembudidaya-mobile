import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCallbackData {
  final LatLng latLng;
  final Uint8List? snapshotMap;

  MapCallbackData(
    this.latLng,
    this.snapshotMap,
  );
}
