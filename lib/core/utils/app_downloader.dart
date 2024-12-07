//@dart = 2.12

import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestDownloadFile(
  Map<String, String> header,
  String url,
  String saveDir,
) async {
  FlutterDownloader.enqueue(
    url: url,
    headers: header,
    savedDir: saveDir,
    showNotification: true,
    openFileFromNotification: true,
    saveInPublicStorage: true,
    timeout: 15000,
  ).then((value) {
    log("Data = $value");
  });
}

void bindIsolate(
  void Function(String, int, int) callback,
  SendPort port,
) {
  FlutterDownloader.registerCallback(
    callback,
    step: 1,
  );
  IsolateNameServer.registerPortWithName(
    port,
    'downloader_send_port',
  );
}

Future<String?> getSavedDir() async {
  String? externalStorageDirPath;
  if (Platform.isAndroid) {
    try {
      externalStorageDirPath = await AndroidPathProvider.downloadsPath;
    } catch (err, st) {
      print('failed to get downloads path: $err, $st');
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  } else if (Platform.isIOS) {
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
  }
  return externalStorageDirPath;
}

Future<bool> checkDownloaderPermission() async {
  if (kIsWeb) {
    return true;
  }

  if (Platform.isIOS) {
    return true;
  }

  if (Platform.isAndroid) {
    final info = await DeviceInfoPlugin().androidInfo;
    if ((info.version.sdkInt) > 28) {
      return true;
    }

    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    }

    final result = await Permission.storage.request();
    return result == PermissionStatus.granted;
  }

  throw StateError('unknown platform');
}

Future<bool> checkNotificationPermission() async {
  if (kIsWeb) {
    return true;
  }

  if (Platform.isIOS) {
    return true;
  }

  if (Platform.isAndroid) {
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
  throw StateError("unknown platform");
}

Future<void> download(
  String linkUrl,
  String saveDirectory,
  BuildContext context,
) async {
  final SharedPreferenceService sharedPreferenceService =
      SharedPreferenceServiceImpl.create();
  final accessToken = await sharedPreferenceService
      .getSharedPreference(AppSharedPrefKey.tokenKey);

  if (Platform.isIOS) {
    // Utilities.intentOpenUrl(link: linkUrl);
  } else if (Platform.isAndroid) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Downloading file, Silahkan lihat di notifikasi',
        ),
      ),
    );
    requestDownloadFile(
      {'token': '$accessToken'},
      linkUrl,
      saveDirectory,
    );
  }
}
