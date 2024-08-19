import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/init_first_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/location_error.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/map_button.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/map_marker.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/map_panel.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/map_view.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? controller;
  Completer<GoogleMapController> completer = Completer<GoogleMapController>();

  @override
  void dispose() {
    if (controller != null) controller!.dispose();
    completer.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _mapView(LatLng initLatLng) {
      return Stack(
        children: [
          MapView(
            initLatLng,
            (googleMapController) {
              setState(() {
                controller = googleMapController;
                completer.complete(googleMapController);
              });
            },
          ),
          const MapMarker(),
          MapButton(controller),
          const Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: MapPanel(),
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (completer.isCompleted) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: appDefaultAppBar(context, "Lokasi"),
        body: BlocBuilder<InitFirstLocationCubit, InitFirstLocationStatus>(
          builder: (context, state) {
            switch (state) {
              case InitFirstLocationStatus.initial:
              case InitFirstLocationStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case InitFirstLocationStatus.error:
                return LocationErrorWidget(
                  error: "Failed to get location",
                  callback: () =>
                      context.read<InitFirstLocationCubit>().getLocation(),
                );
              case InitFirstLocationStatus.loaded:
                context.read<SetLocationCubit>().updateLocation(
                    context.read<InitFirstLocationCubit>().latLng);
                return _mapView(context.read<InitFirstLocationCubit>().latLng);
            }
          },
        ),
      ),
    );
  }
}
