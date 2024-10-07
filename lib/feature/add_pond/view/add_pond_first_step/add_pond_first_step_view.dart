import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_first_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/update_pond_payload.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondFirstStepView extends StatefulWidget {
  const AddPondFirstStepView(
    this.rootPageController, {
    this.pondData,
    super.key,
  });

  final PageController rootPageController;
  final PondResponseData? pondData;

  @override
  State<AddPondFirstStepView> createState() => _AddPondFirstStepViewState();
}

class _AddPondFirstStepViewState extends State<AddPondFirstStepView> {
  // final TextEditingController pondNameController = TextEditingController();
  // final TextEditingController pondlengthController = TextEditingController();
  // final TextEditingController pondWidthController = TextEditingController();
  // final TextEditingController pondWideController = TextEditingController();
  // final TextEditingController pondDeepController = TextEditingController();

  final GlobalKey<FormState> formFirstStepKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final AddPondFirstStepCubit firstStepCubit =
        context.read<AddPondFirstStepCubit>();

    if (widget.pondData != null) {
      firstStepCubit.pondNameController.text = widget.pondData!.name!;
      firstStepCubit.pondlengthController.text = widget.pondData!.areaLength!;
      firstStepCubit.pondWidthController.text = widget.pondData!.areaWidth!;
      firstStepCubit.pondWideController.text =
          (double.parse(widget.pondData!.areaLength!) *
                  double.parse(widget.pondData!.areaWidth!))
              .toStringAsFixed(0);
      firstStepCubit.pondDeepController.text = widget.pondData!.areaDepth ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final AddPondFirstStepCubit firstStepCubit =
        context.read<AddPondFirstStepCubit>();

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
          controller: firstStepCubit.pondNameController,
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
          controller: firstStepCubit.pondlengthController,
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
            firstStepCubit.pondWideController.text =
                (double.parse(value.isEmpty ? "0" : value) *
                        double.parse(
                            firstStepCubit.pondWidthController.text.isEmpty
                                ? "0"
                                : firstStepCubit.pondWidthController.text))
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
          controller: firstStepCubit.pondWidthController,
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
            firstStepCubit.pondWideController.text =
                (double.parse(value.isEmpty ? "0" : value) *
                        double.parse(firstStepCubit.pondlengthController.text))
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
          controller: firstStepCubit.pondDeepController,
          inputType: TextInputType.phone,
          isMandatory: false,
          withUpperLabel: true,
          readOnly: false,
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
          controller: firstStepCubit.pondWideController,
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

    Widget bottomButton() {
      return BlocBuilder<AddPondCubit, AddPondState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AppAnimatedSize(
              isShow: true,
              child: AppPrimaryFullButton(
                "Selanjutnya",
                () {
                  if (formFirstStepKey.currentState?.validate() ?? false) {
                    widget.rootPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    context.read<AddPondCubit>().changeStep(1);
                    context.read<AddPondFirstStepCubit>().onChangeData();
                    if (widget.pondData != null) {
                      UpdatePondPayload payload = UpdatePondPayload(
                        id: widget.pondData!.id,
                        name: firstStepCubit.pondNameController.text,
                        areaLength: double.parse(
                            firstStepCubit.pondlengthController.text),
                        areaWidth: double.parse(
                            firstStepCubit.pondWidthController.text),
                        areaDepth: double.parse(
                            firstStepCubit.pondDeepController.text),
                      );
                      context.read<AddPondCubit>().setUpdatePond(payload);
                    }
                  }
                },
              ),
            ),
          );
        },
      );
    }

    return Form(
      key: formFirstStepKey,
      child: Column(
        children: [
          Expanded(
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
          ),
          bottomButton(),
        ],
      ),
    );
  }
}
