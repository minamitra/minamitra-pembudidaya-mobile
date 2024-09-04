import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleAddView extends StatefulWidget {
  const ActivityCycleAddView({super.key});

  @override
  State<ActivityCycleAddView> createState() => _ActivityCycleAddViewState();
}

class _ActivityCycleAddViewState extends State<ActivityCycleAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController buyerController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  AppValidatorTextField dateTextField(BuildContext context) {
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

  AppValidatorTextField hourTextField(BuildContext context) {
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

  Widget amountTextField() {
    return AppValidatorTextField(
      controller: amountController,
      hintText: "Masukan total panen",
      labelText: "Total Panen",
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
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget priceTextField() {
    return AppValidatorTextField(
      controller: priceController,
      hintText: "Masukan harga jual",
      labelText: "Harga Jual",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Harga jual tidak boleh kosong";
        }
        return null;
      },
      suffixConstraints: const BoxConstraints(),
      suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Text(
          "Rp/kg",
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget buyerTextField() {
    return AppValidatorTextField(
      controller: buyerController,
      hintText: "Masukan nama pembeli",
      labelText: "Pembeli",
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Nama pembeli tidak boleh kosong";
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
              "Lampiran",
              style: appTextTheme(context).bodyMedium,
            ),
            Text(
              " *",
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: AppColor.red),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<ActivityCyclePictureCubit, List<Uint8List>?>(
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
                                    .read<ActivityCyclePictureCubit>()
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
                                    .read<ActivityCyclePictureCubit>()
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
                context.read<ActivityCyclePictureCubit>().removeImage(value);
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            dateTextField(context),
            const SizedBox(height: 16.0),
            hourTextField(context),
            const SizedBox(height: 16.0),
            amountTextField(),
            const SizedBox(height: 16.0),
            priceTextField(),
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
            if (formKey.currentState!.validate()) {
              return;
            }
            Navigator.of(context).pop();
          },
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        body(),
        button(),
      ],
    );
  }
}
