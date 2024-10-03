import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/logics/incident_data_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/views/activity_incident_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class IncidentDataView extends StatefulWidget {
  const IncidentDataView({super.key});

  @override
  State<IncidentDataView> createState() => _IncidentDataViewState();
}

class _IncidentDataViewState extends State<IncidentDataView> {
  Widget itemCard(IncidentResponseData incident) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(AppTransition.pushTransition(
                ActivityIncidentDetailPage(incident),
                ActivityIncidentDetailPage.routeSettings()))
            .then((value) {
          if (value != null || value == "refresh") {
            context.read<IncidentDataCubit>().getIncidentData();
          }
        });
      },
      child: Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      incident.incident ?? '-',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      incident.datetime != null
                          ? incident.datetime.toString()
                          : "-",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).labelLarge?.copyWith(
                            color: AppColor.black[500],
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showDeleteBottomSheet(
                      context,
                      title: "Hapus Sampling",
                      descriptions:
                          "Apakah Anda yakin ingin menghapus sampling ini?",
                      onTapDelete: () {
                        context.read<IncidentDataCubit>().deleteIncident(
                              incident.id ?? "",
                            );
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Image.asset(
                    AppAssets.trashIcon,
                    height: 20.0,
                    color: AppColor.neutral[400],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Image.asset(
                  AppAssets.stickyNoteIcon,
                  height: 20.0,
                ),
                const SizedBox(width: 12.0),
                Text(
                  incident.note ?? '-',
                  style: appTextTheme(context).titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: incidentStatusColor(incident.status!).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: incidentStatusColor(incident.status!),
                  ),
                ),
                child: Text(
                  incidentStatusToString(incident.status),
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: incidentStatusColor(incident.status!),
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncidentDataCubit, IncidentDataState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status.isLoaded) {
          return state.incidents!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(16, 124, 16, 0),
                  child: AppEmptyData(
                      "Belum ada data, tekan tombol + untuk menambahkan aktivitas baru"),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.incidents!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return itemCard(state.incidents![index]);
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}
