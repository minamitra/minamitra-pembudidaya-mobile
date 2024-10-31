
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';

class MapPanel extends StatefulWidget {
  const MapPanel(this.initLatLong, this.controller, {super.key});

  final LatLng initLatLong;
  final GoogleMapController? controller;

  @override
  State<MapPanel> createState() => _MapPanelState();
}

class _MapPanelState extends State<MapPanel> {
  @override
  Widget build(BuildContext context) {
    Widget buildPanelLocation(LatLng latLng) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              context
                  .read<SetLocationCubit>()
                  .updateLocation(widget.initLatLong);
              if (widget.controller != null) {
                widget.controller!.animateCamera(
                  CameraUpdate.newLatLng(widget.initLatLong),
                );
              }
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(2.0),
                  boxShadow: AppBoxShadow().large,
                ),
                child: Icon(
                  Icons.location_searching_rounded,
                  color: AppColor.neutral[700],
                  size: 24.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          AppDefaultCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColor.primary,
                    ),
                    SizedBox(width: 8.0),
                    Text('Letak Lokasi'),
                  ],
                ),
                const SizedBox(height: 12.0),
                Divider(color: AppColor.neutral[300]),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text('Latitude : '),
                    const SizedBox(width: 8.0),
                    Text(latLng.latitude.toString()),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Text('Longitude : '),
                    const SizedBox(width: 8.0),
                    Text(latLng.longitude.toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return BlocBuilder<SetLocationCubit, SetLocationState>(
      builder: (context, state) {
        if (state.status == SetLocationStateStatus.loaded ||
            state.status == SetLocationStateStatus.loadedUpdatingLatLong) {
          return AppAnimatedSize(
            isShow: state.status == SetLocationStateStatus.loaded ||
                state.status == SetLocationStateStatus.loadedUpdatingLatLong,
            child: buildPanelLocation(
              LatLng(
                state.latitude ?? 0,
                state.longitude ?? 0,
              ),
            ),
          );
        } else {
          return const AppShimmer(
            150,
            double.infinity,
            15.0,
          );
        }
      },
    );
  }
}
