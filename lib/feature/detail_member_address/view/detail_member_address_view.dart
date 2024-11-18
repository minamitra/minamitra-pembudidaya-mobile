import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/logic/detail_member_address_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/repositories/map_callback_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/views/set_location_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:path_provider/path_provider.dart';

class DetailMemberAddressView extends StatefulWidget {
  const DetailMemberAddressView({
    super.key,
    this.existData,
  });

  final MemberAddressResponseData? existData;

  @override
  State<DetailMemberAddressView> createState() =>
      _DetailMemberAddressViewState();
}

class _DetailMemberAddressViewState extends State<DetailMemberAddressView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController recieverController = TextEditingController();
  final TextEditingController recieverPhoneController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subdistrictController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existData != null) {
      nameController.text = widget.existData!.title ?? '';
      recieverController.text = widget.existData!.name ?? '';
      recieverPhoneController.text = widget.existData!.phone ?? '';
      provinceController.text = widget.existData!.provinceName ?? '';
      districtController.text = widget.existData!.cityName ?? '';
      subdistrictController.text = widget.existData!.subdistrictName ?? '';
      villageController.text = widget.existData!.villageName ?? '';
      addressController.text = widget.existData!.address ?? '';
    }
  }

  Function() bottomSheetShowModal(
    BuildContext context,
    String title,
    List<String> data,
    Function(String) onSelected,
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
                                onSelected(data[index]);
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
        labelText: 'Nama Alamat',
        withUpperLabel: true,
        hintText: 'Contoh. Mina Mitra Kolam 1',
        isMandatory: true,
        inputType: TextInputType.text,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Nama alamat tidak boleh kosong';
          }
          return null;
        },
      );
    }

    Widget recieverName() {
      return AppValidatorTextField(
        controller: recieverController,
        labelText: 'Nama Penerima',
        withUpperLabel: true,
        hintText: 'Contoh. Bapak Agus',
        isMandatory: true,
        inputType: TextInputType.text,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Nama penerima tidak boleh kosong';
          }
          return null;
        },
      );
    }

    Widget recieverPhone() {
      return AppValidatorTextField(
        controller: recieverPhoneController,
        labelText: 'Nomor Telepon Penerima',
        withUpperLabel: true,
        hintText: 'Contoh. 08912332122',
        isMandatory: true,
        inputType: TextInputType.phone,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Nomor telepon tidak boleh kosong';
          }
          return null;
        },
      );
    }

    Widget province() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(55.0, double.infinity, 8.0);
          }

          return AppValidatorTextField(
            controller: provinceController,
            isMandatory: true,
            withUpperLabel: true,
            readOnly: true,
            labelText: 'Provinsi',
            hintText: 'Pilih provinsi',
            suffixWidget: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(Icons.arrow_drop_down_rounded),
            ),
            suffixConstraints: const BoxConstraints(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Provinsi tidak boleh kosong';
              }
              return null;
            },
            onTap: bottomSheetShowModal(
              context,
              'Pilih Provinsi',
              state.provinceData?.data?.map((e) => e.name ?? '').toList() ?? [],
              (value) {
                final selectedProvince = state.provinceData?.data
                    ?.firstWhere((element) => element.name == value);
                context
                    .read<DetailMemberAddressCubit>()
                    .selectProvince(selectedProvince!);
                provinceController.text = selectedProvince.name ?? '';
                districtController.clear();
                subdistrictController.clear();
                villageController.clear();
              },
            ),
          );
        },
      );
    }

    Widget district() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: districtController,
            isMandatory: true,
            withUpperLabel: true,
            readOnly: true,
            labelText: 'Kabupaten',
            hintText: 'Pilih kabupaten',
            suffixWidget: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(Icons.arrow_drop_down_rounded),
            ),
            suffixConstraints: const BoxConstraints(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Kabupaten tidak boleh kosong';
              }
              return null;
            },
            onTap: state.selectedProvince == null
                ? () {
                    AppTopSnackBar(context)
                        .showDanger('Pilih provinsi terlebih dahulu');
                  }
                : bottomSheetShowModal(
                    context,
                    'Pilih Kabupaten',
                    state.districtData?.data
                            ?.map((e) => e.name ?? '')
                            .toList() ??
                        [],
                    (value) {
                      final selectedDistrict = state.districtData?.data
                          ?.firstWhere((element) => element.name == value);
                      context
                          .read<DetailMemberAddressCubit>()
                          .selectDistrict(selectedDistrict!);
                      districtController.text = selectedDistrict.name ?? '';
                      subdistrictController.clear();
                      villageController.clear();
                    },
                  ),
          );
        },
      );
    }

    Widget subDistrict() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: subdistrictController,
            isMandatory: true,
            withUpperLabel: true,
            readOnly: true,
            labelText: 'Kecamatan',
            hintText: 'Pilih kecamatan',
            suffixWidget: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(Icons.arrow_drop_down_rounded),
            ),
            suffixConstraints: const BoxConstraints(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Kecamatan tidak boleh kosong';
              }
              return null;
            },
            onTap: state.selectedDistrict == null
                ? () {
                    AppTopSnackBar(context)
                        .showDanger('Pilih kabupaten terlebih dahulu');
                  }
                : bottomSheetShowModal(
                    context,
                    'Pilih kecamatan',
                    state.subDistrictData?.data
                            ?.map((e) => e.name ?? '')
                            .toList() ??
                        [],
                    (value) {
                      final selectedSubDistrict = state.subDistrictData?.data
                          ?.firstWhere((element) => element.name == value);
                      context
                          .read<DetailMemberAddressCubit>()
                          .selectSubDistrict(selectedSubDistrict!);
                      subdistrictController.text =
                          selectedSubDistrict.name ?? '';
                      villageController.clear();
                    },
                  ),
          );
        },
      );
    }

    Widget vilage() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: villageController,
            isMandatory: true,
            withUpperLabel: true,
            readOnly: true,
            labelText: 'Kelurahan',
            hintText: 'Pilih kelurahan',
            suffixWidget: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(Icons.arrow_drop_down_rounded),
            ),
            suffixConstraints: const BoxConstraints(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Kelurahan tidak boleh kosong';
              }
              return null;
            },
            onTap: state.selectedSubDistrict == null
                ? () {
                    AppTopSnackBar(context)
                        .showDanger('Pilih kecamatan terlebih dahulu');
                  }
                : bottomSheetShowModal(
                    context,
                    'Pilih kelurahan',
                    state.villageData?.data
                            ?.map((e) => e.name ?? '')
                            .toList() ??
                        [],
                    (value) {
                      final selectedVillage = state.villageData?.data
                          ?.firstWhere((element) => element.name == value);
                      context
                          .read<DetailMemberAddressCubit>()
                          .selectVillage(selectedVillage!);
                      villageController.text = selectedVillage.name ?? '';
                    },
                  ),
          );
        },
      );
    }

    Widget addressFull() {
      return AppValidatorTextField(
        controller: addressController,
        labelText: 'Alamat lengkap',
        withUpperLabel: true,
        hintText:
            'Contoh. Jalan tengkurap no 1 RT 01 RW 01 Jawa Tengah Indonesia',
        isMandatory: true,
        inputType: TextInputType.text,
        maxLines: 3,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Alamat tidak boleh kosong';
          }
          return null;
        },
      );
    }

    Widget pondLocation() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lokasi Kolam',
                style: appTextTheme(context)
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    AppTransition.pushTransition(
                      SetLocationPage(
                        initLatLng: widget.existData != null
                            ? LatLng(
                                double.parse(widget.existData!.latitude ?? '0'),
                                double.parse(
                                  widget.existData!.longitude ?? '0',
                                ),
                              )
                            : null,
                      ),
                      SetLocationPage.routeSettings(),
                    ),
                  )
                      .then((value) async {
                    if (value != null) {
                      if (value is MapCallbackData) {
                        Uint8List imageInUnit8List = value.snapshotMap!;
                        final tempDir = await getTemporaryDirectory();
                        File file = await File(
                          '${tempDir.path}/${DateTime.now().toIso8601String()}.png',
                        ).create();
                        file.writeAsBytesSync(imageInUnit8List);
                        if (context.mounted) {
                          context
                              .read<DetailMemberAddressCubit>()
                              .changeLocationOnMap(
                                value.latLng.latitude.toString(),
                                value.latLng.longitude.toString(),
                                file,
                              );
                        }
                      }
                    }
                  });
                },
                child: state.snapshotMap != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              state.snapshotMap!,
                              fit: BoxFit.cover,
                              height: 180.0,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black.withOpacity(0.30),
                            ),
                            height: 180.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 32.0,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Ganti lokasi',
                                    style: appTextTheme(context)
                                        .titleLarge
                                        ?.copyWith(color: AppColor.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
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
                                widget.existData != null
                                    ? 'Ganti lokasi'
                                    : 'Pilih lokasi',
                                style:
                                    appTextTheme(context).bodySmall?.copyWith(
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
        },
      );
    }

    Widget primaryAddress() {
      return BlocBuilder<DetailMemberAddressCubit, DetailMemberAddressState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  'Jadikan Alamat Utama',
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 26.0,
                child: Switch(
                  value: state.isPrimary,
                  inactiveThumbColor: AppColor.neutral[200],
                  inactiveTrackColor: AppColor.neutral[100],
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return AppColor.neutral[200];
                  }),
                  onChanged: (value) {
                    context
                        .read<DetailMemberAddressCubit>()
                        .changePrimaryAddress(value);
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    Widget deleteAddress() {
      return Center(
        child: AppPrimaryOutlineFullButton(
          'Hapus alamat',
          () {
            showDeleteBottomSheet(
              context,
              title: 'Hapus alamat',
              descriptions: 'Yakin ingin menghapus alamat ini ?',
              onTapDelete: () {
                context.read<DetailMemberAddressCubit>().deleteAddress(
                      addressID: int.tryParse(widget.existData?.id ?? '0') ?? 0,
                    );
                Navigator.of(context).pop();
              },
            );
          },
        ),
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
          const SizedBox(height: 48.0),
          deleteAddress(),
        ],
      );
    }

    Widget saveButton() {
      return AppPrimaryFullButton(
        'Simpan',
        () {
          if (formKey.currentState!.validate()) {
            final nameAddress = nameController.text;
            final nameReceiver = recieverController.text;
            final phoneReceiver = recieverPhoneController.text;
            final fullAddress = addressController.text;
            context.read<DetailMemberAddressCubit>().save(
                  addressID: widget.existData?.id ?? '',
                  nameAddress: nameAddress,
                  nameReceiver: nameReceiver,
                  phoneReceiver: phoneReceiver,
                  fullAddress: fullAddress,
                  isSaveData: widget.existData == null,
                );
          }
          return;
        },
      );
    }

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Expanded(child: form()),
            const SizedBox(height: 18.0),
            saveButton(),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
