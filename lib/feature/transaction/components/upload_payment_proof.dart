import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

Function() onImageTap(
  BuildContext context,
  Function(File image) imageChanged,
) {
  return () {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (bottomSheetContext) {
        return AppImagePickerMenu(
          'Upload Gambar',
          (type) async {
            switch (type) {
              case PhotoSource.camera:
                final document = await pickDocumentImage(
                  bottomSheetContext,
                  ImageSource.camera,
                  maxSize: 2000000,
                  typeValidations: ['jpg', 'jpeg', 'png', 'img'],
                );
                if (document != null) {
                  if (context.mounted) {
                    imageChanged(File(document.path));
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (bottomSheetContext.mounted) {
                      Navigator.of(bottomSheetContext).pop();
                    }
                  }
                }
                break;
              case PhotoSource.gallery:
                final document = await pickDocumentImage(
                  bottomSheetContext,
                  ImageSource.gallery,
                  maxSize: 2000000,
                  typeValidations: ['jpg', 'jpeg', 'png', 'img'],
                );
                if (document != null) {
                  if (context.mounted) {
                    imageChanged(File(document.path));
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (bottomSheetContext.mounted) {
                      Navigator.of(bottomSheetContext).pop();
                    }
                  }
                }
                break;
            }
          },
        );
      },
    );
  };
}

Function() uploadPaymentProof(
  BuildContext context,
  Function(File image, String notes) onSubmit,
) {
  return () {
    File? proofImage;
    final TextEditingController noteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        Widget noteTextField() {
          return AppValidatorTextField(
            controller: noteController,
            hintText: 'Masukan catatan',
            labelText: 'Catatan',
            maxLines: 3,
          );
        }

        return StatefulBuilder(
          builder: (stateContext, setModalState) {
            return AppBottomSheet(
              'Bukti Pembayaran',
              height: MediaQuery.of(context).size.height * 0.7,
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Unggah Bukti',
                        style: appTextTheme(context).bodyMedium,
                      ),
                      Text(
                        ' *',
                        style: appTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  AppAnimatedSize(
                    isShow: true,
                    child: SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: InkWell(
                        onTap: onImageTap(
                          context,
                          (file) {
                            setModalState(() {
                              proofImage = file;
                            });
                          },
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: AppColor.neutral[200]!),
                          ),
                          child: proofImage == null
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.galleryIcon,
                                      height: 32,
                                    ),
                                    const SizedBox(height: 18.0),
                                    Text(
                                      'Tambah Gambar',
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.neutral[500],
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Image.file(
                                  proofImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Unggah file .jpg, .jpeg, .png, .img ukuran maks 2MB',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.neutral[500],
                        ),
                  ),
                  const SizedBox(height: 16),
                  noteTextField(),
                  const SizedBox(height: 36),
                  AppPrimaryFullButton(
                    'Konfirmasi',
                    () {
                      if (proofImage == null) {
                        AppTopSnackBar(context)
                            .showDanger('Upload bukti terlebih dahulu');
                        return;
                      }
                      onSubmit(proofImage!, noteController.text);
                      Navigator.of(context).pop();
                    },
                    height: 56,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
                ],
              ),
            );
          },
        );
      },
    );
  };
}
