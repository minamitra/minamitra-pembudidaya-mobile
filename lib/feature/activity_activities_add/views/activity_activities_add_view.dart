import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/feed_activity_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/logic/activity_activities_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/logic/get_hour_time.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/add_fish_feed_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/view/add_new_feed_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesAddView extends StatefulWidget {
  const ActivityActivitiesAddView(this.tebarDate, {this.editData, super.key});

  final DateTime tebarDate;
  final FeedActivityResponseData? editData;

  @override
  State<ActivityActivitiesAddView> createState() =>
      _ActivityActivitiesAddViewState();
}

class _ActivityActivitiesAddViewState extends State<ActivityActivitiesAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController totalAmountFeedFromInitController =
      TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController fishAgeController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 45));
  DateTime lastDate = DateTime.now();

  List<String> listType = ["Pagi", "Siang", "Sore", "Malam"];

  @override
  void initState() {
    super.initState();
    if (widget.editData != null) {
      firstDate = widget.tebarDate;
      dateController.text =
          AppConvertDateTime().dmyName(widget.editData!.datetime!);
      context.read<ActivityActivitiesAddCubit>().changeTimeFeed(
            widget.editData!.datetime!.hour,
            widget.editData!.datetime!.minute,
          );
      hourController.text =
          AppConvertDateTime().jm24(widget.editData!.datetime!);
      typeController.text = widget.editData!.timeSheet ?? "";
      amountController.text = widget.editData!.actual ?? "0";
      brandController.text = widget.editData!.fishfoodName ?? "";
      context
          .read<ActivityActivitiesAddCubit>()
          .cahngeFishFoodID(int.parse(widget.editData!.fishfoodId ?? "0"));
      noteController.text = widget.editData!.note ?? "";
    } else {
      firstDate = widget.tebarDate;
      dateController.text = AppConvertDateTime().dmyName(dateNow);
    }

    // fishAgeController.text =
  }

  Widget dateTextField(BuildContext context) {
    return BlocBuilder<ActivityActivitiesAddCubit, ActivityActivitiesAddState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AppShimmer(
            55,
            double.infinity,
            8.0,
          );
        }

        return AppValidatorTextField(
          readOnly: true,
          controller: dateController,
          hintText: "Pilih Tanggal",
          labelText: "Tanggal",
          suffixConstraints: const BoxConstraints(
            maxHeight: 50,
            maxWidth: 50,
          ),
          suffixWidget: SizedBox(
            width: 66,
            child: Center(
              child: Image.asset(
                AppAssets.calendarIcon,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          isMandatory: true,
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: dateNow,
              firstDate: firstDate,
              lastDate: lastDate,
            ).then((date) {
              setState(() {
                if (date != null) {
                  dateController.text = AppConvertDateTime().dmyName(date);
                  brandController.clear();
                  context
                      .read<ActivityActivitiesAddCubit>()
                      .changeDateTime(date);
                }
              });
            });
          },
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Tanggal tidak boleh kosong";
            }
            return null;
          },
        );
      },
    );
  }

  Widget typeTextFormField() {
    return AppValidatorTextField(
      labelText: "Waktu Kegiatan",
      controller: typeController,
      isMandatory: true,
      withUpperLabel: true,
      readOnly: true,
      hintText: "Pilih waktu kegiatan",
      suffixWidget: const Padding(
        padding: EdgeInsets.only(right: 18.0),
        child: Icon(Icons.arrow_drop_down_rounded),
      ),
      suffixConstraints: const BoxConstraints(),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Waktu kegiatan tidak boleh kosong";
        }
        return null;
      },
      onTap: appBottomSheetShowModal(
        context,
        "Pilih waktu kegiatan",
        listType,
        (value) {
          typeController.text = value;
        },
      ),
    );
  }

  Widget typeDialogField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Text(
              "Jenis Kegiatan",
              style: appTextTheme(context).bodyMedium,
            ),
            Text(
              " *",
              style:
                  appTextTheme(context).bodyMedium?.copyWith(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0);
          },
          itemCount: listType.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.neutral[200]!,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: RadioListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  listType[index],
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[600],
                      ),
                ),
                value: listType[index],
                groupValue: typeController.text,
                onChanged: (value) {
                  setState(() {
                    typeController.text = value.toString();
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget amountTextField() {
    return AppValidatorTextField(
      controller: amountController,
      hintText: "Masukan jumlah pakan",
      labelText: "Jumlah Pakan Diberikan ",
      inputType: TextInputType.phone,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah tidak boleh kosong";
        }
        return null;
      },
      suffixConstraints: const BoxConstraints(),
      suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Text(
          "gram",
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget brandTextField() {
    return AppValidatorTextField(
      controller: brandController,
      hintText: "Masukan merk",
      labelText: "Merk",
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Merk tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget noteTextField() {
    return AppValidatorTextField(
      controller: noteController,
      hintText: "Masukan catatan",
      labelText: "Catatan",
      maxLines: 3,
      isMandatory: false,
      validator: (String? value) {
        if (value!.isEmpty) {
          // return "Catatan tidak boleh kosong";
          return null;
        }
        return null;
      },
    );
  }

  Widget suggestion() {
    return BlocBuilder<ActivityActivitiesAddCubit, ActivityActivitiesAddState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AppShimmer(
            55,
            double.infinity,
            8.0,
          );
        }
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColor.accent[50],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColor.accent[900]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: AppColor.accent[900],
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "Saran Pakan: ${state.feedRecomendationResponse?.data?.suggestFeed?.toStringAsFixed(5)} gram",
                      style: appTextTheme(context).titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      amountController.text = state
                              .feedRecomendationResponse?.data?.suggestFeed
                              ?.toStringAsFixed(5) ??
                          "";
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColor.accent[900],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Terapkan',
                        style: appTextTheme(context).titleSmall?.copyWith(
                              color: AppColor.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.error,
                  color: AppColor.neutral[600],
                  size: 16.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Pemberian pakan 2-3 kali per hari",
                  style: appTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.neutral[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
          ],
        );
      },
    );
  }

  Widget brandName() {
    return BlocBuilder<ActivityActivitiesAddCubit, ActivityActivitiesAddState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AppShimmer(
            55,
            double.infinity,
            8.0,
          );
        }

        return AppValidatorTextField(
          controller: brandController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Nama Pakan Diberikan",
          hintText: "Pilih Pakan",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Pakan tidak boleh kosong";
            }
            return null;
          },
          onTap: appBottomSheetShowModalWithCustomButton(
            context: context,
            title: "Pilih Pakan",
            data: state.feedDataByCycleResponse?.data
                    ?.map((element) => element.name ?? "-")
                    .toList() ??
                [],
            onSelected: (value) {
              brandController.text = value;
              state.feedDataByCycleResponse?.data?.forEach((element) {
                if (element.name == value) {
                  context
                      .read<ActivityActivitiesAddCubit>()
                      .cahngeFishFoodID(int.parse(element.id.toString()));
                }
              });
            },
            buttonWidget: const SizedBox(),
            // ! Note : Currently disable.
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.add,
            //       color: AppColor.primary[600],
            //     ),
            //     const SizedBox(width: 8.0),
            //     Text(
            //       "Tambah Pakan Baru",
            //       style: appTextTheme(context).titleSmall?.copyWith(
            //             color: AppColor.primary[600],
            //           ),
            //     ),
            //   ],
            // ),
            onTapButtonBottom: () {
              Navigator.of(context).pop();
              // Navigator.of(context).push(AppTransition.pushTransition(
              //   const AddNewFeedPage(),
              //   AddNewFeedPage.routeSettings,
              // ));
            },
          ),
        );
      },
    );
  }

  Widget totalAmountFeedFromInit() {
    return AppValidatorTextField(
      controller: totalAmountFeedFromInitController,
      hintText: "0",
      labelText: "Total Pakan Diberikan",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah tidak boleh kosong";
        }
        return null;
      },
      suffixConstraints: const BoxConstraints(),
      suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Text(
          "gram",
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  AppValidatorTextField hourTextField(BuildContext context) {
    return AppValidatorTextField(
      controller: hourController,
      hintText: "Pilih Jam",
      labelText: "Jam",
      suffixConstraints: const BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      suffixWidget: SizedBox(
        width: 66,
        child: Center(
          child: Image.asset(
            AppAssets.clockIcon,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
      ),
      isMandatory: true,
      readOnly: true,
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((time) {
          setState(() {
            if (time != null) {
              // final String timeOfFeed = "${time.hour}:${time.minute}:00";
              context
                  .read<ActivityActivitiesAddCubit>()
                  .changeTimeFeed(time.hour, time.minute);
              hourController.text = time.format(context);
            }
          });
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jam tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget fishAge() {
    return BlocBuilder<ActivityActivitiesAddCubit, ActivityActivitiesAddState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AppShimmer(
            55,
            double.infinity,
            8.0,
          );
        }

        if (state.status.isLoaded) {
          fishAgeController.text = state.fishAge.toString();
        }

        return AppValidatorTextField(
          controller: fishAgeController,
          hintText: "0",
          labelText: "Umur Ikan",
          inputType: TextInputType.number,
          isMandatory: true,
          readOnly: true,
          fillColor: AppColor.neutral[100],
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Umur ikan tidak boleh kosong";
            }
            return null;
          },
          suffixConstraints: const BoxConstraints(),
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "hari",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          dateTextField(context),
          const SizedBox(height: 16.0),
          // hourTextField(context),
          typeTextFormField(),
          const SizedBox(height: 16.0),
          fishAge(),
          const SizedBox(height: 16.0),
          suggestion(),
          amountTextField(),
          const SizedBox(height: 16.0),
          brandName(),
          // const SizedBox(height: 16.0),
          // totalAmountFeedFromInit(),
          const SizedBox(height: 16.0),
          noteTextField(),
          const SizedBox(height: 98.0),
        ],
      );
    }

    Widget button() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: AppColor.neutral[200]!,
              width: 1.0,
            ),
          ),
        ),
        child: AppPrimaryFullButton(
          "Simpan",
          () {
            if (!formKey.currentState!.validate()) {
              return;
            }
            final int getHourTime = typeController.text.getHourTime();
            final activityCubit = context.read<ActivityActivitiesAddCubit>();
            context.read<ActivityActivitiesAddCubit>().addFishFeed(
                  AddFishFeedBody(
                    fishpondId: int.parse(activityCubit.fishPondID ?? "0"),
                    fishpondcycleId:
                        int.parse(activityCubit.fishPondCycleID ?? "0"),
                    datetime: activityCubit.state.selectedDate
                        ?.copyWith(hour: getHourTime),
                    fishAge: activityCubit.state.fishAge,
                    recommendation: activityCubit
                        .state.feedRecomendationResponse?.data?.suggestFeed,
                    actual: double.parse(amountController.text),
                    total: double.parse(amountController.text),
                    fishfoodId: activityCubit.state.fishFoodID,
                    note: noteController.text,
                    dataID: widget.editData?.id,
                    timeSheet: typeController.text.toLowerCase(),
                  ),
                );
          },
        ),
      );
    }

    return Form(
      key: formKey,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          body(),
          button(),
        ],
      ),
    );
  }
}
