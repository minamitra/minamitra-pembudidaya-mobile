import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';

class MapMarker extends StatelessWidget {
  const MapMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetLocationCubit, SetLocationState>(
      builder: (_, state) {
        if (state.status == SetLocationStateStatus.error) {
          return Container();
        }
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 35),
            child: const Icon(
              Icons.location_on,
              size: 50,
              color: AppColor.primary,
            ),
          ),
        );
      },
    );
  }
}
