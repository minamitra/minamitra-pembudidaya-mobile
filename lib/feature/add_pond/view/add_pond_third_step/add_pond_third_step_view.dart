import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondThirdStepView extends StatefulWidget {
  const AddPondThirdStepView(this.formThirdStepKey, {super.key});

  final GlobalKey<FormState> formThirdStepKey;

  @override
  State<AddPondThirdStepView> createState() => _AddPondThirdStepViewState();
}

class _AddPondThirdStepViewState extends State<AddPondThirdStepView> {
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController regencyController = TextEditingController();
  final TextEditingController subdisctrictController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController fileController = TextEditingController();

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
          "Pilih jenis pakan yang tepat untuk setiap tahap pertumbuhan ikan agar pertumbuhan ikan optimal..",
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
        AppDropdownTextField(
          "Provinsi",
          ["contoh", "contohs", "aowkoakw"],
          provinceController,
          isMandatory: true,
          hint: "Pilih provinsi",
        ),
        const SizedBox(height: 18.0),
        AppDropdownTextField(
          "Kabupaten",
          ["contoh", "contohs", "aowkoakw"],
          regencyController,
          isMandatory: true,
          hint: "Pilih kabupaten",
        ),
        const SizedBox(height: 18.0),
        AppDropdownTextField(
          "Kecamatan",
          ["contoh", "contohs", "aowkoakw"],
          subdisctrictController,
          isMandatory: true,
          hint: "Pilih kecamatan",
        ),
        const SizedBox(height: 18.0),
        AppDropdownTextField(
          "Kelurahan",
          ["contoh", "contohs", "aowkoakw"],
          villageController,
          isMandatory: true,
          hint: "Pilih kelurahan",
        ),
        const SizedBox(height: 18.0),
        Text(
          "Lokasi Kolam",
          style: appTextTheme(context)
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColor.neutral[200]!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary[600],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 18.0,
                      color: AppColor.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    "Pilih lokasi",
                    style: appTextTheme(context).bodySmall?.copyWith(
                          color: AppColor.neutral[400],
                        ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.black[800],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: fileController,
          hintText: "Pilih File",
          labelText: "Foto Kolam",
          isMandatory: false,
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.file_upload_outlined,
              color: AppColor.black[800],
            ),
          ),
          suffixConstraints: const BoxConstraints(),
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
