import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle/repositories/feed_cycle_history_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_add_harvest_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleAddHarvestView extends StatefulWidget {
  const ActivityCycleAddHarvestView(this.id, {this.data, super.key});

  final String id;
  final FeedCycleHistoryResponseData? data;

  @override
  State<ActivityCycleAddHarvestView> createState() =>
      _ActivityCycleAddHarvestViewState();
}

class _ActivityCycleAddHarvestViewState
    extends State<ActivityCycleAddHarvestView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime? harvestDate;

  List<String> listBuyerType = ['Mitra3M', 'Lainnya'];

  @override
  void initState() {
    log("data: ${widget.data}");
    super.initState();
    if (widget.data != null) {
      dateController.text = AppConvertDateTime().dmyName(DateTime.parse(
          widget.data?.actualPanenDate ?? DateTime.now().toString()));
      sizeController.text =
          double.parse(widget.data!.actualPanenBobot ?? "0").toStringAsFixed(0);
      totalController.text = double.parse(widget.data!.actualPanenTonase ?? "0")
          .toStringAsFixed(0);
      noteController.text = widget.data!.panenNote!;
      harvestDate = DateTime.parse(widget.data!.actualPanenDate!);
    }
  }

  AppValidatorTextField dateTextField(BuildContext context) {
    return AppValidatorTextField(
      readOnly: true,
      controller: dateController,
      hintText: "Pilih Tanggal",
      labelText: "Tanggal Panen",
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
              harvestDate = date;
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

  Widget sizeTextField() {
    return AppValidatorTextField(
      controller: sizeController,
      labelText: "Ukuran Ikan",
      hintText: "0",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Ukuran ikan tidak boleh kosong";
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
              ),
        ),
      ),
    );
  }

  Widget totalTextField() {
    return AppValidatorTextField(
      controller: totalController,
      labelText: "Total Panen",
      hintText: "0",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Total panen tidak boleh kosong";
        }
        return null;
      },
      suffixConstraints: const BoxConstraints(),
      suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Text(
          "kg",
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
      ),
    );
  }

  AppValidatorTextField noteTextField() {
    return AppValidatorTextField(
      controller: noteController,
      labelText: "Catatan",
      hintText: "Masukan catatan",
      isMandatory: false,
      maxLines: 3,
      validator: (String? value) {
        if (value!.isEmpty) {
          return null;
        }
        return null;
      },
    );
  }

  Widget fileAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Text(
              "Unggah Lampiran",
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
        BlocBuilder<ActivityCyclePictureCubit, ActivityCyclePictureState>(
          builder: (context, state) {
            return AppPickImageNetworkCard(
              () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  builder: (bottomSheetContext) {
                    return AppImagePickerMenu(
                      "Upload Gambar",
                      (type) async {
                        if (state.images?.length == 3) {
                          AppTopSnackBar(context).showInfo("Maksimal 3 gambar");
                          Navigator.of(bottomSheetContext).pop();
                          return;
                        }
                        switch (type) {
                          case PhotoSource.camera:
                            final document = await pickDocumentImage(
                              bottomSheetContext,
                              ImageSource.camera,
                            );
                            if (document != null) {
                              await context
                                  .read<ActivityCyclePictureCubit>()
                                  .setImage(File(document.path));
                              Navigator.of(bottomSheetContext).pop();
                              // await document.readAsBytes().then((image) {
                              //   context
                              //       .read<ActivityCyclePictureCubit>()
                              //       .setImage(image);
                              //   Navigator.of(bottomSheetContext).pop();
                              // });
                            }
                            break;
                          case PhotoSource.gallery:
                            final document = await pickDocumentImage(
                              bottomSheetContext,
                              ImageSource.gallery,
                            );
                            if (document != null) {
                              await context
                                  .read<ActivityCyclePictureCubit>()
                                  .setImage(File(document.path));
                              Navigator.of(bottomSheetContext).pop();
                              // await document.readAsBytes().then((image) {
                              //   context
                              //       .read<ActivityCyclePictureCubit>()
                              //       .setImage(image);
                              //   Navigator.of(bottomSheetContext).pop();
                              // });
                            }
                            break;
                        }
                      },
                    );
                  },
                );
              },
              listImage: state.images ?? [],
              onTapImage: (value) {
                context.read<ActivityCyclePictureCubit>().removeImage(value);
              },
            );
          },
        ),
      ],
    );
  }

  Widget buyerDataItem(int index) {
    return BlocBuilder<ActivityCycleAddHarvestCubit,
        ActivityCycleAddHarvestState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            DottedLine(dashColor: AppColor.neutral[300]!),
            const SizedBox(height: 18.0),
            Wrap(
              children: [
                Text(
                  "Pembeli Ikan",
                  style: appTextTheme(context).bodyMedium,
                ),
                Text(
                  " *",
                  style: appTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.red),
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
              itemCount: listBuyerType.length,
              itemBuilder: (context, indexRadio) {
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
                      listBuyerType[indexRadio],
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: AppColor.neutral[600],
                          ),
                    ),
                    value: listBuyerType[indexRadio],
                    groupValue: state.buyerData[index].isBuyerFrom3m
                        ? 'Mitra3M'
                        : 'Lainnya',
                    onChanged: (value) {
                      if (value !=
                          (state.buyerData[index].isBuyerFrom3m
                              ? "Mitra3M"
                              : "Lainnya")) {
                        if (value == 'Mitra3M') {
                          AppTopSnackBar(context)
                              .showInfo("Fitur Sedang\nDalam Pengembangan");
                        } else {
                          context
                              .read<ActivityCycleAddHarvestCubit>()
                              .onChnageBuyerType(index, value == 'Mitra3M');
                          state.buyerData[index].buyerNameController.clear();
                          state.buyerData[index].sellRequestController.clear();
                          state.buyerData[index].sellUnitPriceController
                              .clear();
                          state.buyerData[index].sellTotalPriceController
                              .clear();
                        }
                      }
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 18.0),
            AppValidatorTextField(
              controller: state.buyerData[index].buyerNameController,
              hintText: "Masukkan pembeli",
              labelText: "Pembeli",
              isMandatory: true,
              onChanged: (value) {
                context
                    .read<ActivityCycleAddHarvestCubit>()
                    .onChangeBuyerName(index, value);
              },
            ),
            const SizedBox(height: 18.0),
            AppValidatorTextField(
              controller: state.buyerData[index].sellRequestController,
              labelText: "Jumlah Dijual",
              hintText: "0",
              inputType: TextInputType.number,
              isMandatory: true,
              suffixConstraints: const BoxConstraints(),
              suffixWidget: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  "kg",
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[500],
                      ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context
                      .read<ActivityCycleAddHarvestCubit>()
                      .onChangeSellRequest(index, int.parse(value));
                  if (state.buyerData[index].sellUnitPriceController.text
                      .isNotEmpty) {
                    state.buyerData[index].sellTotalPriceController.text =
                        (int.parse(value) *
                                int.parse(state.buyerData[index]
                                    .sellUnitPriceController.text))
                            .toString();
                  }
                }
              },
            ),
            const SizedBox(height: 18.0),
            AppValidatorTextField(
              controller: state.buyerData[index].sellUnitPriceController,
              labelText: "Harga Satuan",
              hintText: "0",
              inputType: TextInputType.number,
              isMandatory: true,
              suffixConstraints: const BoxConstraints(),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Rp "),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context
                      .read<ActivityCycleAddHarvestCubit>()
                      .onChangeSellUnitPrice(index, int.parse(value));
                  if (state
                      .buyerData[index].sellRequestController.text.isNotEmpty) {
                    state.buyerData[index].sellTotalPriceController.text =
                        (int.parse(state.buyerData[index].sellRequestController
                                    .text) *
                                int.parse(value))
                            .toString();
                  }
                }
              },
            ),
            const SizedBox(height: 18.0),
            AppValidatorTextField(
              controller: state.buyerData[index].sellTotalPriceController,
              labelText: "Total Harga",
              readOnly: true,
              hintText: "0",
              inputType: TextInputType.number,
              isMandatory: true,
              suffixConstraints: const BoxConstraints(),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Rp "),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget listBuyer() {
    return BlocBuilder<ActivityCycleAddHarvestCubit,
        ActivityCycleAddHarvestState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.buyerData.length + 1,
          itemBuilder: (context, index) {
            if (index == state.buyerData.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AppPrimaryOutlineFullButton(
                  "Tambah Pembeli Lainnya",
                  () {
                    context
                        .read<ActivityCycleAddHarvestCubit>()
                        .addAnotherBuyyer();
                  },
                ),
              );
            }

            return buyerDataItem(index);
          },
        );
      },
    );
  }

  Widget body() {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          dateTextField(context),
          const SizedBox(height: 16.0),
          sizeTextField(),
          const SizedBox(height: 16.0),
          totalTextField(),
          const SizedBox(height: 16.0),
          noteTextField(),
          const SizedBox(height: 16.0),
          fileAttachment(),
          const SizedBox(height: 24.0),
          listBuyer(),
          const SizedBox(height: 98.0),
        ],
      ),
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
          if (formKey.currentState!.validate()) {
            context.read<ActivityCycleAddHarvestCubit>().createHarvest(
                  id: widget.id,
                  harvestDate: harvestDate!,
                  harvestFishWeight: int.parse(sizeController.text),
                  totalHarvestActual: int.parse(totalController.text),
                  harvestNotes: noteController.text,
                  images:
                      context.read<ActivityCyclePictureCubit>().state.images ??
                          [],
                );
            return;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        body(),
        button(),
      ],
    );
  }
}
