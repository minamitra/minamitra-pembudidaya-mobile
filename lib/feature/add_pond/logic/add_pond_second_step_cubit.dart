import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/province_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/sub_district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/village_response.dart';

part 'add_pond_second_step_state.dart';

class AddPondSecondStepCubit extends Cubit<AddPondSecondStepState> {
  AddPondSecondStepCubit(
    this.refService,
    this.cdnService,
  ) : super(const AddPondSecondStepState());

  final RefService refService;
  final CdnService cdnService;

  final TextEditingController starterFeedController = TextEditingController();
  final TextEditingController growerFeedController = TextEditingController();
  final TextEditingController finisherFeedController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subdisctrictController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    final provinceResponse = await refService.province();
    emit(state.copyWith(
      provinceData: provinceResponse.data,
      districtData: null,
      subDistrictData: null,
      villageData: null,
      selectedProvince: null,
      selectedDistrict: null,
      selectedSubDistrict: null,
      selectedVillage: null,
    ));
  }

  Future<void> selectProvince(ProvinceResponseData province) async {
    final districtResponse = await refService.district(province.id ?? "");
    emit(state.copyWith(
      selectedProvince: province,
      provinceData: state.provinceData,
      selectedDistrict: null,
      selectedSubDistrict: null,
      selectedVillage: null,
      districtData: districtResponse.data,
      subDistrictData: null,
      villageData: null,
      status: GlobalState.loaded,
    ));
  }

  Future<void> selectDistrict(DistrictResponseData district) async {
    final subDistrictResponse = await refService.subDistrict(district.id ?? "");
    emit(state.copyWith(
      selectedProvince: state.selectedProvince,
      provinceData: state.provinceData,
      districtData: state.districtData,
      selectedDistrict: district,
      selectedSubDistrict: null,
      selectedVillage: null,
      status: GlobalState.loaded,
      subDistrictData: subDistrictResponse.data,
      villageData: null,
    ));
  }

  Future<void> selectSubDistrict(SubDistrictResponseData subDistrict) async {
    final villageResponse = await refService.village(subDistrict.id ?? "");
    emit(state.copyWith(
      selectedProvince: state.selectedProvince,
      provinceData: state.provinceData,
      districtData: state.districtData,
      selectedDistrict: state.selectedDistrict,
      subDistrictData: state.subDistrictData,
      selectedSubDistrict: subDistrict,
      selectedVillage: null,
      status: GlobalState.loaded,
      villageData: villageResponse.data,
    ));
  }

  void selectVillage(VillageResponseData village) {
    emit(state.copyWith(
      selectedProvince: state.selectedProvince,
      provinceData: state.provinceData,
      districtData: state.districtData,
      selectedDistrict: state.selectedDistrict,
      subDistrictData: state.subDistrictData,
      selectedSubDistrict: state.selectedSubDistrict,
      villageData: state.villageData,
      selectedVillage: village,
      status: GlobalState.loaded,
    ));
  }

  void changeLocationOnMap(
    String latitude,
    String longitude,
    Uint8List? snapshot,
  ) {
    emit(state.copyWith(
      latitude: latitude,
      longitude: longitude,
      snapshotMap: snapshot,
      selectedProvince: state.selectedProvince,
      provinceData: state.provinceData,
      districtData: state.districtData,
      selectedDistrict: state.selectedDistrict,
      subDistrictData: state.subDistrictData,
      selectedSubDistrict: state.selectedSubDistrict,
      villageData: state.villageData,
      selectedVillage: state.selectedVillage,
      status: GlobalState.loaded,
    ));
  }

  Future<void> uploadImage(File image) async {
    emit(state.copyWith(
      selectedProvince: state.selectedProvince,
      provinceData: state.provinceData,
      districtData: state.districtData,
      selectedDistrict: state.selectedDistrict,
      subDistrictData: state.subDistrictData,
      selectedSubDistrict: state.selectedSubDistrict,
      villageData: state.villageData,
      selectedVillage: state.selectedVillage,
      status: GlobalState.showDialogLoading,
    ));
    try {
      final response = await cdnService.uploadImage(image);
      emit(state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: state.selectedSubDistrict,
        villageData: state.villageData,
        selectedVillage: state.selectedVillage,
        urlImage: response.data.data?.fileuri ?? "",
        status: GlobalState.hideDialogLoading,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
