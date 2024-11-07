import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_mission_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PointMission extends StatelessWidget {
  const PointMission({super.key});

  @override
  Widget build(BuildContext context) {
    Widget missionCard({
      required String title,
      required double value,
      required String valueDescription,
      required String buttonTitle,
      void Function()? onTap,
      String? pointGain,
      bool isCompleted = false,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 16.0,
        ),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColor.neutral[200]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: appTextTheme(context).bodySmall,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.all(0.0),
                          animation: true,
                          lineHeight: 8.0,
                          animationDuration: 1000,
                          percent: value,
                          barRadius: const Radius.circular(8.0),
                          progressColor: isCompleted
                              ? AppColor.green[500]
                              : AppColor.accent[900],
                          backgroundColor: AppColor.neutral[100],
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        valueDescription,
                        style: appTextTheme(context).labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            isCompleted
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.neutral[300],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      'Selesai',
                      style: appTextTheme(context)
                          .labelLarge
                          ?.copyWith(color: AppColor.white),
                    ),
                  )
                : Column(
                    children: [
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF155ED0),
                                Color(0xFF1049A2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Text(
                            buttonTitle,
                            style: appTextTheme(context)
                                .labelLarge
                                ?.copyWith(color: AppColor.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppAssets.pointGainIcon,
                            width: 20.0,
                          ),
                          Text(
                            pointGain ?? '0',
                            style: appTextTheme(context).labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      );
    }

    Widget dayMission() {
      return BlocBuilder<PointMissionV2Cubit, PointMissionV2State>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Misi Harian',
                      style: appTextTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(
                    Icons.access_time_outlined,
                    size: 18.0,
                    color: AppColor.primary[500],
                  ),
                  const SizedBox(width: 8.0),
                  state.status.isLoading
                      ? const AppShimmer(55.0, 80.0, 100.0)
                      : Countdown(
                          seconds: state.differenceTime.inSeconds,
                          build: (BuildContext context, double time) {
                            Duration existDuration = Duration(
                              seconds: int.parse(time.toStringAsFixed(0)),
                            );
                            return Text(
                              "${existDuration.inHours.toString().padLeft(2, '0')}:${existDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${existDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                              style: appTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(color: AppColor.primary[500]),
                            );
                          },
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            context.read<PointMissionV2Cubit>().init();
                          },
                        ),
                ],
              ),
              const SizedBox(height: 18.0),
              ...List.generate(
                5,
                (index) {
                  return missionCard(
                    title: 'Lakukan 1x Transaksi',
                    value: 0.5,
                    valueDescription: '5/10',
                    buttonTitle: 'Pergi',
                    isCompleted: false,
                    pointGain: '+10',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AppBottomSheet(
                            "",
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.pointGainIcon,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '+10 Poin',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme(context).headlineMedium,
                                  ),
                                  const SizedBox(height: 24.0),
                                  Text(
                                    'Selamat! Kamu berhasil menyelesaikan misi dan mendapatkan +10 poin. Kumpulkan terus poinnya dan tukarkan dengan saldo atau uang tunai',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: appTextTheme(context).bodySmall,
                                  ),
                                  const Expanded(child: SizedBox()),
                                  AppPrimaryFullButton(
                                    'Oke',
                                    () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 18.0),
                                ],
                              ),
                            ),
                            isNeedAppBar: false,
                            height: MediaQuery.sizeOf(context).height * 0.4,
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24.0),
            ],
          );
        },
      );
    }

    Widget limitedMission() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Misi Harian',
            style: appTextTheme(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18.0),
          ...List.generate(
            5,
            (index) {
              return missionCard(
                title: 'EKYC',
                value: 1,
                valueDescription: '100%',
                buttonTitle: 'Pergi',
                isCompleted: true,
                pointGain: '+10',
              );
            },
          ),
          const SizedBox(height: 24.0),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          dayMission(),
          limitedMission(),
        ],
      ),
    );
  }
}
