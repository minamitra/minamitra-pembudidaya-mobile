import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/logic/cubit/cultivation_note_all_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/widget_chip.dart';

class CultivationNoteAllView extends StatefulWidget {
  const CultivationNoteAllView(this.data, {super.key});

  final List<CompanionNotesResponseData>? data;

  @override
  State<CultivationNoteAllView> createState() => _CultivationNoteAllViewState();
}

class _CultivationNoteAllViewState extends State<CultivationNoteAllView> {
  @override
  Widget build(BuildContext context) {
    Widget filterSection() {
      return Container(
        color: AppColor.neutral[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        DateTimeRange? rangePicker = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate: DateTime.now(),
                        );
                        if (rangePicker != null) {
                          if (context.mounted) {
                            context
                                .read<CultivationNoteAllCubit>()
                                .pickNotesByRangeDate(
                                  startDate: AppConvertDateTime()
                                      .ymdDash(rangePicker.start),
                                  endDate: AppConvertDateTime()
                                      .ymdDash(rangePicker.end),
                                  pickedRangeDate:
                                      "${AppConvertDateTime().dmy(rangePicker.start)} - ${AppConvertDateTime().dmy(rangePicker.end)}",
                                );
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: AppColor.neutral[200]!),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                context
                                            .watch<CultivationNoteAllCubit>()
                                            .pickedRangeDate ==
                                        null
                                    ? "Pilih rentang waktu"
                                    : context
                                            .watch<CultivationNoteAllCubit>()
                                            .pickedRangeDate ??
                                        "-",
                                style: appTextTheme(context).bodySmall,
                              ),
                            ),
                            Icon(
                              Icons.date_range_outlined,
                              color: AppColor.neutral[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  BlocBuilder<CultivationNoteAllCubit, CultivationNoteAllState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (bottomSheetContext) {
                              final TextEditingController companionController =
                                  TextEditingController(
                                      text: context
                                              .watch<CultivationNoteAllCubit>()
                                              .companionName ??
                                          "");
                              return AppBottomSheet(
                                "Filter Data",
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: [
                                            AppDropdownTextField(
                                              "Pendamping",
                                              state.companionName ?? [],
                                              companionController,
                                              hint: "Pilih Pendamping",
                                            )
                                          ],
                                        ),
                                      ),
                                      AppDividerSmall(),
                                      const SizedBox(height: 18.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppPrimaryOutlineFullButton(
                                              "Reset",
                                              () {
                                                context
                                                    .read<
                                                        CultivationNoteAllCubit>()
                                                    .resetCompanionName();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 18.0),
                                          Expanded(
                                            child: AppPrimaryFullButton(
                                              "Terapkan",
                                              () {
                                                context
                                                    .read<
                                                        CultivationNoteAllCubit>()
                                                    .filterByCompanionNmae(
                                                        companionController
                                                            .text);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 18.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 44.0,
                          width: 44.0,
                          decoration: BoxDecoration(
                            color: AppColor.primary[600],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: AppColor.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 33.0,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(width: 18.0),
                  AppWidgetSecondaryChip(
                    text: "Semua",
                    onTap: () {
                      context.read<CultivationNoteAllCubit>().reset();
                    },
                  ),
                  const SizedBox(width: 16.0),
                  AppWidgetSecondaryChip(
                    text: "Belum Dibaca",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget itemNote({
      required String companionImage,
      required String companionName,
      required String dateTime,
      required String companionNotes,
    }) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                child: Image.network(
                  companionImage,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object obj,
                    StackTrace? trace,
                  ) {
                    return Image.asset(
                      AppAssets.profileImageDummy,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companionName,
                      style: appTextTheme(context).titleSmall,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      dateTime,
                      style: appTextTheme(context)
                          .labelLarge
                          ?.copyWith(color: AppColor.neutral[400]),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: AppColor.secondary[50],
                  border: Border.all(color: AppColor.secondary[900]!),
                ),
                child: Text(
                  "Baru",
                  maxLines: 5,
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.secondary[900],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            companionNotes,
            maxLines: 5,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    Widget listNotes() {
      return BlocBuilder<CultivationNoteAllCubit, CultivationNoteAllState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const AppShimmer(
                  150,
                  double.infinity,
                  8.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                );
              },
            );
          }

          if (state.data?.isEmpty ?? true) {
            return const AppEmptyData(
              "Belum ada catatan\ndari pendamping",
              isCenter: true,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.data?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    CultivationNoteDetailPage(state.data![index]),
                    CultivationNoteDetailPage.routeSettings,
                  ));
                },
                child: itemNote(
                  companionImage:
                      state.data![index].userImageUrl.handlingEmptyString(),
                  companionName:
                      state.data![index].userName.handlingEmptyString(),
                  dateTime: AppConvertDateTime().edmy(
                      state.data![index].createDatetime ?? DateTime.now()),
                  companionNotes:
                      state.data![index].content.handlingEmptyString(),
                ),
              );
            },
          );
        },
      );
    }

    return Column(
      children: [
        filterSection(),
        Expanded(child: listNotes()),
      ],
    );
  }
}
