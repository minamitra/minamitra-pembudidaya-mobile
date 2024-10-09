import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/add_pond_cycle_payload.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_finisher_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_grower_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/feed_starter_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_first_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_second_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_third_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/add_pond_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/pakan_starter_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/views/dashboard_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondThirdStepView extends StatefulWidget {
  const AddPondThirdStepView(
    this.rootPageController,
    this.behaviourPage, {
    this.pondID,
    super.key,
  });

  final PageController rootPageController;
  final BehaviourPage behaviourPage;
  final String? pondID;

  @override
  State<AddPondThirdStepView> createState() => _AddPondThirdStepViewState();
}

class _AddPondThirdStepViewState extends State<AddPondThirdStepView> {
  final GlobalKey<FormState> formThirdStepKey = GlobalKey<FormState>();

  // Optional when user picked other as seed origin
  final TextEditingController seedOriginNameController =
      TextEditingController();
  final TextEditingController seedOriginAgeController = TextEditingController();
  final TextEditingController seedOriginWeightController =
      TextEditingController();
  final TextEditingController seedOriginPriceController =
      TextEditingController();
  final TextEditingController seedOriginVarietyController =
      TextEditingController();
  final TextEditingController seedOriginHatcheryController =
      TextEditingController();
  final TextEditingController seedOriginNotesController =
      TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  List<String> selectedPakanStarter1 = [];
  List<String> selectedPakanStarter2 = [];
  List<String> selectedPakanStarter3 = [];
  List<String> selectedPakanGrower = [];
  List<String> selectedPakanFinisher = [];

