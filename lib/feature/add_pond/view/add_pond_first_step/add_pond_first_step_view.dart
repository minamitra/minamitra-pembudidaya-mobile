import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondFirstStepView extends StatefulWidget {
  const AddPondFirstStepView(this.formFirstStepKey, {super.key});

  final GlobalKey<FormState> formFirstStepKey;

  @override
  State<AddPondFirstStepView> createState() => _AddPondFirstStepViewState();
}

class _AddPondFirstStepViewState extends State<AddPondFirstStepView> {
  final TextEditingController pondNameController = TextEditingController();
  final TextEditingController pondlengthController = TextEditingController();
  final TextEditingController pondWidthController = TextEditingController();
  final TextEditingController pondWideController = TextEditingController();
  final TextEditingController pondDeepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pondInformation() {
      return [
        const SizedBox(height: 18.0),
        Text(
          "Informasi Kolam",
          style: appTextTheme(context).titleMedium,
        ),
        const SizedBox(height: 8.0),
        Text(
          "Masukkan detail kolam Anda untuk memastikan data kolam terkelola dengan baik.",
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

    List<Widget> form() {
      return [
        AppValidatorTextField(
          controller: pondNameController,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Nama Kolam",
          hintText: "Ketik nama kolam",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Nama kolam tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pondlengthController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Panjang Kolam",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "m",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          onChanged: (value) {
            pondWideController.text =
                (double.parse(value.isEmpty ? "0" : value) *
                        double.parse(pondWidthController.text))
                    .toStringAsFixed(0);
          },
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Panjang lahan tidak boleh kosong";
            }

            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pondWidthController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Lebar Kolam",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "m",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          onChanged: (value) {
            pondWideController.text =
                (double.parse(value.isEmpty ? "0" : value) *
                        double.parse(pondlengthController.text))
                    .toStringAsFixed(0);
          },
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lebar lahan tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: pondDeepController,
          inputType: TextInputType.phone,
          isMandatory: false,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Kedalaman Kolam",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "m",
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
          controller: pondWideController,
          inputType: TextInputType.phone,
          isMandatory: false,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Luas Kolam",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "m",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          onChanged: (value) {},
          suffixConstraints: const BoxConstraints(),
          fillColor: AppColor.neutral[200],
          validator: (value) {
            return null;
          },
        ),
      ];
    }

    return Form(
      key: widget.formFirstStepKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 18.0),
          ...pondInformation(),
          const SizedBox(height: 18.0),
          ...form(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
