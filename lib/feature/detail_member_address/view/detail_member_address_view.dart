import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/repositories/map_callback_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/set_location_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class DetailMemberAddressView extends StatefulWidget {
  const DetailMemberAddressView({
    super.key,
    this.nameAddress,
    this.nameReceiver,
    this.phoneReceiver,
    this.province,
    this.district,
    this.subdistrict,
    this.village,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.isPrimaryAddress,
  });

  final String? nameAddress;
  final String? nameReceiver;
  final String? phoneReceiver;
  final String? province;
  final String? district;
  final String? subdistrict;
  final String? village;
  final String? fullAddress;
  final String? latitude;
  final String? longitude;
  final bool? isPrimaryAddress;

  @override
  State<DetailMemberAddressView> createState() =>
      _DetailMemberAddressViewState();
}

class _DetailMemberAddressViewState extends State<DetailMemberAddressView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController recieverController = TextEditingController();
  final TextEditingController recieverPhoneController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subdistrictController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isPrimaryAddress = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.nameAddress ?? "";
    recieverController.text = widget.nameReceiver ?? "";
    recieverPhoneController.text = widget.phoneReceiver ?? "";
    provinceController.text = widget.province ?? "";
    districtController.text = widget.district ?? "";
    subdistrictController.text = widget.subdistrict ?? "";
    villageController.text = widget.village ?? "";
    addressController.text = widget.fullAddress ?? "";
    isPrimaryAddress = widget.isPrimaryAddress ?? false;
  }

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
    Widget nameAddress() {
      return AppValidatorTextField(
        controller: nameController,
        labelText: "Nama Alamat",
        withUpperLabel: true,
        hintText: "Contoh. Mina Mitra Kolam 1",
        isMandatory: true,
        inputType: TextInputType.text,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Nama alamat tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget recieverName() {
      return AppValidatorTextField(
        controller: recieverController,
        labelText: "Nama Penerima",
        withUpperLabel: true,
        hintText: "Contoh. Bapak Agus",
        isMandatory: true,
        inputType: TextInputType.text,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Nama penerima tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget recieverPhone() {
      return AppValidatorTextField(
        controller: recieverPhoneController,
        labelText: "Nomor Telepon Penerima",
        withUpperLabel: true,
        hintText: "Contoh. 08912332122",
        isMandatory: true,
        inputType: TextInputType.phone,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Nomor telepon tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget province() {
      return AppValidatorTextField(
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
      );
    }

    Widget district() {
      return AppValidatorTextField(
        controller: districtController,
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
      );
    }

    Widget subDistrict() {
      return AppValidatorTextField(
        controller: subdistrictController,
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
      );
    }

    Widget vilage() {
      return AppValidatorTextField(
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
      );
    }

    Widget addressFull() {
      return AppValidatorTextField(
        controller: addressController,
        labelText: "Alamat lengkap",
        withUpperLabel: true,
        hintText:
            "Contoh. Jalan tengkurap no 1 RT 01 RW 01 Jawa Tengah Indonesia",
        isMandatory: true,
        inputType: TextInputType.text,
        maxLines: 3,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Alamat tidak boleh kosong";
          }
          return null;
        },
      );
    }

    Widget pondLocation() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      );
    }

    Widget primaryAddress() {
      return Row(
        children: [
          Expanded(
            child: Text(
              "Jadikan Alamat Utama",
              style: appTextTheme(context)
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 26.0,
            child: Switch(
              value: isPrimaryAddress,
              inactiveThumbColor: AppColor.neutral[200],
              inactiveTrackColor: AppColor.neutral[100],
              trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                return AppColor.neutral[200]; // Use the default color.
              }),
              onChanged: (value) {
                setState(() {
                  isPrimaryAddress = value;
                });
              },
            ),
          )
        ],
      );
    }

    Widget form() {
      return ListView(
        children: [
          const SizedBox(height: 18.0),
          nameAddress(),
          const SizedBox(height: 18.0),
          recieverName(),
          const SizedBox(height: 18.0),
          recieverPhone(),
          const SizedBox(height: 18.0),
          province(),
          const SizedBox(height: 18.0),
          district(),
          const SizedBox(height: 18.0),
          subDistrict(),
          const SizedBox(height: 18.0),
          vilage(),
          const SizedBox(height: 18.0),
          addressFull(),
          const SizedBox(height: 18.0),
          pondLocation(),
          const SizedBox(height: 18.0),
          primaryAddress(),
          const SizedBox(height: 18.0),
        ],
      );
    }

    Widget saveButton() {
      return AppPrimaryFullButton(
        "Simpan",
        () {},
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Expanded(child: form()),
          const SizedBox(height: 18.0),
          saveButton(),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
