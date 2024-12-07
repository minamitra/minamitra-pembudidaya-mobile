import 'dart:developer';
import 'dart:io';
import 'dart:isolate' as isolate;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/env.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_downloader.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';

import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/logic/resume_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/views/resume_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:permission_handler/permission_handler.dart';

class ResumeDetailPage extends StatefulWidget {
  const ResumeDetailPage(
    this.pondID,
    this.pondCycleID,
    this.data, {
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final ResumePerCycleResponseData data;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/resume-detail-page');
  }

  @override
  State<ResumeDetailPage> createState() => _ResumeDetailPageState();
}

class _ResumeDetailPageState extends State<ResumeDetailPage> {
  String _localPath = '';
  final isolate.ReceivePort? _port = kIsWeb ? null : isolate.ReceivePort();

  @override
  void initState() {
    _prepareSaveDir();
    _bindBackgroundIsolate();
    super.initState();
  }

  @override
  void dispose() {
    _unBindBackgroundIsolate();
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    final isolate.SendPort? send = kIsWeb
        ? null
        : IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    bindIsolate(
      downloadCallback,
      _port!.sendPort,
    );
    _port.listen((dynamic data) {
      final DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
      if (status == DownloadTaskStatus.failed) {
        AppTopSnackBar(context)
            .showDanger('Failed Download\nsilahkan coba lagi');
      } else {}
      if (status == DownloadTaskStatus.complete) {
        AppTopSnackBar(context)
            .showSuccess('Berhasil download file\nSilahkan cek notifikasi');
      }
    });
  }

  void _unBindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeDetailCubit(CycleServiceImpl.create())
        ..init(widget.pondCycleID),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Detail Resume',
          actions: [
            InkWell(
              onTap: () async {
                // Check downloader permission
                bool isGrantedPermission = await checkDownloaderPermission();
                if (!isGrantedPermission) {
                  AppTopSnackBar(context)
                      .showDanger('Izinkan akses penyimpanan');
                  return;
                }
                // Check notification permission
                bool isGrantedNotification =
                    await checkNotificationPermission();
                if (!isGrantedNotification) {
                  AppTopSnackBar(context)
                      .showDanger('Izinkan akses notifikasi');
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      openAppSettings();
                    },
                  );

                  return;
                }
                await download(
                  'https://${env.baseURL}/mitra/resume-budidaya/print-resume?fishpondcycle_id=${widget.pondCycleID}',
                  _localPath,
                  context,
                );
              },
              child: const Icon(
                Icons.file_download_outlined,
                color: AppColor.white,
              ),
            ),
            const SizedBox(width: 18.0),
          ],
        ),
        body: ResumeDetailView(
          widget.pondID,
          widget.pondCycleID,
          widget.data,
        ),
      ),
    );
  }
}