  Function() radioShowModal(
    BuildContext context,
    String title,
    List<String> data,
    Function(String value) onSelected,
  ) {
    return () {
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                title,
                height: MediaQuery.of(context).size.height * 0.5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(data[index]);
                              },
                              child: Text(
                                data[index],
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.black,
                                        ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then((value) {
        if (value != null) {
          if (value is String) {
            onSelected(value);
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final AddPondThirdStepCubit addPondThirdStepCubit =
        context.read<AddPondThirdStepCubit>();

    List<Widget> pondInformation() {
      return [
        const SizedBox(height: 18.0),
        Text(
          "Informasi Siklus",
          style: appTextTheme(context).titleMedium,
        ),
        const SizedBox(height: 8.0),
        Text(
          "Tambahkan informasi lokasi untuk mendukung pengelolaan kolam Anda.",
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
        const SizedBox(height: 12.0),
        Text(
          "*Wajib diisi",
          style: appTextTheme(context).labelLarge?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 18.0),
        Divider(
          color: AppColor.neutral[100],
          thickness: 1.0,
          height: 0.0,
        ),
      ];
    }

    AppValidatorTextField dateTextField() {
      return AppValidatorTextField(
        readOnly: true,
        controller: addPondThirdStepCubit.dateController,
        hintText: "Pilih Tanggal",
        labelText: "Tanggal Tebar",
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
                addPondThirdStepCubit.dateController.text =
                    AppConvertDateTime().ymdDash(date);
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
    }

    List<Widget> seedOrignOtherChildren() {
      return [
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginNameController,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Nama Benih",
          hintText: "Masukan nama benih",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Nama benih tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginAgeController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Umur Benih",
          hintText: "0",
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
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Umur benih tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginWeightController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Bobot Benih",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "gram/ekor",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Bobot benih tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginPriceController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Harga Benih",
          hintText: "0",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              "Rp ",
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Harga benih tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginVarietyController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Varietas",
          hintText: "Pilih Benih",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Benih tidak boleh kosong";
            }
            return null;
          },
          onTap: radioShowModal(
            context,
            "Pilih Varietas",
            ["Beli", "Budidaya Sendiri", "Lainnya"],
            (value) {},
          ),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginHatcheryController,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Hatchery",
          hintText: "Masukan nama hatchery",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Hatchery tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: seedOriginNotesController,
          isMandatory: false,
          withUpperLabel: true,
          labelText: "Keterangan",
          hintText: "Masukan keterangan",
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null;
            }

            return null;
          },
        ),
      ];
    }

    Widget customSeedName() {
      return AppValidatorTextField(
        controller: seedOriginNameController,
        isMandatory: true,
        withUpperLabel: true,
        labelText: "Nama Benih",
        hintText: "Masukan nama benih",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Nama benih tidak boleh kosong";
          }

          return null;
        },
      );
    }

    Widget customSeedPrice() {
      return AppValidatorTextField(
        controller: seedOriginPriceController,
        inputType: TextInputType.phone,
        isMandatory: true,
        withUpperLabel: true,
        labelText: "Harga Benih",
        hintText: "0",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "Rp ",
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Harga benih tidak boleh kosong";
          }

          return null;
        },
      );
    }

    List<Widget> form() {
      return [
        dateTextField(),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: addPondThirdStepCubit.fishCountController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Jumlah Tebar",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "ekor",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Jumlah ikan tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: addPondThirdStepCubit.spreadController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Bobot Tebar",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "gram/ekor",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Jumlah ikan tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: addPondThirdStepCubit.targetController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Target Bobot Panen",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "gram/ekor",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Target bobot panen tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.seedOriginController,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Asal Benih",
              hintText: "Pilih asal benih",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Asal benih tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModal(
                context,
                "Asal Benih",
                state.seedResponse?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                (value) {
                  addPondThirdStepCubit.seedOriginController.text = value;
                  addPondThirdStepCubit.seedID = state.seedResponse?.data
                          ?.firstWhere((element) => element.name == value)
                          .id ??
                      "";
                  setState(() {});
                },
              ),
            );
          },
        ),
        // ...seedOrignOtherChildren(),
        addPondThirdStepCubit.seedID == "-1"
            ? Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: customSeedName(),
              )
            : const SizedBox(),
        addPondThirdStepCubit.seedID == "-1"
            ? Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: customSeedPrice(),
              )
            : const SizedBox(),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: addPondThirdStepCubit.survivalRateController,
          inputType: TextInputType.phone,
          isMandatory: false,
          withUpperLabel: true,
          labelText: "Target Survival Rate",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "%",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.pakanStarter1Controller,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Pakan Starter 1",
              hintText: "Pilih Pakan",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Pakan starter 1 tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModalChecklist(
                context: context,
                title: "Pakan Starter 1",
                data: addPondThirdStepCubit.state.feedStarter1Data?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                selectedData: selectedPakanStarter1,
                onSelected: (value) {
                  addPondThirdStepCubit.pakanStarter1Controller.text =
                      value.join(", ");
                },
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.pakanStarter2Controller,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Pakan Starter 2",
              hintText: "Pilih Pakan",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Pakan starter 2 tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModalChecklist(
                context: context,
                title: "Pakan Starter 2",
                data: addPondThirdStepCubit.state.feedStarter2Data?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                selectedData: selectedPakanStarter2,
                onSelected: (value) {
                  addPondThirdStepCubit.pakanStarter2Controller.text =
                      value.join(", ");
                },
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.pakanStarter3Controller,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Pakan Starter 3",
              hintText: "Pilih Pakan",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Pakan starter 3 tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModalChecklist(
                context: context,
                title: "Pakan Starter 3",
                data: addPondThirdStepCubit.state.feedStarter3Data?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                selectedData: selectedPakanStarter3,
                onSelected: (value) {
                  addPondThirdStepCubit.pakanStarter3Controller.text =
                      value.join(", ");
                },
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.pakanGrowerController,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Pakan Grower",
              hintText: "Pilih Pakan",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Pakan grower tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModalChecklist(
                context: context,
                title: "Pakan Grower",
                data: addPondThirdStepCubit.state.feedGrowerData?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                selectedData: selectedPakanGrower,
                onSelected: (value) {
                  addPondThirdStepCubit.pakanGrowerController.text =
                      value.join(", ");
                },
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AddPondThirdStepCubit, AddPondThirdStepState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const AppShimmer(
                45.0,
                double.infinity,
                8,
              );
            }

            return AppValidatorTextField(
              controller: addPondThirdStepCubit.pakanFinisherController,
              inputType: TextInputType.phone,
              isMandatory: true,
              withUpperLabel: true,
              readOnly: true,
              labelText: "Pakan Finisher",
              hintText: "Pilih Pakan",
              suffixWidget: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
              suffixConstraints: const BoxConstraints(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Pakan finisher 1 tidak boleh kosong";
                }
                return null;
              },
              onTap: appBottomSheetShowModalChecklist(
                context: context,
                title: "Pakan Finisher",
                data: addPondThirdStepCubit.state.feedFinisherData?.data
                        ?.map((element) => element.name ?? "")
                        .toList() ??
                    [],
                selectedData: selectedPakanFinisher,
                onSelected: (value) {
                  addPondThirdStepCubit.pakanFinisherController.text =
                      value.join(", ");
                },
              ),
            );
          },
        ),
      ];
    }

    Widget bottomButton() {
      return BlocBuilder<AddPondCubit, AddPondState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                if (widget.behaviourPage != BehaviourPage.addNewCycle)
                  Expanded(
                    child: AppAnimatedSize(
                      isShow: state.index > 0,
                      child: AppPrimaryOutlineFullButton(
                        "Kembali",
                        () {
                          widget.rootPageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          context.read<AddPondCubit>().changeStep(2);
                        },
                      ),
                    ),
                  ),
                if (widget.behaviourPage != BehaviourPage.addNewCycle)
                  const SizedBox(width: 16.0),
                Expanded(
                  child: AppAnimatedSize(
                    isShow: true,
                    child: AppPrimaryFullButton(
                      "Simpan",
                      () {
                        final addPondFirstStepCubit =
                            context.read<AddPondFirstStepCubit>();
                        final addPondSecondStepCubit =
                            context.read<AddPondSecondStepCubit>();

                        if (formThirdStepKey.currentState?.validate() ??
                            false) {
                          // widget.rootPageController.nextPage(
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeInOut,
                          // );
                          final int? survivalRaate = int.tryParse(
                              addPondThirdStepCubit
                                  .survivalRateController.text);
                          if (survivalRaate == null ||
                              survivalRaate < 0 ||
                              survivalRaate > 100) {
                            AppTopSnackBar(context).showDanger(
                                "Survival Rate harus\nangka antara 0 - 100");
                            return;
                          }

                          // Mapping data

                          List<FeedStarterResponseData> selectedStarter1Data =
                              addPondThirdStepCubit.state.feedStarter1Data?.data
                                      ?.where((element) => selectedPakanStarter1
                                          .contains(element.name))
                                      .toList() ??
                                  [];
                          List<FeedStarterResponseData> selectedStarter2Data =
                              addPondThirdStepCubit.state.feedStarter2Data?.data
                                      ?.where((element) => selectedPakanStarter2
                                          .contains(element.name))
                                      .toList() ??
                                  [];
                          List<FeedStarterResponseData> selectedStarter3Data =
                              addPondThirdStepCubit.state.feedStarter3Data?.data
                                      ?.where((element) => selectedPakanStarter3
                                          .contains(element.name))
                                      .toList() ??
                                  [];
                          List<FeedGrowerResponseData> selecterGrowerData =
                              addPondThirdStepCubit.state.feedGrowerData?.data
                                      ?.where((element) => selectedPakanGrower
                                          .contains(element.name))
                                      .toList() ??
                                  [];
                          List<FeedFinisherResponseData> selecterFinisherData =
                              addPondThirdStepCubit.state.feedFinisherData?.data
                                      ?.where((element) => selectedPakanFinisher
                                          .contains(element.name))
                                      .toList() ??
                                  [];

                          List<Finisher> selecterStarter1Finisher =
                              selectedStarter1Data
                                  .map((element) => element.toFinisherObject())
                                  .toList();
                          List<Finisher> selecterStarter2Finisher =
                              selectedStarter2Data
                                  .map((element) => element.toFinisherObject())
                                  .toList();
                          List<Finisher> selecterStarter3Finisher =
                              selectedStarter3Data
                                  .map((element) => element.toFinisherObject())
                                  .toList();
                          List<Finisher> selecterGrowerFinisher =
                              selecterGrowerData
                                  .map((element) => element.toFinisherObject())
                                  .toList();
                          List<Finisher> selecterFinisherFinisher =
                              selecterFinisherData
                                  .map((element) => element.toFinisherObject())
                                  .toList();

                          if (widget.behaviourPage ==
                              BehaviourPage.addNewCycle) {
                            context.read<AddPondCubit>().addNewCycle(
                                  pondID: widget.pondID ?? "",
                                  pondCyclePayload: AddPondCyclePayload(
                                    tebarDate: addPondThirdStepCubit
                                        .dateController.text,
                                    tebarFishTotal: int.parse(
                                        addPondThirdStepCubit
                                            .fishCountController.text),
                                    tebarBobot: int.parse(addPondThirdStepCubit
                                        .spreadController.text),
                                    targetPanenBobot: int.parse(
                                        addPondThirdStepCubit
                                            .targetController.text),
                                    srTarget: int.parse(addPondThirdStepCubit
                                        .survivalRateController.text),
                                    fishfoodJsonObject: FishfoodJsonObject(
                                      starter1: selecterStarter1Finisher,
                                      starter2: selecterStarter2Finisher,
                                      starter3: selecterStarter3Finisher,
                                      grower: selecterGrowerFinisher,
                                      finisher: selecterFinisherFinisher,
                                    ),
                                    fishseedId:
                                        addPondThirdStepCubit.seedID == "-1"
                                            ? null
                                            : int.parse(
                                                addPondThirdStepCubit.seedID),
                                    estimationFishfoodEpp: 75,
                                  ),
                                  name: seedOriginNameController.text,
                                  price: int.parse(
                                      seedOriginPriceController.text.isEmpty
                                          ? "0"
                                          : seedOriginPriceController.text),
                                );
                          } else {
                            context.read<AddPondCubit>().addPond(
                                  pondPayload: AddPondPayload(
                                    name: addPondFirstStepCubit
                                        .pondNameController.text,
                                    areaLength: double.parse(
                                        addPondFirstStepCubit
                                            .pondlengthController.text),
                                    areaWidth: double.parse(
                                        addPondFirstStepCubit
                                            .pondWidthController.text),
                                    areaDepth: double.parse(
                                        addPondFirstStepCubit
                                            .pondDeepController.text),
                                    address: "",
                                    addressLatitude:
                                        addPondSecondStepCubit.state.latitude,
                                    addressLongitude:
                                        addPondSecondStepCubit.state.longitude,
                                    addressProvinceId: addPondSecondStepCubit
                                        .state.selectedProvince?.id,
                                    addressProvinceName: addPondSecondStepCubit
                                        .state.selectedProvince?.name,
                                    addressCityId: addPondSecondStepCubit
                                        .state.selectedDistrict?.id,
                                    addressCityName: addPondSecondStepCubit
                                        .state.selectedDistrict?.name,
                                    addressSubdistrictId: addPondSecondStepCubit
                                        .state.selectedSubDistrict?.id,
                                    addressSubdistrictName:
                                        addPondSecondStepCubit
                                            .state.selectedSubDistrict?.name,
                                    addressVillageId: addPondSecondStepCubit
                                        .state.selectedVillage?.id,
                                    addressVillageName: addPondSecondStepCubit
                                        .state.selectedVillage?.name,
                                    imageUrl:
                                        addPondSecondStepCubit.state.urlImage,
                                  ),
                                  pondCyclePayload: AddPondCyclePayload(
                                    tebarDate: addPondThirdStepCubit
                                        .dateController.text,
                                    tebarFishTotal: int.parse(
                                        addPondThirdStepCubit
                                            .fishCountController.text),
                                    tebarBobot: int.parse(addPondThirdStepCubit
                                        .spreadController.text),
                                    targetPanenBobot: int.parse(
                                        addPondThirdStepCubit
                                            .targetController.text),
                                    srTarget: int.parse(addPondThirdStepCubit
                                        .survivalRateController.text),
                                    fishfoodJsonObject: FishfoodJsonObject(
                                      starter1: selecterStarter1Finisher,
                                      starter2: selecterStarter2Finisher,
                                      starter3: selecterStarter3Finisher,
                                      grower: selecterGrowerFinisher,
                                      finisher: selecterFinisherFinisher,
                                    ),
                                    fishseedId:
                                        addPondThirdStepCubit.seedID == "-1"
                                            ? null
                                            : int.parse(
                                                addPondThirdStepCubit.seedID),
                                    estimationFishfoodEpp: 75,
                                  ),
                                  seedName: seedOriginNameController.text,
                                  seedPrice: int.parse(
                                      seedOriginPriceController.text.isEmpty
                                          ? "0"
                                          : seedOriginPriceController.text),
                                );
                          }

                          // Navigator.of(context).popUntil(ModalRoute.withName(
                          //     DashboardPage.routeSettings().name ?? ""));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Expanded(
          child: Form(
            key: formThirdStepKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (widget.behaviourPage != BehaviourPage.addNewCycle)
                  const SizedBox(height: 18.0),
                ...pondInformation(),
                ...form(),
                const SizedBox(height: 18.0),
              ],
            ),
          ),
        ),
        bottomButton(),
      ],
    );
  }
}
