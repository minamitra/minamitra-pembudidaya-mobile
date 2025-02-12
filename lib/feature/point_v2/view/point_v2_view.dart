import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/view/history_point_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_mission_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_configuration_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/section/point_exchange.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/section/point_mission.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PointV2View extends StatefulWidget {
  const PointV2View({super.key});

  @override
  State<PointV2View> createState() => _PointV2ViewState();
}

class _PointV2ViewState extends State<PointV2View> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController exchangeTypeController = TextEditingController();
  final TextEditingController customExchangeValueController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<NameIconEntity> listLevel = [
    NameIconEntity(
      '0',
      AppAssets.bronzeV2Icon,
    ),
    NameIconEntity(
      '100',
      AppAssets.silverV2Icon,
    ),
    NameIconEntity(
      '1K',
      AppAssets.goldV2Icon,
    ),
    NameIconEntity(
      '10K',
      AppAssets.platinumV2Icon,
    ),
    NameIconEntity(
      '50K',
      AppAssets.diamondV2Icon,
    ),
  ];

  List<String> exchangeType = [
    'Konversi Saldo',
    'Tarik Tunai',
  ];

  List<NameIconEntity> listPointInfo = [
    NameIconEntity(
      'Bronze',
      AppAssets.bronzeV2Icon,
      description:
          'Selesaikan aktivitas untuk mendapatkan poin dan membuka level Bronze.',
    ),
    NameIconEntity(
      'Silver',
      AppAssets.silverV2Icon,
      description: 'Kumpulkan 100 poin untuk mendapatkan lencana Silver.',
    ),
    NameIconEntity(
      'Gold',
      AppAssets.goldV2Icon,
      description: 'Kumpulkan 1.000 poin untuk mendapatkan lencana Gold.',
    ),
    NameIconEntity(
      'Platinum',
      AppAssets.platinumV2Icon,
      description: 'Kumpulkan 10.000 poin untuk mendapatkan lencana Platinum.',
    ),
    NameIconEntity(
      'Diamond',
      AppAssets.diamondV2Icon,
      description: 'Kumpulkan 50.000 poin untuk mendapatkan lencana Diamond.',
    ),
  ];

  List<String> tocPoint = [
    '1 Poin = Rp 100',
    'Minimal penukaran poin ke saldo atau tarik tunai adalah 10 poin atau Rp 1,000',
    'Maksimal penukaran poin ke saldo atau tarik tunai adalah 10,000 poin Rp 1,000,000',
    'Akumulasi penukaran poin ke saldo atau tarik tunai adalah 10,000 poin atau Rp 1,000,000 per hari',
  ];

  Future showPointInfo(PointConfigurationResponse pointConfigruation) {
    return showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        String generateIcon(String name) {
          switch (name) {
            case 'Bronze':
              return AppAssets.bronzeV2Icon;
            case 'Silver':
              return AppAssets.silverV2Icon;
            case 'Gold':
              return AppAssets.goldV2Icon;
            case 'Platinum':
              return AppAssets.platinumV2Icon;
            case 'Diamond':
              return AppAssets.diamondV2Icon;
            default:
              return AppAssets.bronzeV2Icon;
          }
        }

        String generateIconDesc(
          String name,
          int minPoint,
        ) {
          switch (name) {
            case 'Bronze':
              return 'Selesaikan aktivitas untuk mendapatkan poin dan membuka level Bronze.';
            case 'Silver':
              return 'Kumpulkan $minPoint poin untuk mendapatkan lencana Silver.';
            case 'Gold':
              return 'Kumpulkan $minPoint poin untuk mendapatkan lencana Gold.';
            case 'Platinum':
              return 'Kumpulkan $minPoint poin untuk mendapatkan lencana Platinum.';
            case 'Diamond':
              return 'Kumpulkan $minPoint poin untuk mendapatkan lencana Diamond.';
            default:
              return 'Selesaikan $minPoint poin untuk membuka level.';
          }
        }

        return AppBottomSheet(
          'List Member Level',
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              ...List.generate(
                pointConfigruation.data?.length ?? 0,
                (index) {
                  return Column(
                    children: [
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            generateIcon(
                              pointConfigruation.data?[index].name
                                      .handlingEmptyString() ??
                                  '-',
                            ),
                            height: 28.0,
                            width: 28.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pointConfigruation.data?[index].name
                                          .handlingEmptyString() ??
                                      '-',
                                  style: appTextTheme(context)
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  generateIconDesc(
                                    pointConfigruation.data?[index].name
                                            .handlingEmptyString() ??
                                        '-',
                                    pointConfigruation.data?[index].minPoin ??
                                        0,
                                  ),
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            color: AppColor.neutral[400],
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      AppDividerSmall(),
                    ],
                  );
                },
              ),
            ],
          ),
          height: MediaQuery.sizeOf(context).height * 0.75,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget headerAppBar() {
      return Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColor.white,
            ),
          ),
          const SizedBox(width: 18.0),
          Expanded(
            child: Text(
              'Informasi Poin',
              style: appTextTheme(context)
                  .headlineSmall
                  ?.copyWith(color: AppColor.white),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const HistoryPointPage(),
                  HistoryPointPage.route,
                ),
              );
            },
            child: Text(
              'Riwayat',
              style: appTextTheme(context)
                  .titleMedium
                  ?.copyWith(color: AppColor.white),
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const HistoryPointPage(),
                  HistoryPointPage.route,
                ),
              );
            },
            child: const Icon(
              Icons.history,
              color: AppColor.white,
            ),
          ),
        ],
      );
    }

    Widget headerPointView() {
      String generateIcon(String name) {
        switch (name) {
          case 'Bronze':
            return AppAssets.bronzeV2Icon;
          case 'Silver':
            return AppAssets.silverV2Icon;
          case 'Gold':
            return AppAssets.goldV2Icon;
          case 'Platinum':
            return AppAssets.platinumV2Icon;
          case 'Diamond':
            return AppAssets.diamondV2Icon;
          default:
            return AppAssets.bronzeV2Icon;
        }
      }

      return BlocBuilder<PointMissionV2Cubit, PointMissionV2State>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.status.isLoading
                    ? const AppShimmer(64.0, 64.0, 8.0)
                    : Image.asset(
                        generateIcon(
                          state.pointBalance?.data?.levelName
                                  .handlingEmptyString() ??
                              '-',
                        ),
                        height: 64.0,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(height: 12.0),
                state.status.isLoading
                    ? const AppShimmer(22.0, 60.0, 8.0)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.pointBalance?.data?.levelName
                                    .handlingEmptyString() ??
                                '-',
                            style: appTextTheme(context).titleMedium?.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          InkWell(
                            onTap: () {
                              showPointInfo(state.pointConfigruation!);
                            },
                            child: const Icon(
                              Icons.info_outline,
                              color: AppColor.white,
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 6.0),
                state.status.isLoading
                    ? const AppShimmer(14.0, 125.0, 8.0)
                    : Text(
                        'Total perolehan poin : ${state.pointBalance?.data?.totalPoin}',
                        style: appTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: AppColor.white),
                      ),
              ],
            ),
          );
        },
      );
    }

    Widget headerPointInfoItem(
      String asset,
      String title,
      String value,
    ) {
      return Row(
        children: [
          Image.asset(
            asset,
            width: 24.0,
            height: 24.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColor.primary[300]),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget headerPointInfo() {
      return BlocBuilder<PointMissionV2Cubit, PointMissionV2State>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 78.0,
                padding: const EdgeInsets.only(
                  bottom: 18.0,
                  left: 18.0,
                  right: 18.0,
                  top: 16.0,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primary[700]!.withOpacity(0.55),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: headerPointInfoItem(
                        AppAssets.pointStarIcon,
                        state.pointBalance?.data?.totalPoinUsed.toString() ??
                            '-',
                        'Poin Digunakan',
                      ),
                    ),
                    const SizedBox(
                      height: 28.0,
                      child: VerticalDivider(thickness: 1.2),
                    ),
                    const SizedBox(width: 18.0),
                    Expanded(
                      child: headerPointInfoItem(
                        AppAssets.pointStar2Icon,
                        state.pointBalance?.data?.totalPoinRemaining
                                .toString() ??
                            '-',
                        'Poin Tersisa',
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (state.status.isLoaded) {
                    showPointInfo(state.pointConfigruation!);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 68.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    color: AppColor.primary[500],
                    border: Border.all(
                      color: AppColor.primary[300]!,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...List.generate(
                              listLevel.length,
                              (index) {
                                return Expanded(
                                  child: SizedBox(
                                    child: Center(
                                      child: Image.asset(
                                        listLevel[index].icon,
                                        height: 28.0,
                                        width: 28.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 16.0,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              state.status.isLoading
                                  ? const AppShimmer(
                                      55.0,
                                      double.infinity,
                                      8.0,
                                    )
                                  : LinearPercentIndicator(
                                      animation: true,
                                      lineHeight: 8.0,
                                      animationDuration: 1000,
                                      percent: (state.pointBalance?.data
                                                          ?.totalPoin ??
                                                      0) /
                                                  800 >
                                              1
                                          ? 1
                                          : (state.pointBalance?.data
                                                      ?.totalPoin ??
                                                  0) /
                                              800,
                                      barRadius: const Radius.circular(8.0),
                                      progressColor: AppColor.accent[900],
                                      backgroundColor: AppColor.neutral[100],
                                    ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(
                                    listLevel.length,
                                    (index) {
                                      return Image.asset(
                                        AppAssets.circleActiveIcon,
                                        width: 16.0,
                                        height: 16.0,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: state.status.isLoading
                            ? const SizedBox(height: 18.0)
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(
                                    state.pointConfigruation?.data?.length ?? 0,
                                    (index) {
                                      return SizedBox(
                                        width: 28.0,
                                        child: Text(
                                          state.pointConfigruation?.data?[index]
                                                  .minPoin
                                                  .toString() ??
                                              '-',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: appTextTheme(context)
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.white,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget header() {
      return Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
        ),
        // height: MediaQuery.sizeOf(context).height * 0.35,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00317E),
              Color(0xFF0059E4),
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18.0),
            bottomRight: Radius.circular(18.0),
          ),
          image: DecorationImage(
            image: AssetImage(AppAssets.pointBackgroundv2Image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            headerAppBar(),
            headerPointView(),
            headerPointInfo(),
          ],
        ),
      );
    }

    Widget tabBar() {
      return BlocBuilder<PointV2Cubit, PointV2State>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<PointV2Cubit>()
                          .onChangeBodyPointV2(BodyPointV2.mission);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: state.bodyPointV2 == BodyPointV2.mission
                            ? AppColor.primary[600]
                            : AppColor.neutral[200],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        'Misi',
                        textAlign: TextAlign.center,
                        style: appTextTheme(context).titleSmall?.copyWith(
                              color: state.bodyPointV2 == BodyPointV2.mission
                                  ? AppColor.white
                                  : AppColor.neutralBlueGrey[500],
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<PointV2Cubit>()
                          .onChangeBodyPointV2(BodyPointV2.exchange);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: state.bodyPointV2 == BodyPointV2.exchange
                            ? AppColor.primary[600]
                            : AppColor.neutral[200],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        'Tukar Point',
                        textAlign: TextAlign.center,
                        style: appTextTheme(context).titleSmall?.copyWith(
                              color: state.bodyPointV2 == BodyPointV2.exchange
                                  ? AppColor.white
                                  : AppColor.neutralBlueGrey[500],
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget bodyData() {
      return BlocBuilder<PointV2Cubit, PointV2State>(
        builder: (context, state) {
          if (state.bodyPointV2 == BodyPointV2.mission) {
            return const PointMission();
          } else {
            return const PointExchange();
          }
        },
      );
    }

    List<Widget> body() {
      return [
        tabBar(),
        const SizedBox(height: 12.0),
        bodyData(),
      ];
    }

    return Form(
      key: formKey,
      child: AppRefresher(
        offset: 55.0,
        onRefresh: () {
          context.read<PointMissionV2Cubit>().init();
        },
        child: ListView(
          children: [
            header(),
            ...body(),
          ],
        ),
      ),
    );
  }
}
