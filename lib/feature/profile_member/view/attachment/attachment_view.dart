import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/profile_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AttachmentView extends StatefulWidget {
  final ProfileResponseData profile;

  const AttachmentView(this.profile, {super.key});

  @override
  State<AttachmentView> createState() => _AttachmentViewState();
}

class _AttachmentViewState extends State<AttachmentView> {
  Uint8List? ktpPicture;
  File? ktpPictureFile;
  Uint8List? ekusukaCardPicture;
  File? ekusukaCardPictureFile;

  @override
  void initState() {
    super.initState();
    if (widget.profile.ktpUrl != null && widget.profile.ktpUrl != "") {
      convertKtpImageUrl(widget.profile.ktpUrl!);
    }
    if (widget.profile.ekusukaUrl != null && widget.profile.ekusukaUrl != "") {
      convertEkusukaImageUrl(widget.profile.ekusukaUrl!);
    }
  }

  void convertKtpImageUrl(String image) async {
    http.Response imagePath = await http.get(Uri.parse(image));
    setState(() {
      ktpPicture = imagePath.bodyBytes;
    });
  }

  void convertEkusukaImageUrl(String image) async {
    http.Response imagePath = await http.get(Uri.parse(image));
    setState(() {
      ekusukaCardPicture = imagePath.bodyBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> identityPhoto() {
      return [
        Text(
          "Foto KTP",
          style: appTextTheme(context).titleSmall,
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
                          setState(() {
                            ktpPictureFile = File(document.path);
                          });
                        }
                        break;
                      case PhotoSource.gallery:
                        final document = await pickDocumentImage(
                          bottomSheetContext,
                          ImageSource.gallery,
                        );
                        if (document != null) {
                          setState(() {
                            ktpPictureFile = File(document.path);
                          });
                        }
                        break;
                    }
                  },
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: appColorScheme(context).outlineVariant,
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: (ktpPicture == null && ktpPictureFile == null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.uploadIcon,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Unggah Foto',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).bodyMedium?.copyWith(
                                color: AppColor.neutral[400],
                              ),
                        ),
                      ],
                    )
                  : ktpPictureFile == null
                      ? Image.memory(
                          ktpPicture!,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          ktpPictureFile!,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Unggah file .jpg, .jpeg, .png, .img, .pdf ukuran maks 2MB",
          style: appTextTheme(context)
              .labelLarge
              ?.copyWith(color: AppColor.neutral[500]),
        )
      ];
    }

    List<Widget> identityMemberPhoto() {
      return [
        Text(
          "Kartu E-Kusuka",
          style: appTextTheme(context).titleSmall,
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
                          setState(() {
                            ekusukaCardPictureFile = File(document.path);
                          });
                        }
                        break;
                      case PhotoSource.gallery:
                        final document = await pickDocumentImage(
                          bottomSheetContext,
                          ImageSource.gallery,
                        );
                        if (document != null) {
                          setState(() {
                            ekusukaCardPictureFile = File(document.path);
                          });
                        }
                        break;
                    }
                  },
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: appColorScheme(context).outlineVariant,
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child:
                  (ekusukaCardPicture == null && ekusukaCardPictureFile == null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.uploadIcon,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Unggah Foto',
                              textAlign: TextAlign.start,
                              style: appTextTheme(context).bodyMedium?.copyWith(
                                    color: AppColor.neutral[400],
                                  ),
                            ),
                          ],
                        )
                      : ekusukaCardPictureFile == null
                          ? Image.memory(
                              ekusukaCardPicture!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              ekusukaCardPictureFile!,
                              fit: BoxFit.cover,
                            ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Unggah file .jpg, .jpeg, .png, .img, .pdf ukuran maks 2MB",
          style: appTextTheme(context)
              .labelLarge
              ?.copyWith(color: AppColor.neutral[500]),
        )
      ];
    }

    Widget button() {
      return AppPrimaryButton(
        "Simpan",
        () async {
          File tempKtpFile;
          File tempEkusukaFile;
          if (ktpPictureFile == null && ekusukaCardPictureFile == null) {
            AppTopSnackBar(context)
                .showDanger("Mohon lengkapi data terlebih dahulu");
            return;
          }
          if (ktpPictureFile != null && ekusukaCardPictureFile != null) {
            tempKtpFile = ktpPictureFile!;
            tempEkusukaFile = ekusukaCardPictureFile!;
          } else {
            tempKtpFile = ktpPictureFile!;
            tempEkusukaFile = ekusukaCardPictureFile!;
          }
          context.read<ProfileMemberCubit>().updateAttachmentProfile(
                tempKtpFile,
                tempEkusukaFile,
              );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.all(18.0),
      children: [
        ...identityPhoto(),
        const SizedBox(height: 18.0),
        ...identityMemberPhoto(),
        const SizedBox(height: 36.0),
        button(),
        const SizedBox(height: 36.0),
      ],
    );
  }
}
