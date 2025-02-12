import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/logic/history_point_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_badges.dart';

class HistoryPointView extends StatefulWidget {
  const HistoryPointView({super.key});

  @override
  State<HistoryPointView> createState() => _HistoryPointViewState();
}

class _HistoryPointViewState extends State<HistoryPointView> {
  final TextEditingController searchController = TextEditingController();

  List<String> listFilter = [
    'Selesai',
    'Tarik Tunai',
    'Konversi Saldo',
    // 'Aktivitas',
  ];

  String generateIcon(String title) {
    if (title.contains('Konversi Saldo')) {
      return AppAssets.walletWhiteIcon;
    }
    if (title.contains('Tarik Tunai')) {
      return AppAssets.withdrawalIcon;
    }
    return AppAssets.activityIcon;
  }

  Color generateColor(String title) {
    if (title.contains('Konversi Saldo')) {
      return AppColor.primary[500]!;
    }
    if (title.contains('Tarik Tunai')) {
      return AppColor.green[500]!;
    }
    return AppColor.secondary[900]!;
  }

  StatusBadge generateStatus(String status) {
    switch (status) {
      case 'Pengajuan':
        return StatusBadge.orange;
      case 'Diproses':
        return StatusBadge.orange;
      case 'Selesai':
        return StatusBadge.green;
      case 'Ditolak':
        return StatusBadge.red;
      default:
        return StatusBadge.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppValidatorTextField(
              controller: searchController,
              withUpperLabel: false,
              hintText: state.selectedDate == null
                  ? 'Cari berdasar tanggal ...'
                  : AppConvertDateTime().dmyName(state.selectedDate!),
              suffixWidget: state.selectedDate == null
                  ? const Icon(
                      Icons.date_range_outlined,
                      color: AppColor.primary,
                    )
                  : InkWell(
                      onTap: () {
                        context.read<HistoryPointCubit>().onFilterByDate(null);
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: AppColor.primary,
                      ),
                    ),
              readOnly: true,
              onTap: () {
                DatePicker.showDatePicker(
                  currentTime: state.selectedDate,
                  minTime: DateTime.now().subtract(const Duration(days: 720)),
                  maxTime: DateTime.now(),
                  context,
                  showTitleActions: true,
                  onChanged: (date) {},
                  onConfirm: (date) {
                    context.read<HistoryPointCubit>().onFilterByDate(date);
                  },
                  locale: LocaleType.id,
                );
              },
              onChanged: (value) {},
            ),
          );
        },
      );
    }

    Widget filterData() {
      return BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 62.0,
              minWidth: double.infinity,
            ),
            padding: const EdgeInsets.only(bottom: 18.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Row(
                children: List.generate(
                  listFilter.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 18.0 : 0,
                        right: 12.0,
                      ),
                      child: FilterChip(
                        label: Text(
                          listFilter[index],
                          textAlign: TextAlign.start,
                          style: state.selectedFilter == listFilter[index]
                              ? appTextTheme(context)
                                  .titleSmall
                                  ?.copyWith(color: AppColor.secondary[900])
                              : appTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(color: AppColor.neutral[500]),
                        ),
                        selected: state.selectedFilter == listFilter[index],
                        onSelected: (value) {
                          if (state.status.isLoading ||
                              state.selectedFilter == listFilter[index]) {
                            return;
                          }
                          context
                              .read<HistoryPointCubit>()
                              .onChangeFilter(listFilter[index]);
                        },
                        side: BorderSide(
                          color: state.selectedFilter == listFilter[index]
                              ? AppColor.secondary[900]!
                              : AppColor.neutralBlueGrey[200]!,
                        ),
                        selectedColor: AppColor.primary[100],
                        backgroundColor: AppColor.neutral[100],
                        showCheckmark: false,
                        checkmarkColor: AppColor.primary[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    Widget listHistoryItem({
      required String title,
      required String dateTime,
      required int point,
      required String? icon,
      required Color? iconColor,
      String? balance,
      String? status,
    }) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor ?? AppColor.primary[500]!,
              ),
              child: Image.asset(
                icon ?? AppAssets.activityIcon,
                width: 24.0,
                height: 24.0,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTextTheme(context)
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (status != null) const SizedBox(width: 8.0),
                      if (status != null)
                        AppBadges(
                          status: generateStatus(status),
                          text: status,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    dateTime,
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.neutralBlueGrey[400]),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: balance != null
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: balance != null
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.start,
              children: [
                Text(
                  " ${point <= 0 ? "" : "+"} $point poin",
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(color: AppColor.accent[900]),
                ),
                if (balance != null) const SizedBox(height: 10.0),
                if (balance != null)
                  Text(
                    balance,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(color: AppColor.secondary[900]),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    Widget listHistory() {
      return BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const AppShimmer(
                  100,
                  double.infinity,
                  8.0,
                  margin: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 8.0,
                  ),
                );
              },
            );
          }

          return BlocBuilder<HistoryPointCubit, HistoryPointState>(
            builder: (context, state) {
              if (state.selectedFilter == 'Selesai') {
                if (state.pointHistoryResponse?.data?.isEmpty ?? true) {
                  return const AppEmptyData(
                    'Oops, Belum Ada Riwayat',
                    descriptions:
                        'Tunggu apa lagi? Selesaikan aktivitas dan kumpulkan poin untuk ditukarkan ',
                    isCenter: true,
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.pointHistoryResponse?.data?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: AppDividerSmall(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   AppTransition.pushTransition(
                        //     const HistoryPointDetailPage(),
                        //     HistoryPointDetailPage.route,
                        //   ),
                        // );
                      },
                      child: listHistoryItem(
                        title: state.pointHistoryResponse?.data?[index].desc
                                .handlingEmptyString() ??
                            '-',
                        dateTime: AppConvertDateTime().dmyNamehhmm(
                          state.pointHistoryResponse?.data?[index].datetime ??
                              DateTime.now(),
                        ),
                        point: state.pointHistoryResponse?.data?[index].type ==
                                'in'
                            ? (state.pointHistoryResponse?.data?[index].poin ??
                                0)
                            : ((state.pointHistoryResponse?.data?[index].poin ??
                                    0) *
                                -1),
                        balance: state
                                    .pointHistoryResponse?.data?[index].type ==
                                'out'
                            ? '+ ${appConvertCurrency((state.pointHistoryResponse?.data?[index].poin ?? 0) * 100)}'
                            : null,
                        icon: generateIcon(
                          state.pointHistoryResponse?.data?[index].desc
                                  .handlingEmptyString() ??
                              '-',
                        ),
                        iconColor: generateColor(
                          state.pointHistoryResponse?.data?[index].desc
                                  .handlingEmptyString() ??
                              '-',
                        ),
                      ),
                    );
                  },
                );
              }

              if (state.selectedFilter == 'Tarik Tunai') {
                if (state.withdrawalData?.data?.isEmpty ?? true) {
                  return const AppEmptyData(
                    'Oops, Belum Ada Riwayat',
                    descriptions:
                        'Tunggu apa lagi? Selesaikan aktivitas dan kumpulkan poin untuk ditukarkan ',
                    isCenter: true,
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.withdrawalData?.data?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: AppDividerSmall(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: listHistoryItem(
                        title: state.withdrawalData?.data?[index].type
                                .handlingEmptyString() ??
                            '-',
                        dateTime: AppConvertDateTime().dmyNamehhmm(
                          state.withdrawalData?.data?[index].createDatetime ??
                              DateTime.now(),
                        ),
                        point:
                            ((state.withdrawalData?.data?[index].nominalPoin ??
                                    0) *
                                -1),
                        balance:
                            '+ ${appConvertCurrency((state.withdrawalData?.data?[index].nominalRp ?? 0).toDouble())}',
                        icon: AppAssets.withdrawalIcon,
                        iconColor: AppColor.green[500],
                        status: state.withdrawalData?.data?[index].status
                            .handlingEmptyString(),
                      ),
                    );
                  },
                );
              }

              if (state.selectedFilter == 'Konversi Saldo') {
                if (state.convertBalanceData?.data?.isEmpty ?? true) {
                  return const AppEmptyData(
                    'Oops, Belum Ada Riwayat',
                    descriptions:
                        'Tunggu apa lagi? Selesaikan aktivitas dan kumpulkan poin untuk ditukarkan ',
                    isCenter: true,
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.convertBalanceData?.data?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: AppDividerSmall(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: listHistoryItem(
                        title: state.convertBalanceData?.data?[index].type
                                .handlingEmptyString() ??
                            '-',
                        dateTime: AppConvertDateTime().dmyNamehhmm(
                          state.convertBalanceData?.data?[index]
                                  .createDatetime ??
                              DateTime.now(),
                        ),
                        point: ((state.convertBalanceData?.data?[index]
                                    .nominalPoin ??
                                0) *
                            -1),
                        balance:
                            '+ ${appConvertCurrency((state.convertBalanceData?.data?[index].nominalRp ?? 0).toDouble())}',
                        icon: AppAssets.walletWhiteIcon,
                        iconColor: AppColor.primary[500],
                        status: state.convertBalanceData?.data?[index].status,
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          );
        },
      );
    }

    return Column(
      children: [
        searchField(),
        filterData(),
        Expanded(child: listHistory()),
      ],
    );
  }
}
