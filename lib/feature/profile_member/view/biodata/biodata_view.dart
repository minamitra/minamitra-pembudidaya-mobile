import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_image.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/profile_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/update_profile_payload.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class BiodataView extends StatefulWidget {
  final ProfileResponseData profile;

  const BiodataView(this.profile, {super.key});

  @override
  State<BiodataView> createState() => _BiodataViewState();
}

class _BiodataViewState extends State<BiodataView> {
  bool isEditable = false;

  // final TextEditingController numberKTAController = TextEditingController();
  // final TextEditingController numberNIKController = TextEditingController();
  // final TextEditingController jobController = TextEditingController();
  // final TextEditingController birthDateController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Uint8List? picture;
  File? pictureFile;

  @override
  void initState() {
    super.initState();
    if (widget.profile.imageUrl != null && widget.profile.imageUrl != "") {
      convertImageUrl(widget.profile.imageUrl!);
    }
    nameController.text = widget.profile.name ?? "";
    emailController.text = widget.profile.email ?? "";
    phoneController.text = widget.profile.mobilephone ?? "";
  }

  void convertImageUrl(String image) async {
    http.Response imagePath = await http.get(Uri.parse(image));
    setState(() {
      picture = imagePath.bodyBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget dataStatic(
      String label,
      String value,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Text(
            label,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[400],
                ),
          ),
          const SizedBox(height: 12.0),
          Text(
            value,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16.0),
          Divider(color: AppColor.neutral[100]),
        ],
      );
    }

    // Widget numberKTA() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: numberKTAController,
    //       labelText: "Nomor KTA",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText: "Contoh. 2420039",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Nomor KTA Tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Nomor KTA",
    //     "003112313214",
    //   );
    // }

    // Widget numberNIK() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: numberNIKController,
    //       labelText: "Nomor NIK",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText: "Contoh. 3520069991220",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Nomor NIK Tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Nomor NIK",
    //     "3520069991220",
    //   );
    // }

    // Widget job() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: jobController,
    //       labelText: "Pekerjaan",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText: "Contoh. Petani Tambak Boyo",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Pekerjaan Tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Pekerjaan",
    //     "Petani Tambak Boyo",
    //   );
    // }

    // Widget birthDate() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: birthDateController,
    //       labelText: "Tempat, Tanggal Lahir",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText: "Contoh. Yogyakarta, 12 Desember 2024",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Tempat Tanggal Lahir tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Tempat, Tanggal Lahir",
    //     "Yogyakarta, 12 Desember 2024",
    //   );
    // }

    // Widget gender() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: genderController,
    //       labelText: "Jenis Kelamin",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText: "Contoh. Laki-Laki",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Jenis kelamin tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Jenis Kelamin",
    //     "Laki-Laki",
    //   );
    // }

    // Widget address() {
    //   if (isEditable) {
    //     return AppValidatorTextField(
    //       controller: addressController,
    //       labelText: "Alamat",
    //       withUpperLabel: true,
    //       isMandatory: true,
    //       hintText:
    //           "Contoh. Kelompok Budidaya, Kelurahan, Kecamatan,  Kabupaten, Provinsi",
    //       validator: (String? value) {
    //         if (value?.isEmpty ?? true) {
    //           return "Alamat tidak boleh kosong";
    //         }
    //         return null;
    //       },
    //     );
    //   }
    //   return dataStatic(
    //     "Alamat",
    //     "Kelompok Budidaya, Kelurahan, Kecamatan,  Kabupaten, Provinsi",
    //   );
    // }

    Widget profilePicture() {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(44.0),
          child: (picture == null && pictureFile == null)
              ? Image.asset(
                  AppAssets.profileImageDummy,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                )
              : pictureFile == null
                  ? Image.memory(
                      picture!,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      pictureFile!,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    ),
        ),
      );
    }

    Widget buttonChangeProfilePicture() {
      return !isEditable
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    builder: (bottomSheetContext) {
                      return AppImagePickerMenu(
                        "Upload Foto Profil",
                        (type) async {
                          switch (type) {
                            case PhotoSource.camera:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.camera,
                              );
                              if (document != null) {
                                setState(() {
                                  pictureFile = File(document.path);
                                });
                              }
                              Navigator.pop(context);
                              break;
                            case PhotoSource.gallery:
                              final document = await pickDocumentImage(
                                bottomSheetContext,
                                ImageSource.gallery,
                              );
                              if (document != null) {
                                setState(() {
                                  pictureFile = File(document.path);
                                });
                              }
                              Navigator.pop(context);
                              break;
                          }
                        },
                      );
                    },
                  );
                },
                child: Text(
                  "Ganti Foto",
                  style: appTextTheme(context).bodySmall?.copyWith(
                        color: AppColor.primary,
                      ),
                ),
              ),
            );
    }

    Widget nameField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: nameController,
          labelText: "Nama",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.name,
          hintText: "Contoh. Andi Budi Santoso",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Nama Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Nama",
        nameController.text,
      );
    }

    Widget emailField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: emailController,
          labelText: "Email",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.emailAddress,
          hintText: "Contoh. andi@gmail.com",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Email Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Email",
        emailController.text,
      );
    }

    Widget phoneField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: phoneController,
          labelText: "Nomor Handphone",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.phone,
          hintText: "Contoh. 089221023392",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Nomor Handphone Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Nomor Handphone",
        phoneController.text,
      );
    }

    Widget editButton() {
      if (!isEditable) {
        return AppPrimaryFullButton(
          "Edit",
          () {
            setState(() {
              isEditable = true;
            });
          },
        );
      }
      return AppPrimaryFullButton(
        "Simpan",
        () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          File tempFile;

          if (pictureFile != null) {
            tempFile = pictureFile!;
          } else {
            tempFile = await appConvertImage(picture!);
          }
          UpdateProfilePayload payload = UpdateProfilePayload(
            name: nameController.text,
            email: emailController.text,
            mobilephone: phoneController.text,
          );
          context.read<ProfileMemberCubit>().updateProfile(payload, tempFile);
          setState(() {
            isEditable = true;
          });
        },
      );
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          // numberKTA(),
          // numberNIK(),
          // numberPhone(),
          // job(),
          // birthDate(),
          // gender(),
          // address(),
          const SizedBox(height: 16.0),
          profilePicture(),
          const SizedBox(height: 16.0),
          buttonChangeProfilePicture(),
          nameField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          emailField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          phoneField(),
          isEditable ? const SizedBox(height: 36.0) : const SizedBox(),
          editButton(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
