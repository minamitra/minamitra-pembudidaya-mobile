import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
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
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/logics/activity_water_quality_add_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/add_water_quality_payload.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityWaterQualityAddView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;

  const ActivityWaterQualityAddView(
    this.fishpondId,
    this.fishpondcycleId, {
    super.key,
  });

  @override
  State<ActivityWaterQualityAddView> createState() =>
      _ActivityWaterQualityAddViewState();
}

class _ActivityWaterQualityAddViewState
    extends State<ActivityWaterQualityAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController waterLevelController = TextEditingController();
  final TextEditingController waterPHController = TextEditingController();
  final TextEditingController salinityController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController dOController = TextEditingController();
  final TextEditingController brightnessController = TextEditingController();
  final TextEditingController orpController = TextEditingController();
  final TextEditingController waterColorController = TextEditingController();
  final TextEditingController weatherController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

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

    Widget hourTextField() {
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
                ;
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

    Widget waterLevel() {
      return AppValidatorTextField(
        controller: waterLevelController,
        hintText: "0",
        labelText: "Ketinggian Air",
        inputType: TextInputType.number,
        isMandatory: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "Ketinggian air tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "cm",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget waterPH() {
      return AppValidatorTextField(
        controller: waterPHController,
        hintText: "0",
        labelText: "PH",
        inputType: TextInputType.number,
        isMandatory: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "PH air tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget salinity() {
      return AppValidatorTextField(
        controller: salinityController,
        hintText: "0",
        labelText: "Salinitas",
        inputType: TextInputType.number,
        isMandatory: false,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return null;
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "ppt",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget temperature() {
      return AppValidatorTextField(
        controller: temperatureController,
        hintText: "0",
        labelText: "Suhu",
        inputType: TextInputType.number,
        isMandatory: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "Temperatur tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "°C",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget dO() {
      return AppValidatorTextField(
        controller: dOController,
        hintText: "0",
        labelText: "DO",
        inputType: TextInputType.number,
        isMandatory: false,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return null;
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "mg/L",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget brightness() {
      return AppValidatorTextField(
        controller: brightnessController,
        hintText: "0",
        labelText: "Kecerahan",
        inputType: TextInputType.number,
        isMandatory: false,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return null;
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "mg/L",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget orp() {
      return AppValidatorTextField(
        controller: orpController,
        hintText: "0",
        labelText: "ORP",
        inputType: TextInputType.number,
        isMandatory: false,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return null;
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "mg/L",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget waterColor() {
      return AppValidatorTextField(
        controller: waterColorController,
        isMandatory: true,
        withUpperLabel: true,
        readOnly: true,
        labelText: "Warna Air",
        hintText: "Pilih Air",
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Warna air tidak boleh kosong";
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          "Pilih warna air",
          ["Cokelat", "Biru", "Bening"],
          (value) {
            waterColorController.text = value;
          },
        ),
      );
    }

    Widget weather() {
      return AppValidatorTextField(
        controller: weatherController,
        isMandatory: true,
        withUpperLabel: true,
        readOnly: true,
        labelText: "Cuaca",
        hintText: "Pilih cuaca",
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Cuaca tidak boleh kosong";
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          "Pilih cuaca",
          ["Mendung", "Badai", "Cerah"],
          (value) {
            weatherController.text = value;
          },
        ),
      );
    }

    Widget noteTextField() {
      return AppValidatorTextField(
        controller: notesController,
        hintText: "Masukan catatan",
        labelText: "Catatan",
        maxLines: 3,
        isMandatory: false,
        // validator: (String? value) {
        //   if (value?.isEmpty ?? true) {
        //     return null;
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
              Text(
                " *",
                style: appTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
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
            waterLevel(),
            const SizedBox(height: 16.0),
            waterPH(),
            const SizedBox(height: 16.0),
            salinity(),
            const SizedBox(height: 16.0),
            temperature(),
            const SizedBox(height: 16.0),
            dO(),
            const SizedBox(height: 16.0),
            brightness(),
            const SizedBox(height: 16.0),
            orp(),
            const SizedBox(height: 16.0),
            waterColor(),
            const SizedBox(height: 16.0),
            noteTextField(),
            const SizedBox(height: 16.0),
            weather(),
            const SizedBox(height: 16.0),
            fileAttachment(),
            const SizedBox(height: 68.0),
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
            AddWaterQualityPayload payload = AddWaterQualityPayload(
              fishpondId: widget.fishpondId,
              fishpondcycleId: widget.fishpondcycleId,
              datetime: DateTime.parse(
                "${dateController.text} ${hourController.text}",
              ),
              level: double.parse(waterLevelController.text),
              ph: double.parse(waterPHController.text),
              salinitas: double.parse(salinityController.text),
              temperature: double.parse(temperatureController.text),
              dissolvedOxygen: double.parse(dOController.text),
              clarity: double.parse(brightnessController.text),
              orp: double.parse(orpController.text),
              waterColor: waterColorController.text,
              waterWeather: weatherController.text,
              note: notesController.text,
            );
            context.read<ActivityWaterQualityAddCubit>().addWaterQuality(
                  payload,
                  attachment ?? [],
                );
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
