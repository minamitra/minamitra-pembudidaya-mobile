import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/activity_activities_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/views/activity_cycle_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/views/activity_incident_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_activity/logic/detail_activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/monitoring_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailActivityView extends StatefulWidget {
  const DetailActivityView(this.pondData, {super.key});

  final PondResponseData pondData;

  @override
  State<DetailActivityView> createState() => _DetailActivityViewState();
}

class _DetailActivityViewState extends State<DetailActivityView> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = 0;
  }

  List<String> listImage = [
    AppAssets.dummyDetailActivityBannerImage,
    AppAssets.dummyDetailActivityBannerImage,
    AppAssets.dummyDetailActivityBannerImage,
  ];
  @override
  Widget build(BuildContext context) {
    Widget bottomActionItem(
      String name,
      String icon, {
      Function()? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: 24.0,
              width: 24.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    }

    Widget bottomAction() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF155ED0).withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomActionItem(
                'Aktivitas',
                AppAssets.documentAddIcon,
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    ActivityActivitiesPage(
                      widget.pondData.id ?? "0",
                      context
                              .read<DetailActivityCubit>()
                              .state
                              .onGoingCycleFeedResponseData
                              ?.data
                              ?.first
                              .id ??
                          "0",
                      context
                          .read<DetailActivityCubit>()
                          .state
                          .onGoingCycleFeedResponseData
                          ?.data
                          ?.first
                          .tebarDate,
                    ),
                    ActivityActivitiesPage.routeSettings(),
                  ));
                },
              ),
              bottomActionItem(
                'Kejadian',
                AppAssets.notebookIcon,
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const ActivityIncidentPage(),
                    ActivityIncidentPage.routeSettings(),
                  ));
                },
              ),
              bottomActionItem(
                'Monitoring',
                AppAssets.pulseIcon,
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const MonitoringPage(),
                    MonitoringPage.route,
                  ));
                },
              ),
              bottomActionItem(
                'Siklus',
                AppAssets.cartIcon,
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const ActivityCyclePage(),
                    ActivityCyclePage.routeSettings(),
                  ));
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          Container(
            color: AppColor.primary[800],
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  itemBuilder: (context, index, realIndex) {
                    return AspectRatio(
                      aspectRatio: 375 / 262,
                      child: InkWell(
                        onTap: () {},
                        child: Image.network(
                          widget.pondData.imageUrl ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                AppAssets.dummyDetailActivityBannerImage);
                          },
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    reverse: true,
                    initialPage: 0,
                    aspectRatio: 375 / 262,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: 1,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      activeDotColor: AppColor.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  left: 18.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 18.0,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (modalContext) {
                          return AppBottomSheet(
                            "Pilih Aksi",
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                                vertical: 15.0,
                              ),
                              child: Column(
                                children: [
                                  AppPrimaryFullButton(
                                    "Edit Data",
                                    () {},
                                  ),
                                  const SizedBox(height: 15.0),
                                  AppPrimaryOutlineFullButton(
                                    "Hapus Data",
                                    () {
                                      Navigator.of(context).pop();
                                      showDeleteBottomSheet(
                                        context,
                                        title: "Hapus Kolam ?",
                                        descriptions:
                                            "Data yang sudah terhapus\ntidak dapat dipulihkan kembali!",
                                        onTapDelete: () {},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.3,
                            actions: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(modalContext).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 24.0,
                                  color: AppColor.neutral[300],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget headerInformationsItem(
      String value,
      String label,
    ) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary[600],
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
        ],
      );
    }

    Widget headerInformations() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            Text(
              widget.pondData.name.handlingEmptyString(),
              style: appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12.0),
            Text(
              widget.pondData.address.handlingEmptyString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                  ),
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget headerDataInformation() {
      return BlocBuilder<DetailActivityCubit, DetailActivityState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: AppColor.neutralBlueGrey[50],
            ),
            child: Row(
              children: [
                Expanded(
                    child: headerInformationsItem(
                        "${widget.pondData.areaWidth} m", "Luas Lahan")),
                SizedBox(
                  height: 38.0,
                  child: VerticalDivider(color: AppColor.neutral[200]),
                ),
                Expanded(
                    child: headerInformationsItem(
                  state.onGoingCycleFeedResponseData?.data?[0].tebarFishTotal ??
                      "-",
                  "Jumlah Ikan",
                )),
                SizedBox(
                  height: 38.0,
                  child: VerticalDivider(color: AppColor.neutral[200]),
                ),
                Expanded(
                    child: headerInformationsItem(
                        "${state.onGoingCycleFeedResponseData?.data?[0].fishfoodTotalSum} Kg",
                        "Total Pakan")),
              ],
            ),
          );
        },
      );
    }

    Widget detailItem(
      String title,
      String value,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(color: AppColor.neutral[500]),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[800],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    }

    Widget feedSection() {
      return BlocBuilder<DetailActivityCubit, DetailActivityState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 18.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Siklus Saat Ini",
                        style: appTextTheme(context)
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    widget.pondData.activeBool ?? false
                        ? AppGreenGradientButton(
                            "Panen",
                            () {},
                          )
                        : AppPrimaryGradientButton(
                            "Mulai SIklus",
                            () {},
                          ),
                  ],
                ),
                const SizedBox(height: 18.0),
                detailItem(
                  "Tanggal Tebar",
                  AppConvertDateTime().dmyName(
                      state.onGoingCycleFeedResponseData!.data![0].tebarDate!),
                ),
                AppDividerSmall(),
                detailItem(
                  "Ukuran Tebar",
                  "${state.onGoingCycleFeedResponseData!.data!.first.tebarBobot} gr/ekor",
                ),
                AppDividerSmall(),
                detailItem(
                  "Asal Benih",
                  state.onGoingCycleFeedResponseData!.data!.first
                          .fishseedName ??
                      "-",
                ),
                AppDividerSmall(),
                detailItem(
                  "Target Bobot Panen",
                  "${state.onGoingCycleFeedResponseData!.data!.first.targetPanenBobot} gr/ekor",
                ),
                AppDividerSmall(),
                detailItem(
                  "Estimasi Perkiraan Waktu Panen",
                  AppConvertDateTime().dmyName(state
                          .onGoingCycleFeedResponseData!
                          .data!
                          .first
                          .estimationPanenDate ??
                      DateTime.now()),
                ),
                AppDividerSmall(),
                detailItem(
                  "Estimasi Perkiraan Tonase Panen",
                  state.onGoingCycleFeedResponseData!.data!.first
                          .estimationPanenTonase ??
                      "-",
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          );
        },
      );
    }

    Widget targetSection() {
      return BlocBuilder<DetailActivityCubit, DetailActivityState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 36.0),
                Text(
                  "Pilihan Pakan",
                  style: appTextTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 18.0),
                AppDividerSmall(),
                detailItem(
                  "Starter",
                  state.onGoingCycleFeedResponseData?.data?.first
                          .fishfoodJsonObject?.starter
                          ?.map((element) => element.name)
                          .toList()
                          .join(", ") ??
                      "-",
                ),
                detailItem(
                  "Grower",
                  state.onGoingCycleFeedResponseData?.data?.first
                          .fishfoodJsonObject?.grower
                          ?.map((element) => element.name)
                          .toList()
                          .join(", ") ??
                      "-",
                ),
                AppDividerSmall(),
                detailItem(
                  "Finisher",
                  state.onGoingCycleFeedResponseData?.data?.first
                          .fishfoodJsonObject?.finisher
                          ?.map((element) => element.name)
                          .toList()
                          .join(", ") ??
                      "-",
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        ListView(
          children: [
            header(),
            headerInformations(),
            headerDataInformation(),
            feedSection(),
            AppDividerLarge(),
            targetSection(),
            const SizedBox(height: 72.0),
          ],
        ),
        bottomAction(),
      ],
    );
  }
}
