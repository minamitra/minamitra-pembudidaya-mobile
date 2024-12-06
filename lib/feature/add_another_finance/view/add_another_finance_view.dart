import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/fishpond_cycle_cost_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_another_finance/logic/add_another_finance_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddAnotherFinanceView extends StatefulWidget {
  const AddAnotherFinanceView({
    required this.isRequiredCycleID,
    this.otherCostData,
    required this.tebarDate,
    super.key,
  });

  final bool isRequiredCycleID;
  final FishpondCycleCostResponseData? otherCostData;
  final DateTime tebarDate;

  @override
  State<AddAnotherFinanceView> createState() => _AddAnotherFinanceViewState();
}

class _AddAnotherFinanceViewState extends State<AddAnotherFinanceView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cycleParameterController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController financeTypeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.otherCostData != null) {
      dateController.text = AppConvertDateTime()
          .dmyName(widget.otherCostData?.date ?? DateTime.now());
      financeTypeController.text =
          widget.otherCostData!.type.handlingEmptyString();
      notesController.text = widget.otherCostData!.note.handlingEmptyString();
      nominalController.text =
          widget.otherCostData!.nominal.handlingEmptyString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cycleField() {
      return AppValidatorTextField(
        controller: cycleParameterController,
        withUpperLabel: true,
        readOnly: true,
        isMandatory: true,
        labelText: 'Siklus',
        hintText: 'Pilih siklus',
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          'Pilih Siklus',
          ['Silus 1', 'Siklus 2', 'Siklus 3'],
          (String value) {
            cycleParameterController.text = value;
          },
        ),
      );
    }

    Widget dateField() {
      return BlocBuilder<AddAnotherFinanceCubit, AddAnotherFinanceState>(
        builder: (context, state) {
          return AppValidatorTextField(
            readOnly: true,
            controller: dateController,
            hintText: 'Pilih Tanggal',
            labelText: 'Tanggal',
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
                initialDate: state.selectedDate ?? DateTime.now(),
                firstDate: widget.tebarDate,
                lastDate: DateTime.now().add(const Duration(days: 1)),
              ).then((date) {
                if (date != null) {
                  dateController.text = AppConvertDateTime().dmyName(date);
                  context.read<AddAnotherFinanceCubit>().setSelectedDate(date);
                }
              });
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Tanggal tidak boleh kosong';
              }
              return null;
            },
          );
        },
      );
    }

    Widget financeType() {
      return AppValidatorTextField(
        controller: financeTypeController,
        withUpperLabel: true,
        readOnly: true,
        isMandatory: true,
        labelText: 'Jenis Biaya',
        hintText: 'Pilih Jenis Biaya',
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Jenis biaya tidak boleh kosong';
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          'Pilih Jenis Biaya',
          [
            'Sewa Kolam',
            'Servis Kolam',
            'Peralatan Pendukung',
            'Operasional Cetak Pakan',
            'Tenaga Kerja',
          ],
          (String value) {
            financeTypeController.text = value;
          },
        ),
      );
    }

    Widget notesField() {
      return AppValidatorTextField(
        controller: notesController,
        withUpperLabel: true,
        isMandatory: true,
        labelText: 'Catatan',
        hintText: 'Masukkan catatan',
        maxLines: 3,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Catatan tidak boleh kosong';
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
                'Unggah Lampiran',
                style: appTextTheme(context).bodyMedium,
              ),
              Text(
                ' *',
                style: appTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<AddAnotherFinanceCubit, AddAnotherFinanceState>(
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
                        'Upload Gambar',
                        (type) async {
                          if (state.images.length == 3) {
                            AppTopSnackBar(context)
                                .showInfo('Maksimal 3 gambar');
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
                                if (context.mounted) {
                                  await context
                                      .read<AddAnotherFinanceCubit>()
                                      .setImage(File(document.path));
                                  Navigator.of(bottomSheetContext).pop();
                                }
                              }
                              break;
                            case PhotoSource.gallery:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.gallery,
                              );
                              if (document != null) {
                                if (context.mounted) {
                                  await context
                                      .read<AddAnotherFinanceCubit>()
                                      .setImage(File(document.path));
                                  Navigator.of(bottomSheetContext).pop();
                                }
                              }
                              break;
                          }
                        },
                      );
                    },
                  );
                },
                listImage: state.images,
                onTapImage: (value) {
                  context.read<AddAnotherFinanceCubit>().removeImage(value);
                },
              );
            },
          ),
        ],
      );
    }

    Widget nominalField() {
      return AppValidatorTextField(
        controller: nominalController,
        withUpperLabel: true,
        isMandatory: true,
        labelText: 'Nominal',
        hintText: 'Masukkan Nominal',
        inputType: TextInputType.phone,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Nominal tidak boleh kosong';
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            'Rp ',
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        inputFormatters: [AppCurrencyFormatter.currency],
      );
    }

    Widget deleteButton() {
      return AppPrimaryOutlineFullButton(
        'Hapus Data',
        () {
          showDeleteBottomSheet(
            context,
            title: 'Hapus Data ?',
            descriptions:
                'Data yang sudah terhapus\ntidak dapat dipulihkan kembali!',
            onTapDelete: () {
              Navigator.of(context).pop();
              context
                  .read<AddAnotherFinanceCubit>()
                  .deleteData(widget.otherCostData?.id ?? '0');
            },
          );
        },
      );
    }

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  if (widget.isRequiredCycleID) cycleField(),
                  if (widget.isRequiredCycleID) const SizedBox(height: 18.0),
                  dateField(),
                  const SizedBox(height: 18.0),
                  nominalField(),
                  const SizedBox(height: 18.0),
                  financeType(),
                  const SizedBox(height: 18.0),
                  notesField(),
                  const SizedBox(height: 18.0),
                  fileAttachment(),
                  if (widget.otherCostData != null) ...[
                    const SizedBox(height: 24.0),
                    deleteButton(),
                  ],
                  const SizedBox(height: 18.0),
                ],
              ),
            ),
            AppPrimaryFullButton(
              'Simpan',
              () {
                if (formKey.currentState!.validate()) {
                  if (widget.otherCostData == null) {
                    context.read<AddAnotherFinanceCubit>().addData(
                          costType: financeTypeController.text,
                          notes: notesController.text,
                          nominal: int.parse(
                            nominalController.text.unFormatedCurrency(),
                          ),
                        );
                  } else {
                    context.read<AddAnotherFinanceCubit>().updateData(
                          id: widget.otherCostData?.id ?? '0',
                          costType: financeTypeController.text,
                          notes: notesController.text,
                          nominal: int.parse(
                            nominalController.text.unFormatedCurrency(),
                          ),
                        );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
