import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/resume_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/color_generate.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_header_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/resume_detail/views/resume_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ResumeView extends StatefulWidget {
  const ResumeView({super.key});

  @override
  State<ResumeView> createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  @override
  Widget build(BuildContext context) {
    Widget headerItemData({
      required String title,
      required String value,
      required String imageAsset,
      required String allPondItemsLength,
      bool isShowingAllPonds = true,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(18.0),
        height: 100.0,
        width: MediaQuery.of(context).size.width * 0.725,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          color: AppColor.neutralBlueGrey[400],
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextTheme(context).titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: value.generateResumeColor(),
                        ),
                  ),
                ],
              ),
            ),
            Image.asset(
              imageAsset,
              height: 36.0,
              width: 36.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    }

    Widget wrappedHeaderItemData(
      ResumeHeaderDataWrapped data,
      bool isShowingAllPonds,
      String allPondItemsLength,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          headerItemData(
            title: data.listActivtyHeaderDataDummy[0].title,
            value: data.listActivtyHeaderDataDummy[0].value,
            imageAsset: data.listActivtyHeaderDataDummy[0].imageAsset,
            isShowingAllPonds: isShowingAllPonds,
            allPondItemsLength: allPondItemsLength,
          ),
          const SizedBox(height: 18.0),
          if (data.listActivtyHeaderDataDummy.length > 1)
            headerItemData(
              title: data.listActivtyHeaderDataDummy[1].title,
              value: data.listActivtyHeaderDataDummy[1].value,
              imageAsset: data.listActivtyHeaderDataDummy[1].imageAsset,
              isShowingAllPonds: isShowingAllPonds,
              allPondItemsLength: allPondItemsLength,
            ),
        ],
      );
    }

    Widget headerData() {
      return Container(
        color: AppColor.neutral[100],
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            BlocBuilder<ResumeCubit, ResumeState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const AppShimmer(
                    180,
                    double.infinity,
                    8.0,
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                  );
                }

                return SizedBox(
                  height: 225.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: resumeHeaderDataWrapped(
                      harvestResult: state.resumeSummary?.kriteriaHasilPanen
                              .handlingEmptyString() ??
                          '-',
                      eppValue: state.resumeSummary?.nilaiEppKeseluruhan
                              .handlingEmptyString() ??
                          '-',
                      srValue: state.resumeSummary?.nilaiSrKeseluruhan
                              .handlingEmptyString() ??
                          '-',
                      fcrValue: state.resumeSummary?.nilaiFcrKeseluruhan
                              .handlingEmptyString() ??
                          '-',
                    ).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: resumeHeaderDataWrapped(
                                      harvestResult: state
                                              .resumeSummary?.kriteriaHasilPanen
                                              .handlingEmptyString() ??
                                          '-',
                                      eppValue: state.resumeSummary
                                              ?.nilaiEppKeseluruhan
                                              .handlingEmptyString() ??
                                          '-',
                                      srValue: state
                                              .resumeSummary?.nilaiSrKeseluruhan
                                              .handlingEmptyString() ??
                                          '-',
                                      fcrValue: state.resumeSummary
                                              ?.nilaiFcrKeseluruhan
                                              .handlingEmptyString() ??
                                          '-',
                                    ).length -
                                    1 ==
                                index
                            ? const EdgeInsets.only(right: 18.0)
                            : EdgeInsets.zero,
                        child: wrappedHeaderItemData(
                          resumeHeaderDataWrapped(
                            harvestResult: state
                                    .resumeSummary?.kriteriaHasilPanen
                                    .handlingEmptyString() ??
                                '-',
                            eppValue: state.resumeSummary?.nilaiEppKeseluruhan
                                    .handlingEmptyString() ??
                                '-',
                            srValue: state.resumeSummary?.nilaiSrKeseluruhan
                                    .handlingEmptyString() ??
                                '-',
                            fcrValue: state.resumeSummary?.nilaiFcrKeseluruhan
                                    .handlingEmptyString() ??
                                '-',
                          )[index],
                          true,
                          '5',
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget itemValueFinanceItem({
      required String title,
      required String value,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: appTextTheme(context).titleSmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: crossAxisAlignment == CrossAxisAlignment.start
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                size: 12.0,
                color: value.generateResumeColor(),
              ),
              const SizedBox(width: 8.0),
              Text(
                value,
                style: appTextTheme(context)
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      );
    }

    Widget cardFinanceItem({
      bool isActive = true,
      required ResumePerCycleResponseData data,
    }) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAssets.cycleIcon,
                  height: 20.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    '${AppConvertDateTime().dmyName(data.periodeSiklusStart ?? DateTime.now())} - ${AppConvertDateTime().dmyName(data.periodeSiklusEnd ?? DateTime.now())}',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.primary[600],
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isActive ? AppColor.green[50] : AppColor.neutral[100],
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: isActive
                          ? AppColor.green[500]!
                          : AppColor.neutral[400]!,
                    ),
                  ),
                  child: Text(
                    isActive
                        ? data.status?.toLowerCase() == 'harvest'
                            ? 'Proses Panen'
                            : 'Berjalan'
                        : 'Selesai',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: isActive
                              ? AppColor.green[500]
                              : AppColor.neutral[400],
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            AppDividerSmall(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'Hasil Panen',
                    value: data.kriteriaHasilPanen ?? '-',
                  ),
                ),
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'SR Keseluruhan',
                    value: data.nilaiSrKeseluruhan ?? '-',
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'EPP Keseluruhan',
                    value: data.nilaiEppKeseluruhan ?? '-',
                  ),
                ),
                Expanded(
                  child: itemValueFinanceItem(
                    title: 'FCR Keseluruhan',
                    value: data.nilaiFcrKeseluruhan ?? '-',
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget listItem() {
      return BlocBuilder<ResumeCubit, ResumeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppColor.neutral[100],
                  thickness: 18.0,
                );
              },
              itemBuilder: (context, index) {
                return const AppShimmer(
                  150,
                  double.infinity,
                  0,
                );
              },
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      ResumeDetailPage(
                        context.read<ResumeCubit>().fishPondID,
                        state.resumePerCycle[index].fishpondcycleId ?? '0',
                        state.resumePerCycle[index],
                      ),
                      ResumeDetailPage.routeSettings(),
                    ),
                  );
                },
                child: cardFinanceItem(
                  isActive: state.resumePerCycle[index].status != 'done',
                  data: state.resumePerCycle[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColor.neutral[100],
                thickness: 18.0,
              );
            },
            itemCount: state.resumePerCycle.length,
          );
        },
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        headerData(),
        listItem(),
      ],
    );
  }
}
