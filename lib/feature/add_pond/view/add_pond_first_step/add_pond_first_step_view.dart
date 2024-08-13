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
  final TextEditingController pondLengthController = TextEditingController();
  final TextEditingController fishCountController = TextEditingController();
  final TextEditingController spreadSizeController = TextEditingController();
  final TextEditingController targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pondInformation() {
      return [
        const SizedBox(height: 18.0),
        Text(
          "Informasi Pakan",
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
          controller: pondLengthController,
          inputType: TextInputType.phone,
          isMandatory: true,
          withUpperLabel: true,
          labelText: "Luas Lahan",
          hintText: "0",
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              "m2",
              style: appTextTheme(context).bodySmall?.copyWith(
                    color: AppColor.neutral[500],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Luas lahan tidak boleh kosong";
            }
            return null;
          },
        ),
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
              return "Junmlah ikan tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: spreadSizeController,
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
              return "Ukuran tebar tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: targetController,
          inputType: TextInputType.phone,
          isMandatory: true,
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
            if (value == null || value.isEmpty) {
              return "Target bobot panen tidak boleh kosong";
            }
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
