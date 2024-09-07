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
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/logics/activity_cycle_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityCycleAddHarvestView extends StatefulWidget {
  const ActivityCycleAddHarvestView({super.key});

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
  final TextEditingController buyerTypeController = TextEditingController();
  final TextEditingController buyerController = TextEditingController();
  final TextEditingController sellAmountController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  List<String> listBuyerType = ['Mitra3M', 'Lainnya'];

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
      isMandatory: true,
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
              style:
                  appTextTheme(context).bodyMedium?.copyWith(color: Colors.red),
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

  Widget typeTextField() {
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
          itemCount: listBuyerType.length,
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
                  listBuyerType[index],
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[600],
                      ),
                ),
                value: listBuyerType[index],
                groupValue: buyerTypeController.text,
                onChanged: (value) {
                  setState(() {
                    buyerTypeController.text = value.toString();
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buyerTextField() {
    return AppValidatorTextField(
      controller: buyerController,
      hintText: "Masukkan pembeli",
      labelText: "Pembeli",
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Pembeli tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget sellAmountTextField() {
    return AppValidatorTextField(
      controller: sellAmountController,
      labelText: "Jumlah Dijual",
      hintText: "0",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah dijual tidak boleh kosong";
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

  Widget unitPriceTextField() {
    return AppValidatorTextField(
      controller: unitPriceController,
      labelText: "Harga Satuan",
      hintText: "0",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Harga satuan tidak boleh kosong";
        }
        return null;
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
          typeTextField(),
          const SizedBox(height: 16.0),
          buyerTextField(),
          const SizedBox(height: 16.0),
          sellAmountTextField(),
          const SizedBox(height: 16.0),
          unitPriceTextField(),
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
