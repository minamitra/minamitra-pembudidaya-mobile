import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';

class MapPanel extends StatelessWidget {
  const MapPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPanelLocation(LatLng latLng) {
      return AppDefaultCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColor.primary,
                ),
                SizedBox(width: 8.0),
                Text("Letak Lokasi")
              ],
            ),
            const SizedBox(height: 12.0),
            Divider(color: AppColor.neutral[300]),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Text("Latitude : "),
                const SizedBox(width: 8.0),
                Text(latLng.latitude.toString()),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text("Longitude : "),
                const SizedBox(width: 8.0),
                Text(latLng.longitude.toString()),
              ],
            ),
          ],
        ),
      );
    }

    return BlocBuilder<SetLocationCubit, SetLocationState>(
      builder: (context, state) {
        if (state.status == SetLocationStateStatus.loaded ||
            state.status == SetLocationStateStatus.loadedUpdatingLatLong) {
          return AppAnimatedSize(
            isShow: state.status == SetLocationStateStatus.loaded ||
                state.status == SetLocationStateStatus.loadedUpdatingLatLong,
            child: _buildPanelLocation(LatLng(
              state.latitude ?? 0,
              state.longitude ?? 0,
            )),
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
