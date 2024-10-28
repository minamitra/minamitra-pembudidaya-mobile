import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/logics/activity_treatment_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/add_treatment_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/update_treatment_payload.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityTreatmentAddView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final DateTime dateDistribution;
  final bool isEdit;
  final TreatmentResponseData? data;

  const ActivityTreatmentAddView(
    this.fishpondId,
    this.fishpondcycleId,
    this.dateDistribution,
    this.isEdit,
    this.data, {
    super.key,
  });

  @override
  State<ActivityTreatmentAddView> createState() =>
      _ActivityTreatmentAddViewState();
}

class _ActivityTreatmentAddViewState extends State<ActivityTreatmentAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController fishAgeController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      if (widget.data != null) {
        dateController.text = widget.data!.datetime != null
            ? AppConvertDateTime().ymdDash(widget.data!.datetime!)
            : "";
        hourController.text = widget.data!.datetime != null
            ? AppConvertDateTime().jm24(widget.data!.datetime!)
            : "";
        fishAgeController.text =
            widget.data!.fishAge != null ? widget.data!.fishAge.toString() : "";
        treatmentController.text = widget.data!.name ?? "";
        priceController.text =
            widget.data!.cost != null ? widget.data!.cost.toString() : "";
        noteController.text = widget.data!.note ?? "";
        if (widget.data!.attachmentJsonArray != null &&
            widget.data!.attachmentJsonArray!.isNotEmpty) {
          convetAttachmentImage(widget.data!.attachmentJsonArray!);
        }
      }
    }
  }

  Future<void> convetAttachmentImage(List<String> images) async {
    Future.forEach(images, (element) async {
      http.Response imagePath = await http.get(Uri.parse(element));
      context.read<MultiImageCubit>().setImage(imagePath.bodyBytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget dateTextField() {
      return AppValidatorTextField(
        readOnly: true,
        controller: dateController,
        hintText: "Pilih Tanggal",
        labelText: "Tanggal",
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Image.asset(
            AppAssets.calendarIcon,
            height: 24,
            fit: BoxFit.cover,
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
                dateController.text = AppConvertDateTime().ymdDash(date);
                fishAgeController.text =
                    (date.difference(widget.dateDistribution).inHours / 24)
                        .round()
                        .toString();
                // fishAgeController.text = "test";
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

    AppValidatorTextField hourTextField() {
      return AppValidatorTextField(
        readOnly: true,
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
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((time) {
            setState(() {
              if (time != null) {
                hourController.text = time.format(context).replaceAll(".", ":");
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
      return AppValidatorTextField(
        controller: fishAgeController,
        hintText: "0",
        labelText: "Umur Ikan",
        inputType: TextInputType.number,
        isMandatory: true,
        readOnly: true,
        fillColor: AppColor.neutral[100],
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
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
    }

    Widget treatment() {
      return AppValidatorTextField(
        controller: treatmentController,
        hintText: "Masukan perlakuan",
        labelText: "Perlakuan",
        isMandatory: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "Perlakuan tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget price() {
      return AppValidatorTextField(
        controller: priceController,
        hintText: "0",
        labelText: "Biaya",
        inputType: TextInputType.number,
        isMandatory: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "Biaya tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "Rp ",
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        inputFormatters: [AppCurrencyFormatter.currency],
      );
    }

    Widget noteTextField() {
      return AppValidatorTextField(
        controller: noteController,
        hintText: "Masukan catatan",
        labelText: "Catatan",
        maxLines: 3,
        // validator: (String? value) {
        //   if (value!.isEmpty) {
        //     return "Catatan tidak boleh kosong";
        //   }
        //   return null;
        // },
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
            ],
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<MultiImageCubit, List<Uint8List>?>(
            builder: (context, state) {
              return AppPickImageCard(
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
                          switch (type) {
                            case PhotoSource.camera:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.camera,
                              );
                              if (document != null) {
                                await document.readAsBytes().then((image) {
                                  context
                                      .read<MultiImageCubit>()
                                      .setImage(image);
                                  Navigator.of(bottomSheetContext).pop();
                                });
                              }
                              break;
                            case PhotoSource.gallery:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.gallery,
                              );
                              if (document != null) {
                                await document.readAsBytes().then((image) {
                                  context
                                      .read<MultiImageCubit>()
                                      .setImage(image);
                                  Navigator.of(bottomSheetContext).pop();
                                });
                              }
                              break;
                          }
                        },
                      );
                    },
                  );
                },
                listImage: state ?? [],
                onTapImage: (value) {
                  context.read<MultiImageCubit>().removeImage(value);
                },
              );
            },
          ),
          const SizedBox(height: 8.0),
          Text(
            "Unggah file .jpg, .jpeg, .png, .img, .pdf, .doc, ukuran maks 2MB",
            style: appTextTheme(context).labelLarge?.copyWith(
                  color: AppColor.neutral[500],
                ),
          )
        ],
      );
    }

    Widget body() {
      return Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            dateTextField(),
            const SizedBox(height: 16.0),
            hourTextField(),
            const SizedBox(height: 16.0),
            fishAge(),
            const SizedBox(height: 16.0),
            treatment(),
            const SizedBox(height: 16.0),
            price(),
            const SizedBox(height: 16.0),
            noteTextField(),
            const SizedBox(height: 16.0),
            fileAttachment(),
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
            if (!formKey.currentState!.validate()) {
              return;
            }
            List<File>? attachment = context
                .read<MultiImageCubit>()
                .state
                ?.map((e) => convertUint8ListToFile(e))
                .toList();
            if (!widget.isEdit) {
              AddTreatmentPayload payload = AddTreatmentPayload(
                fishpondId: widget.fishpondId,
                fishpondcycleId: widget.fishpondcycleId,
                datetime: DateTime.parse(
                  "${dateController.text} ${hourController.text}",
                ),
                fishAge: int.parse(fishAgeController.text),
                name: treatmentController.text,
                cost: int.parse(priceController.text.unFormatedCurrency()),
                note: noteController.text,
              );
              context
                  .read<ActivityTreatmentAddCubit>()
                  .addTreatment(payload, attachment ?? []);
              return;
            } else {
              UpdateTreatmentPayload payload = UpdateTreatmentPayload(
                id: widget.data?.id ?? "",
                datetime: DateTime.parse(
                  "${dateController.text} ${hourController.text}",
                ),
                fishAge: int.parse(fishAgeController.text),
                name: treatmentController.text,
                cost: int.parse(priceController.text.unFormatedCurrency()),
                note: noteController.text,
              );
              context
                  .read<ActivityTreatmentAddCubit>()
                  .updateTreatment(payload, attachment ?? []);
            }
          },
        ),
      );
    }

    return Column(
      children: [
        Expanded(child: body()),
        button(),
      ],
    );
  }
}
