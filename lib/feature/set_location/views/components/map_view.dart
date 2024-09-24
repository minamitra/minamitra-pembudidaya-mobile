import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_debounce.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';

class MapView extends StatelessWidget {
  MapView(
    this.initLocation,
    this.onMapCreated, {
    super.key,
  });

  final LatLng initLocation;
  final void Function(GoogleMapController)? onMapCreated;
  AppDebounce debounce = AppDebounce(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initLocation,
        zoom: 16,
      ),
      onMapCreated: onMapCreated,
      mapType: MapType.normal,
      onCameraMove: (camera) {
        debounce.call(() {
          context.read<SetLocationCubit>().updateLocation(LatLng(
                camera.target.latitude,
                camera.target.longitude,
              ));
        });
      },
      onCameraMoveStarted: () {
        context.read<SetLocationCubit>().startUpdatingLocation();
      },
      onCameraIdle: () async {
        context.read<SetLocationCubit>().endUpdatingLocation();
      },
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      buildingsEnabled: true,
    );
  }
}
