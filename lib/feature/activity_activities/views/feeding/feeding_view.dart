import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/activity_activities_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/feed/activity_feed_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_detail/views/activity_activities_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class FeedingView extends StatefulWidget {
  const FeedingView(this.tebarDate, {super.key});

  final DateTime tebarDate;

  @override
  State<FeedingView> createState() => _FeedingViewState();
}

class _FeedingViewState extends State<FeedingView> {
  @override
  Widget build(BuildContext context) {
    Widget itemCard(FeedActivityResponseData data) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            ActivityActivitiesDetailPage(data, widget.tebarDate),
            ActivityActivitiesDetailPage.routeSettings(),
          ));
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
                        data.fishfoodName.handlingEmptyString(),
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        AppConvertDateTime()
                            .ddmmyyyyhhmm(data.datetime ?? DateTime.now()),
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
                        title: "Hapus Data ?",
                        descriptions:
                            "Data yang sudah terhapus\ntidak dapat dipulihkan kembali!",
                        onTapDelete: () {
                          Navigator.of(context).pop();
                          context
                              .read<ActivityFeedCubit>()
                              .onDeleteFeedActivity(data.id ?? "");
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColor.neutral[400],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Image.asset(AppAssets.weigherIconFill, height: 20.0),
                  const SizedBox(width: 12.0),
                  Text("${data.actual} gram",
                      style: appTextTheme(context).titleSmall),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<ActivityActivitiesCubit, ActivityActivitiesState>(
      builder: (context, state) {
        if (state.feedActivityResponse?.data?.isEmpty ?? true) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 84, 16, 0),
              child: AppEmptyData(
                  "Belum ada data, tekan tombol + untuk menambahkan aktivitas baru"),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.feedActivityResponse?.data?.length ?? 0,
          separatorBuilder: (context, index) => Container(
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 18.0,
              //   vertical: 16.0,
              // ),
              // color: AppColor.neutralBlueGrey[50],
              // child: Text(
              //   "Hari ini",
              //   style: appTextTheme(context).titleSmall?.copyWith(
              //         color: AppColor.neutral[400],
              //       ),
              // ),
              ),
          itemBuilder: (context, index) {
            return itemCard(state.feedActivityResponse!.data![index]);
          },
        );
      },
    );
  }
}
