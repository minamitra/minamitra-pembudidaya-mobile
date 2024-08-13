import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/connection_check/connection_check_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class ConnectionCheckCubit extends Cubit<ConnectionCheckState> {
  ConnectionCheckCubit() : super(ConnectionCheckInitial());

  late StreamSubscription<Future<bool>> connectionSubscriptions;
  bool isConnected = true;

  Future<void> streamConnection() async {
    final stream = Stream<Future<bool>>.periodic(
      const Duration(seconds: 5),
      (i) async {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            if (!isConnected) {
              FlutterStatusbarcolor.setStatusBarColor(
                AppColor.primary,
                animate: true,
              );
            }
            isConnected = true;
            return true;
          } else {
            isConnected = false;
            return false;
          }
        } on SocketException catch (_) {
          if (isConnected) {
            FlutterStatusbarcolor.setStatusBarColor(
              Colors.red,
              animate: true,
            );
          }
          isConnected = false;
          return false;
        }
      },
    );

    connectionSubscriptions = stream.listen((event) async {
      event.then((value) {
        if (value) {
          if (state is! ConnectionCheckConnected) {
            emit(ConnectionCheckConnected());
          }
        } else {
          emit(ConnectionCheckDisconnected());
        }
      });
    });
  }
}
