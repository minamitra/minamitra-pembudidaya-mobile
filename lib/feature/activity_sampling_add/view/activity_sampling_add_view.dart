import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/multi_image/multi_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivitySamplingAddView extends StatefulWidget {
  const ActivitySamplingAddView({super.key});

  @override
  State<ActivitySamplingAddView> createState() =>
      _ActivitySamplingAddViewState();
}

class _ActivitySamplingAddViewState extends State<ActivitySamplingAddView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController mbwController = TextEditingController();
  final TextEditingController srController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

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
                dateController.text = AppConvertDateTime().dmyName(date);
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

    Widget mbw() {
      return AppValidatorTextField(
        controller: mbwController,
        hintText: "0",
        labelText: "MBW",
        inputType: TextInputType.number,
        isMandatory: true,
        withUpperLabel: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "MBW tidak boleh kosong";
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

    Widget sr() {
      return AppValidatorTextField(
        controller: srController,
        hintText: "0",
        labelText: "SR",
        inputType: TextInputType.number,
        isMandatory: true,
        withUpperLabel: true,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "SR tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
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
      );
    }

    Widget noteTextField() {
      return AppValidatorTextField(
        controller: noteController,
        hintText: "Masukan catatan",
        labelText: "Catatan",
        maxLines: 3,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Catatan tidak boleh kosong";
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
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          dateTextField(),
          const SizedBox(height: 16.0),
          hourTextField(),
          const SizedBox(height: 16.0),
          mbw(),
          const SizedBox(height: 16.0),
          sr(),
          const SizedBox(height: 16.0),
          noteTextField(),
          const SizedBox(height: 16.0),
          noteTextField(),
          const SizedBox(height: 16.0),
          fileAttachment(),
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
          () {},
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
