import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ProfileMemberView extends StatefulWidget {
  const ProfileMemberView({super.key});

  @override
  State<ProfileMemberView> createState() => _ProfileMemberViewState();
}

class _ProfileMemberViewState extends State<ProfileMemberView> {
  bool isEditable = false;

  final TextEditingController numberKTAController = TextEditingController();
  final TextEditingController numberNIKController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget dataStatic(
      String label,
      String value,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18.0),
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
          const SizedBox(height: 18.0),
          Divider(color: AppColor.neutral[100]),
        ],
      );
    }

    Widget numberKTA() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: numberKTAController,
          labelText: "Nomor KTA",
          withUpperLabel: true,
          isMandatory: true,
          hintText: "Contoh. 2420039",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Nomor KTA Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Nomor KTA",
        "003112313214",
      );
    }

    Widget numberNIK() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: numberNIKController,
          labelText: "Nomor NIK",
          withUpperLabel: true,
          isMandatory: true,
          hintText: "Contoh. 3520069991220",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Nomor NIK Tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Nomor NIK",
        "3520069991220",
      );
    }

    Widget numberPhone() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: phoneController,
          labelText: "Nomor Handphone",
          withUpperLabel: true,
          isMandatory: true,
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
        "089221023392",
      );
    }

    Widget job() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: jobController,
          labelText: "Pekerjaan",
          withUpperLabel: true,
          isMandatory: true,
          hintText: "Contoh. Petani Tambak Boyo",
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
        "Petani Tambak Boyo",
      );
    }

    Widget birthDate() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: birthDateController,
          labelText: "Tempat, Tanggal Lahir",
          withUpperLabel: true,
          isMandatory: true,
          hintText: "Contoh. Yogyakarta, 12 Desember 2024",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Tempat Tanggal Lahir tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Tempat, Tanggal Lahir",
        "Yogyakarta, 12 Desember 2024",
      );
    }

    Widget gender() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: genderController,
          labelText: "Jenis Kelamin",
          withUpperLabel: true,
          isMandatory: true,
          hintText: "Contoh. Laki-Laki",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Jenis kelamin tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Jenis Kelamin",
        "Laki-Laki",
      );
    }

    Widget address() {
      if (isEditable) {
        return AppValidatorTextField(
          controller: addressController,
          labelText: "Alamat",
          withUpperLabel: true,
          isMandatory: true,
          hintText:
              "Contoh. Kelompok Budidaya, Kelurahan, Kecamatan,  Kabupaten, Provinsi",
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Alamat tidak boleh kosong";
            }
            return null;
          },
        );
      }
      return dataStatic(
        "Alamat",
        "Kelompok Budidaya, Kelurahan, Kecamatan,  Kabupaten, Provinsi",
      );
    }

    Widget editButton() {
      if (!isEditable) {
        return const SizedBox();
      }
      return AppPrimaryFullButton(
        "Simpan",
        () {},
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        numberKTA(),
        numberNIK(),
        numberPhone(),
        job(),
        birthDate(),
        gender(),
        address(),
        editButton(),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
