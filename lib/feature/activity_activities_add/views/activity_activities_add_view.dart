import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/view/add_new_feed_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesAddView extends StatefulWidget {
  const ActivityActivitiesAddView({super.key});

  @override
  State<ActivityActivitiesAddView> createState() =>
      _ActivityActivitiesAddViewState();
}

class _ActivityActivitiesAddViewState extends State<ActivityActivitiesAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController totalAmountFeedFromInitController =
      TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController fishAgeController = TextEditingController();

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  List<String> listType = ['Pakan Pagi', 'Pakan Sore', 'Lainnya'];

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
          itemCount: listType.length,
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
                  listType[index],
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.neutral[600],
                      ),
                ),
                value: listType[index],
                groupValue: typeController.text,
                onChanged: (value) {
                  setState(() {
                    typeController.text = value.toString();
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget amountTextField() {
    return AppValidatorTextField(
      controller: amountController,
      hintText: "Masukan jumlah pakan",
      labelText: "Jumlah Pakan Diberikan ",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah tidak boleh kosong";
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

  Widget brandTextField() {
    return AppValidatorTextField(
      controller: brandController,
      hintText: "Masukan merk",
      labelText: "Merk",
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Merk tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget noteTextField() {
    return AppValidatorTextField(
      controller: noteController,
      hintText: "Masukan catatan",
      labelText: "Catatan",
      maxLines: 3,
      isMandatory: false,
      validator: (String? value) {
        if (value!.isEmpty) {
          // return "Catatan tidak boleh kosong";
          return null;
        }
        return null;
      },
    );
  }

  Widget suggestion() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.accent[50],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColor.accent[900]!),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error,
                color: AppColor.accent[900],
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  "Saran Pakan: 90 gram",
                  style: appTextTheme(context).titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.accent[900],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Terapkan',
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.error,
              color: AppColor.neutral[600],
              size: 16.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              "Pemberian pakan 2-3 kali per hari",
              style: appTextTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral[600],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget brandName() {
    return AppValidatorTextField(
      controller: brandController,
      isMandatory: true,
      withUpperLabel: true,
      readOnly: true,
      labelText: "Nama Pakan Diberikan",
      hintText: "Pilih Pakan",
      suffixWidget: const Padding(
        padding: EdgeInsets.only(right: 18.0),
        child: Icon(Icons.arrow_drop_down_rounded),
      ),
      suffixConstraints: const BoxConstraints(),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Pakan tidak boleh kosong";
        }
        return null;
      },
      onTap: appBottomSheetShowModalWithCustomButton(
        context: context,
        title: "Pilih Pakan",
        data: ["Pakan 1", "Pakan 2", "Pakan 3"],
        onSelected: (value) {},
        buttonWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: AppColor.primary[600],
            ),
            const SizedBox(width: 8.0),
            Text(
              "Tambah Pakan Baru",
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: AppColor.primary[600],
                  ),
            ),
          ],
        ),
        onTapButtonBottom: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(AppTransition.pushTransition(
            const AddNewFeedPage(),
            AddNewFeedPage.routeSettings,
          ));
        },
      ),
    );
  }

  Widget totalAmountFeedFromInit() {
    return AppValidatorTextField(
      controller: totalAmountFeedFromInitController,
      hintText: "0",
      labelText: "Total Pakan Diberikan",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah tidak boleh kosong";
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

  Widget fishAge() {
    return AppValidatorTextField(
      controller: fishAgeController,
      hintText: "0",
      labelText: "Umur Ikan",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
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

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          dateTextField(context),
          const SizedBox(height: 16.0),
          hourTextField(context),
          const SizedBox(height: 16.0),
          fishAge(),
          const SizedBox(height: 16.0),
          suggestion(),
          amountTextField(),
          const SizedBox(height: 16.0),
          brandName(),
          const SizedBox(height: 16.0),
          totalAmountFeedFromInit(),
          const SizedBox(height: 16.0),
          noteTextField(),
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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        body(),
        button(),
      ],
    );
  }
}
