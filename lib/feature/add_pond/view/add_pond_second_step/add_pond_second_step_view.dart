import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondSecondStepView extends StatefulWidget {
  const AddPondSecondStepView(this.formSecondStepKey, {super.key});

  final GlobalKey<FormState> formSecondStepKey;

  @override
  State<AddPondSecondStepView> createState() => _AddPondSecondStepViewState();
}

class _AddPondSecondStepViewState extends State<AddPondSecondStepView> {
  final TextEditingController starterFeedController = TextEditingController();
  final TextEditingController growerFeedController = TextEditingController();
  final TextEditingController finisherFeedController = TextEditingController();

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
          "Pakan Starter",
          ["contoh", "contohs", "aowkoakw"],
          starterFeedController,
          isMandatory: true,
          hint: "Pilih pakan",
        ),
        const SizedBox(height: 18.0),
        AppDropdownTextField(
          "Pakan Grower",
          ["contoh", "contohs", "aowkoakw"],
          growerFeedController,
          isMandatory: true,
          hint: "Pilih pakan",
        ),
        const SizedBox(height: 18.0),
        AppDropdownTextField(
          "Pakan Finisher",
          ["contoh", "contohs", "aowkoakw"],
          finisherFeedController,
          isMandatory: true,
          hint: "Pilih pakan",
        ),
      ];
    }

    return Form(
      key: widget.formSecondStepKey,
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
