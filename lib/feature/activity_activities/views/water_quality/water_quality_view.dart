import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/water_quality_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/water_quality_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_detail/views/activity_water_quality_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class WaterQualityView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final String datetime;

  const WaterQualityView(
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime, {
    super.key,
  });

  @override
  State<WaterQualityView> createState() => _WaterQualityViewState();
}

class _WaterQualityViewState extends State<WaterQualityView> {
  @override
  Widget build(BuildContext context) {
    Widget itemCard(WaterQualityResponseData data) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(AppTransition.pushTransition(
            ActivityWaterQualityDetailPage(data),
            ActivityWaterQualityDetailPage.routeSettings(),
          ))
              .then((value) {
            if (value == "refresh") {
              context.read<WaterQualityCubit>().init(
                    widget.fishpondId,
                    widget.fishpondcycleId,
                    widget.datetime,
                  );
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.level != null
                            ? 'Keinggian Air ${data.level} cm'
                            : '-',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        data.datetime != null ? data.datetime.toString() : "-",
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
                      // showDialog(
                      //   context: context,
                      //   builder: (dialogContext) {
                      //     return AppDialogComponent(
                      //       title: "Hapus Kualitas Air",
                      //       subTitle:
                      //           "Apakah Anda yakin ingin menghapus kualitas air ini?",
                      //       buttons: [
                      //         Expanded(
                      //           child: AppPrimaryOutlineFullButton(
                      //             "Batal",
                      //             () {
                      //               Navigator.of(context).pop();
                      //             },
                      //           ),
                      //         ),
                      //         const SizedBox(width: 8),
                      //         Expanded(
                      //           child: AppPrimaryFullButton(
                      //             "Hapus",
                      //             () {
                      //               context
                      //                   .read<WaterQualityCubit>()
                      //                   .deleteWaterQuality(
                      //                     data.id ?? "",
                      //                     widget.fishpondId,
                      //                     widget.fishpondcycleId,
                      //                     widget.datetime,
                      //                   );
                      //               Navigator.of(context).pop();
                      //             },
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                      showDeleteBottomSheet(
                        context,
                        title: "Hapus Kualitas Air",
                        descriptions:
                            "Apakah Anda yakin ingin menghapus kualitas air ini?",
                        onTapDelete: () {
                          context.read<WaterQualityCubit>().deleteWaterQuality(
                                data.id ?? "",
                                widget.fishpondId,
                                widget.fishpondcycleId,
                                widget.datetime,
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
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Image.asset(AppAssets.phNewIcon, height: 20.0),
                  const SizedBox(width: 8.0),
                  Text(data.ph != null ? data.ph.toString() : "-",
                      style: appTextTheme(context).titleSmall),
                  const SizedBox(width: 24.0),
                  Image.asset(AppAssets.temperatureIcon, height: 20.0),
                  const SizedBox(width: 8.0),
                  Text(data.ph != null ? '${data.ph.toString()} °C' : "-",
                      style: appTextTheme(context).titleSmall),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<WaterQualityCubit, WaterQualityState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status.isLoaded) {
          return state.waterQualities!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(16, 84, 16, 0),
                  child: AppEmptyData(
                      "Belum ada data, tekan tombol + untuk menambahkan aktivitas baru"),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.waterQualities!.length,
                  separatorBuilder: (context, index) => Container(
                    height: 16.0,
                    width: double.infinity,
                    color: AppColor.neutralBlueGrey[50],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 18.0,
                  //     vertical: 16.0,
                  //   ),
                  //   color: AppColor.neutralBlueGrey[50],
                  //   child: Text(
                  //     "Hari ini",
                  //     style: appTextTheme(context).titleSmall?.copyWith(
                  //           color: AppColor.neutral[400],
                  //         ),
                  //   ),
                  // ),
                  itemBuilder: (context, index) {
                    return itemCard(state.waterQualities![index]);
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}
