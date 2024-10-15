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
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_image.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/gender_data.dart';
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  Uint8List? picture;
  File? pictureFile;
  GenderData? selectedGender;

  DateTime dateNow = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    super.initState();
    if (widget.profile.imageUrl != null && widget.profile.imageUrl != "") {
      convertImageUrl(widget.profile.imageUrl!);
    }
    nikController.text = widget.profile.nik ?? "";
    nameController.text = widget.profile.name ?? "";
    emailController.text = widget.profile.email ?? "";
    phoneController.text = widget.profile.mobilephone ?? "";
    birthPlaceController.text = widget.profile.birthPlace ?? "";
    birthDateController.text = widget.profile.birthDate == null
        ? ""
        : AppConvertDateTime().ymdDash(widget.profile.birthDate!);
    genderController.text = widget.profile.gender ?? "";
    jobController.text = widget.profile.job ?? "";
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

    Widget nikField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: nikController,
          labelText: "NIK",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.number,
          hintText: "Masukkan NIK",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "NIK Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "NIK",
        nikController.text,
      );
    }

    Widget nameField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: nameController,
          labelText: "Nama Lengkap",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.name,
          hintText: "Masukkan Nama Lengkap",
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
          hintText: "Masukkan Email",
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
          hintText: "Masukkan Nomor Handphone",
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

    Widget birthPlaceField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: birthPlaceController,
          labelText: "Tempat Lahir (Sesuai KTP)",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.text,
          hintText: "Masukkan Tempat Lahir",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Tempat Lahir Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Tempat Lahir",
        birthPlaceController.text,
      );
    }

    Widget birthDateField() {
      if (isEditable) {
        return AppValidatorTextField(
          readOnly: true,
          controller: birthDateController,
          labelText: "Tanggal Lahir (Sesuai KTP)",
          hintText: "Pilih Tanggal Lahir",
          suffixConstraints: const BoxConstraints(),
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Image.asset(
              AppAssets.calendarIcon,
              height: 24,
              fit: BoxFit.cover,
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
                  birthDateController.text = AppConvertDateTime().ymdDash(date);
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
      return dataStatic(
        "Tanggal Lahir",
        birthDateController.text,
      );
    }

    Widget genderField() {
      if (isEditable) {
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
                  style: appTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.red),
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
              itemCount: listGender.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.neutral[200]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: RadioListTile<GenderData>(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      listGender[index].name,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: AppColor.neutral[600],
                          ),
                    ),
                    value: listGender[index],
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        );
      } else {
        return dataStatic(
          "Jenis Kelamin",
          convertGenderName(genderController.text),
        );
      }
    }

    Widget jobField() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: jobController,
          labelText: "Pekerjaan",
          withUpperLabel: true,
          isMandatory: true,
          inputType: TextInputType.text,
          hintText: "Masukkan Pekerjaan",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Pekerjaan Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Pekerjaan",
        jobController.text,
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
            nik: nikController.text,
            name: nameController.text,
            email: emailController.text,
            mobilephone: phoneController.text,
            birthPlace: birthPlaceController.text,
            birthDate: birthDateController.text,
            gender: selectedGender?.value ?? "",
            job: jobController.text,
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
          const SizedBox(height: 16.0),
          profilePicture(),
          const SizedBox(height: 16.0),
          buttonChangeProfilePicture(),
          nikField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          nameField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          emailField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          phoneField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          birthPlaceField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          birthDateField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          genderField(),
          isEditable ? const SizedBox(height: 16.0) : const SizedBox(),
          jobField(),
          isEditable ? const SizedBox(height: 36.0) : const SizedBox(),
          editButton(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
