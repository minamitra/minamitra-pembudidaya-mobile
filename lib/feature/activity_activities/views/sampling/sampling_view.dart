import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/sampling_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/sampling_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_detail/views/activity_sampling_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class SamplingView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final String datetime;

  const SamplingView(
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime, {
    super.key,
  });

  @override
  State<SamplingView> createState() => _SamplingViewState();
}

class _SamplingViewState extends State<SamplingView> {
  @override
  Widget build(BuildContext context) {
    Widget itemCard(SamplingResponseData data) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(AppTransition.pushTransition(
            ActivitySamplingDetailPage(data),
            ActivitySamplingDetailPage.routeSettings(),
          ))
              .then((value) {
            if (value == "refresh") {
              context.read<SamplingCubit>().init(
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
                        data.mbw != null ? 'MBW ${data.mbw} Gram' : '-',
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
                      showDeleteBottomSheet(
                        context,
                        title: "Hapus Sampling",
                        descriptions:
                            "Apakah Anda yakin ingin menghapus sampling ini?",
                        onTapDelete: () {
                          context.read<SamplingCubit>().deleteSampling(
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
                  Image.asset(
                    AppAssets.bussinessStatisticIcon,
                    height: 20.0,
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    data.sr != null
                        ? 'SR ${double.parse(data.sr!).round()}%'
                        : '-',
                    style: appTextTheme(context).titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<SamplingCubit, SamplingState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status.isLoaded) {
          return state.samplings!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(16, 84, 16, 0),
                  child: AppEmptyData(
                      "Belum ada data, tekan tombol + untuk menambahkan aktivitas baru"),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.samplings!.length,
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
                    return itemCard(state.samplings![index]);
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}
