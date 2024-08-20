import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/pakan_starter_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondThirdStepView extends StatefulWidget {
  const AddPondThirdStepView(this.formThirdStepKey, {super.key});

  final GlobalKey<FormState> formThirdStepKey;

  @override
  State<AddPondThirdStepView> createState() => _AddPondThirdStepViewState();
}

class _AddPondThirdStepViewState extends State<AddPondThirdStepView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fishCountController = TextEditingController();
  final TextEditingController spreadController = TextEditingController();
  final TextEditingController seedOriginController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController pakanStarterController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  List<PakanStarterDummy> pakanList = pakanListDummy;

  Function() unpaidShowModal(
    BuildContext context,
    List<PakanStarterDummy> pakanList,
  ) {
    List<PakanStarterDummy> pakanListTemp = [];
    pakanListTemp.addAll(pakanList);
    return () {
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                "Pilihan Pakan Starter",
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
                          itemCount: pakanListTemp.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setModalState(() {
                                  pakanListTemp[index].isActive =
                                      !pakanListTemp[index].isActive;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: pakanListTemp[index].isActive,
                                    onChanged: (value) {
                                      setModalState(() {
                                        pakanListTemp[index].isActive = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      pakanListTemp[index].name,
                                      textAlign: TextAlign.start,
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.black,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppPrimaryOutlineFullButton(
                              "Reset",
                              () {
                                for (var element in pakanListTemp) {
                                  setModalState(() {
                                    element.isActive = false;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 18.0),
                          Expanded(
                            child: AppPrimaryFullButton(
                              "Konfirmasi",
                              () {
                                Navigator.of(context).pop(pakanListTemp);
                              },
                              height: 56,
                            ),
                          ),
                        ],
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
          if (value is List<PakanStarterDummy>) {
            pakanStarterController.text = value
                .where((element) => element.isActive)
                .map((e) => e.name)
                .join(", ");
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
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
        controller: dateController,
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

    List<Widget> form() {
      return [
        dateTextField(),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: fishCountController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Jumlah Ikan",
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
          controller: spreadController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Ukuran Tebar",
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
          controller: seedOriginController,
          inputType: TextInputType.text,
          isMandatory: false,
          withUpperLabel: true,
          labelText: "Asal Benih",
          hintText: "Ketik asal benih",
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: spreadController,
          inputType: TextInputType.phone,
          isMandatory: false,
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
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pakanStarterController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Pakan Starter",
          hintText: "Pilih Pakan",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            return null;
          },
          onTap: unpaidShowModal(context, pakanList),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pakanStarterController,
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
            return null;
          },
          onTap: unpaidShowModal(context, pakanList),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pakanStarterController,
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
            return null;
          },
          onTap: unpaidShowModal(context, pakanList),
        ),
      ];
    }

    return Form(
      key: widget.formThirdStepKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 18.0),
          ...pondInformation(),
          ...form(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
