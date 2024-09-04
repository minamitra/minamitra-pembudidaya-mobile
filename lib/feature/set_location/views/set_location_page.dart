import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/location_service/location_permission.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/init_first_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/components/location_error.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/set_location_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SetLocationPage extends StatelessWidget {
  const SetLocationPage({Key? key}) : super(key: key);

  static RouteSettings routeSettings() {
    return const RouteSettings(name: "/Set-location-page");
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<RequesLocationCubit>(create: (BuildContext context) {
          return RequesLocationCubit()..checkLocationPermission();
        }),
        BlocProvider<InitFirstLocationCubit>(create: (BuildContext context) {
          return InitFirstLocationCubit();
        }),
        BlocProvider<SetLocationCubit>(create: (BuildContext context) {
          return SetLocationCubit();
        }),
      ],
      child: BlocListener<SetLocationCubit, SetLocationState>(
        listener: (context, state) {
          if (state.status == SetLocationStateStatus.loading) {
            AppDialog().showLoadingDialog(context, dialog);
          } else {
            dialog.hide();
          }
        },
        child: Scaffold(
          body: BlocBuilder<RequesLocationCubit, LocationPermissionStatus>(
            builder: (context, state) {
              switch (state) {
                case LocationPermissionStatus.unknown:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case LocationPermissionStatus.denied:
                case LocationPermissionStatus.deniedForever:
                  return LocationErrorWidget(
                    error: "Location service permission denied",
                    callback: () => context
                        .read<RequesLocationCubit>()
                        .checkLocationPermission(),
                  );
                case LocationPermissionStatus.granted:
                  if (context.read<InitFirstLocationCubit>().state ==
                      InitFirstLocationStatus.initial) {
                    context.read<InitFirstLocationCubit>().getLocation();
                  }
                  return const LocationScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
