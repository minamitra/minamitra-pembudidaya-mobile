import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddBulkFeedView extends StatefulWidget {
  const AddBulkFeedView({super.key});

  @override
  State<AddBulkFeedView> createState() => _AddBulkFeedViewState();
}

class _AddBulkFeedViewState extends State<AddBulkFeedView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  bool isShow = false;

  Function() bottomSheetShowModal(
    BuildContext context,
    String title,
    List<String> data,
    Function(String value)? onChanged,
  ) {
    return () {
      showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
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
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: AppColor.neutral[100],
                              thickness: 1.0,
                              height: 0.0,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(data[index]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  data[index],
                                  textAlign: TextAlign.start,
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.black,
                                          ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
            onChanged!(value);
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Widget dateTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: AppValidatorTextField(
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
        ),
      );
    }

    Widget hourTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: AppValidatorTextField(
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
        ),
      );
    }

    Widget pondCard(
      String title,
      Function(bool isShow) onTapShow,
      bool isShow,
      int recommendation,
      Function(String)? onChangedFeedAmount,
      Function(String) onChangedFeedGiven,
      List<String> listFeedType,
    ) {
      final TextEditingController selectFeed = TextEditingController();

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColor.neutral[300]!),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                onTapShow(!isShow);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.assignment_turned_in_rounded,
                      color: AppColor.secondary[900],
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      "0 Gram",
                      style: appTextTheme(context).titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 18.0),
                    Icon(
                      isShow
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.arrow_forward_ios_rounded,
                      color: AppColor.neutral[300],
                    ),
                  ],
                ),
              ),
            ),
            if (isShow) ...[
              Divider(
                color: AppColor.neutral[300],
                height: 0.0,
              ),
              const SizedBox(height: 18.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColor.accent[50],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColor.accent[900]!),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.handStarsIcon,
                      height: 20.0,
                      width: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        "Saran pakan : $recommendation gram",
                        style: appTextTheme(context).titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.accent[900],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "Terapkan",
                        style: appTextTheme(context).titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      size: 16.0,
                      color: AppColor.accent[900],
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      "Pemberian pakan 2-3 kali per hari",
                      style: appTextTheme(context).labelLarge?.copyWith(
                            color: AppColor.accent[900],
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppValidatorTextField(
                  labelText: "Jumlah Pakan",
                  hintText: "0",
                  withUpperLabel: true,
                  isMandatory: true,
                  suffixText: "gram",
                  onChanged: onChangedFeedAmount,
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppValidatorTextField(
                  controller: selectFeed,
                  labelText: "Pakan Diberikan",
                  hintText: "Pilih Pakan",
                  withUpperLabel: true,
                  isMandatory: true,
                  suffixWidget: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColor.neutral[400],
                  ),
                  readOnly: true,
                  onTap: () {
                    bottomSheetShowModal(
                      context,
                      "Pilih Provinsi",
                      [
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh",
                        "contoh"
                      ],
                      (value) {
                        selectFeed.text = value;
                        onChangedFeedAmount!(value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 18.0),
            ]
          ],
        ),
      );
    }

    Widget form() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "*Wajib Diisi",
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.red[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Divider(
              color: AppColor.neutral[300],
              thickness: 1,
              height: 0.0,
            ),
          ),
          const SizedBox(height: 18.0),
          dateTextField(),
          const SizedBox(height: 18.0),
          hourTextField(),
          const SizedBox(height: 36.0),
          Divider(
            color: AppColor.neutral[100],
            thickness: 8.0,
            height: 0.0,
          ),
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Pemberian Pakan",
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 18.0),
          pondCard(
            "Kolam 1",
            (bool value) {
              setState(() {
                isShow = value;
              });
            },
            isShow,
            100,
            (value) {},
            (value) {},
            [
              "Pakan 1",
              "Pakan 2",
              "Pakan 3",
              "Pakan 4",
              "Pakan 5",
              "Pakan 6",
              "Pakan 7",
              "Pakan 8",
              "Pakan 9",
            ],
          ),
        ],
      );
    }

    Widget submitButton() {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: AppPrimaryFullButton(
          "Simpan",
          () {},
        ),
      );
    }

    return Column(
      children: [
        Expanded(child: form()),
        submitButton(),
      ],
    );
  }
}
