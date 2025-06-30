import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/logic/activity_incident_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityIncidentDetailView extends StatefulWidget {
  const ActivityIncidentDetailView({super.key});

  @override
  State<ActivityIncidentDetailView> createState() =>
      _ActivityIncidentDetailViewState();
}

class _ActivityIncidentDetailViewState
    extends State<ActivityIncidentDetailView> {
  @override
  Widget build(BuildContext context) {
    final activityIncidentDetailCubit =
        context.read<ActivityIncidentDetailCubit>();

    Widget columnText(String title, String value) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall!,
          ),
        ],
      );
    }

    Widget fileAttachment() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'File Lampiran',
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const SizedBox(height: 8.0),
          activityIncidentDetailCubit.incident?.attachmentJsonArray?.isEmpty ??
                  true
              ? Text(
                  '-',
                  textAlign: TextAlign.center,
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[500],
                      ),
                )
              : SizedBox(
                  height: 160.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: activityIncidentDetailCubit
                            .incident?.attachmentJsonArray?.length ??
                        0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showImageViewer(
                            context,
                            Image.network(
                              activityIncidentDetailCubit
                                      .incident?.attachmentJsonArray?[index] ??
                                  '',
                            ).image,
                            immersive: false,
                            useSafeArea: true,
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                            backgroundColor: Colors.black.withOpacity(0.7),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: 3 / 2,
                            child: Image.network(
                              activityIncidentDetailCubit
                                      .incident?.attachmentJsonArray?[index] ??
                                  '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      );
    }

    Widget statusBar() {
      return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: incidentStatusColor(
            activityIncidentDetailCubit.incident?.status ??
                IncidentStatus.waiting,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          'Status Laporan ${incidentStatusToString(activityIncidentDetailCubit.incident?.status)}',
          textAlign: TextAlign.start,
          style: appTextTheme(context).titleSmall?.copyWith(
                color: AppColor.white,
              ),
        ),
      );
    }

    Widget body() {
      return ListView(
        children: [
          statusBar(),
          const SizedBox(height: 0),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: AppColor.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                columnText(
                  'Judul Laporan',
                  activityIncidentDetailCubit.incident?.incident ?? '-',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                columnText(
                  'Tanggal',
                  activityIncidentDetailCubit.incident?.datetime != null
                      ? AppConvertDateTime().ddmmyyyyhhmm(
                          activityIncidentDetailCubit.incident!.datetime!,
                        )
                      : '-',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                columnText(
                  'Catatan',
                  activityIncidentDetailCubit.incident?.note ?? '-',
                ),
                Divider(
                  height: 32.0,
                  thickness: 1,
                  color: AppColor.neutral[100],
                ),
                fileAttachment(),
              ],
            ),
          ),
          const SizedBox(height: 98.0),
        ],
      );
    }

    Widget button() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: AppColor.neutral[200]!,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppPrimaryOutlineButton(
                'Hapus',
                () {},
                prefixIcon: Image.asset(
                  AppAssets.trashIcon,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: AppPrimaryOutlineButton(
                'Edit',
                () {},
                prefixIcon: Image.asset(
                  AppAssets.editIcon,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<ActivityIncidentDetailCubit,
        ActivityIncidentDetailState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return body();

        // Stack(
        //   alignment: Alignment.bottomCenter,
        //   children: [
        //     ,
        //     // button(),
        //   ],
        // );
      },
    );
  }
}
