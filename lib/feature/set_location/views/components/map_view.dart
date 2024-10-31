import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_debounce.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';

class MapView extends StatefulWidget {
  const MapView(
    this.initLocation,
    this.onMapCreated, {
    super.key,
  });

  final LatLng initLocation;
  final void Function(GoogleMapController)? onMapCreated;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  AppDebounce debounce = AppDebounce(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetLocationCubit, SetLocationState>(
      builder: (context, state) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.initLocation,
            zoom: 16,
          ),
          onMapCreated: widget.onMapCreated,
          mapType: state.mapType ?? MapType.normal,
          onCameraMove: (camera) {
            debounce.call(() {
              context.read<SetLocationCubit>().updateLocation(
                    LatLng(
                      camera.target.latitude,
                      camera.target.longitude,
                    ),
                  );
            });
          },
          onCameraMoveStarted: () {
            context.read<SetLocationCubit>().startUpdatingLocation();
          },
          onCameraIdle: () async {
            context.read<SetLocationCubit>().endUpdatingLocation();
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          buildingsEnabled: true,
          trafficEnabled: true,
        );
      },
    );
  }
}
