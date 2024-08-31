import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/logics/activity_incident_picture_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/repositories/map_callback_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/set_location_page.dart';
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
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController regencyController = TextEditingController();
  final TextEditingController subdisctrictController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  Function() bottomSheetShowModal(
    BuildContext context,
    String title,
    List<String> data,
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
          if (value is String) {}
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
          "Informasi Lokasi",
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

    Widget fileAttachment() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text(
                "Unggah Lampiran",
                style: appTextTheme(context).bodyMedium,
              ),
              Text(
                " *",
                style: appTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<ActivityIncidentPictureCubit, List<Uint8List>?>(
            builder: (context, state) {
              return AppPickImageCard(
                () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    builder: (bottomSheetContext) {
                      return AppImagePickerMenu(
                        "Upload Gambar",
                        (type) async {
                          switch (type) {
                            case PhotoSource.camera:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.camera,
                              );
                              if (document != null) {
                                await document.readAsBytes().then((image) {
                                  context
                                      .read<ActivityIncidentPictureCubit>()
                                      .setImage(image);
                                  Navigator.of(bottomSheetContext).pop();
                                });
                              }
                              break;
                            case PhotoSource.gallery:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.gallery,
                              );
                              if (document != null) {
                                await document.readAsBytes().then((image) {
                                  context
                                      .read<ActivityIncidentPictureCubit>()
                                      .setImage(image);
                                  Navigator.of(bottomSheetContext).pop();
                                });
                              }
                              break;
                          }
                        },
                      );
                    },
                  );
                },
                listImage: state ?? [],
                onTapImage: (value) {
                  context
                      .read<ActivityIncidentPictureCubit>()
                      .removeImage(value);
                },
              );
            },
          ),
        ],
      );
    }

    List<Widget> form() {
      return [
        AppValidatorTextField(
          controller: provinceController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Provinsi",
          hintText: "Pilih provinsi",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Provinsi tidak boleh kosong";
            }
            return null;
          },
          onTap: bottomSheetShowModal(
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
          ),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: regencyController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Kabupaten",
          hintText: "Pilih kabupaten",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Kabupaten tidak boleh kosong";
            }
            return null;
          },
          onTap: bottomSheetShowModal(
            context,
            "Pilih Kabupaten",
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
          ),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: subdisctrictController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Kecamatan",
          hintText: "Pilih kecamatan",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Kecamatan tidak boleh kosong";
            }
            return null;
          },
          onTap: bottomSheetShowModal(
            context,
            "Pilih kecamatan",
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
          ),
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: villageController,
          isMandatory: true,
          withUpperLabel: true,
          readOnly: true,
          labelText: "Kelurahan",
          hintText: "Pilih kelurahan",
          suffixWidget: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.arrow_drop_down_rounded),
          ),
          suffixConstraints: const BoxConstraints(),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Kelurahan tidak boleh kosong";
            }
            return null;
          },
          onTap: bottomSheetShowModal(
            context,
            "Pilih kelurahan",
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
          ),
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
          onTap: () {
            Navigator.of(context)
                .push(AppTransition.pushTransition(
              const SetLocationPage(),
              SetLocationPage.routeSettings(),
            ))
                .then((value) {
              if (value != null) {
                if (value is MapCallbackData) {}
              }
            });
          },
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
        fileAttachment(),
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
