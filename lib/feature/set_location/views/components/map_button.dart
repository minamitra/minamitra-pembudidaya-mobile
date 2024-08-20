import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_button.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/repositories/map_callback_data.dart';

class MapButton extends StatelessWidget {
  const MapButton(this.controller, {Key? key}) : super(key: key);

  final GoogleMapController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetLocationCubit, SetLocationState>(
      listener: (_, state) {
        if (state.status == SetLocationStateStatus.error) {
          Fluttertoast.showToast(
            msg: "Error : ${state.error.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (_, state) {
        if (state.status == SetLocationStateStatus.error) {
          return Container();
        }
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 55),
            child: BlocBuilder<SetLocationCubit, SetLocationState>(
              builder: (_, state) => SizedBox(
                height: 35,
                child: AppAnimatedButton(
                  "Pilih Lokasi",
                  () async {
                    if (controller != null) {
                      await controller!.takeSnapshot().then((value) {
                        if (value != null) {
                          Navigator.of(context).pop(MapCallbackData(
                            LatLng(
                              state.latitude ?? 0,
                              state.longitude ?? 0,
                            ),
                            value,
                          ));
                        }
                      });
                    }
                  },
                  loading: state.status ==
                          SetLocationStateStatus.loadingUpdateLatLong ||
                      state.status == SetLocationStateStatus.loading,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
