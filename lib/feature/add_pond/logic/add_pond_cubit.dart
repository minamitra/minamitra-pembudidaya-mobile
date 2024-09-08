import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/province_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/sub_district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/village_response.dart';

part 'add_pond_state.dart';

class AddPondCubit extends Cubit<AddPondState> {
  AddPondCubit(this.refService) : super(const AddPondState());

  final RefService refService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final provinceResponse = await refService.province();
      emit(state.copyWith(
        provinceData: provinceResponse.data,
        status: GlobalState.loaded,
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

  void changeStep(int index) {
    emit(state.copyWith(
      provinceData: state.provinceData,
      districtData: state.districtData,
      subDistrictData: state.subDistrictData,
      villageData: state.villageData,
      selectedProvince: state.selectedProvince,
      selectedDistrict: state.selectedDistrict,
      selectedSubDistrict: state.selectedSubDistrict,
      selectedVillage: state.selectedVillage,
      index: index,
      status: GlobalState.refresh,
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
}
