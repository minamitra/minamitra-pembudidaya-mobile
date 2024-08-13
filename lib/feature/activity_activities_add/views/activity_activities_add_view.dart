import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
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
    // return AppValidatorTextField(
    //   controller: typeController,
    //   hintText: "Masukan jenis kegiatan",
    //   labelText: "Jenis Kegiatan",
    //   isMandatory: true,
    //   validator: (String? value) {
    //     if (value!.isEmpty) {
    //       return "Jenis tidak boleh kosong";
    //     }
    //     return null;
    //   },
    // );
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
      hintText: "Masukan jumlah",
      labelText: "Jumlah",
      inputType: TextInputType.number,
      isMandatory: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Jumlah tidak boleh kosong";
        }
        return null;
      },
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
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Catatan tidak boleh kosong";
        }
        return null;
      },
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
          typeTextField(),
          const SizedBox(height: 16.0),
          amountTextField(),
          const SizedBox(height: 16.0),
          brandTextField(),
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
