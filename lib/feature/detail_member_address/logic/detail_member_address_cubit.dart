import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/province_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/sub_district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/village_response.dart';

part 'detail_member_address_state.dart';

class DetailMemberAddressCubit extends Cubit<DetailMemberAddressState> {
  DetailMemberAddressCubit(this.refService, this.deliveryAddressService)
      : super(const DetailMemberAddressState());

  final RefService refService;
  final DeliveryAddressService deliveryAddressService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final provinceResponse = await refService.province();
      emit(
        state.copyWith(
          provinceData: provinceResponse.data,
          districtData: null,
          subDistrictData: null,
          villageData: null,
          selectedProvince: null,
          selectedDistrict: null,
          selectedSubDistrict: null,
          selectedVillage: null,
          status: GlobalState.loaded,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> initWithExistData({
    required String provinceId,
    required String provinceName,
    required String districtId,
    required String districtName,
    required String subDistrictId,
    required String subDistrictName,
    required String villageId,
    required String villageName,
    required String latitude,
    required String longitude,
    required bool isPrimary,
  }) async {
    emit(state.copyWith(status: GlobalState.loading));
    final provinceResponse = await refService.province();
    final districtResponse = await refService.district(provinceId);
    final subDistrictResponse = await refService.subDistrict(districtId);
    final villageResponse = await refService.village(subDistrictId);
    emit(
      state.copyWith(
        provinceData: provinceResponse.data,
        districtData: districtResponse.data,
        subDistrictData: subDistrictResponse.data,
        villageData: villageResponse.data,
        selectedProvince: ProvinceResponseData(
          id: provinceId,
          name: provinceName,
        ),
        selectedDistrict: DistrictResponseData(
          id: districtId,
          name: districtName,
        ),
        selectedSubDistrict: SubDistrictResponseData(
          id: subDistrictId,
          name: subDistrictName,
        ),
        selectedVillage: VillageResponseData(
          id: villageId,
          name: villageName,
        ),
        latitude: latitude,
        longitude: longitude,
        isPrimary: isPrimary,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> selectProvince(ProvinceResponseData province) async {
    final districtResponse = await refService.district(province.id ?? '');
    emit(
      state.copyWith(
        selectedProvince: province,
        provinceData: state.provinceData,
        selectedDistrict: null,
        selectedSubDistrict: null,
        selectedVillage: null,
        districtData: districtResponse.data,
        subDistrictData: null,
        villageData: null,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> selectDistrict(DistrictResponseData district) async {
    final subDistrictResponse = await refService.subDistrict(district.id ?? '');
    emit(
      state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: district,
        selectedSubDistrict: null,
        selectedVillage: null,
        status: GlobalState.loaded,
        subDistrictData: subDistrictResponse.data,
        villageData: null,
      ),
    );
  }

  Future<void> selectSubDistrict(SubDistrictResponseData subDistrict) async {
    final villageResponse = await refService.village(subDistrict.id ?? '');
    emit(
      state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: subDistrict,
        selectedVillage: null,
        status: GlobalState.loaded,
        villageData: villageResponse.data,
      ),
    );
  }

  void selectVillage(VillageResponseData village) {
    emit(
      state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: state.selectedSubDistrict,
        villageData: state.villageData,
        selectedVillage: village,
        status: GlobalState.loaded,
      ),
    );
  }

  void changeLocationOnMap(
    String latitude,
    String longitude,
    File? snapshot,
  ) {
    emit(
      state.copyWith(
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
      ),
    );
  }

  void changePrimaryAddress(bool isPrimary) {
    emit(
      state.copyWith(
        isPrimary: isPrimary,
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: state.selectedSubDistrict,
        villageData: state.villageData,
        selectedVillage: state.selectedVillage,
        status: GlobalState.loaded,
      ),
    );
  }

  Future<void> save({
    required String nameAddress,
    required String nameReceiver,
    required String phoneReceiver,
    required String fullAddress,
    bool isSaveData = true,
    String? addressID,
  }) async {
    emit(
      state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: state.selectedSubDistrict,
        villageData: state.villageData,
        selectedVillage: state.selectedVillage,
        status: GlobalState.showDialogLoading,
      ),
    );
    try {
      isSaveData
          ? await deliveryAddressService.addAddress(
              nameAddress: nameAddress,
              nameReceiver: nameReceiver,
              phoneReceiver: phoneReceiver,
              province: state.selectedProvince?.name ?? '',
              provinceId: state.selectedProvince?.id ?? '',
              district: state.selectedDistrict?.name ?? '',
              districtId: state.selectedDistrict?.id ?? '',
              subdistrict: state.selectedSubDistrict?.name ?? '',
              subdistrictId: state.selectedSubDistrict?.id ?? '',
              village: state.selectedVillage?.name ?? '',
              villageId: state.selectedVillage?.id ?? '',
              fullAddress: fullAddress,
              latitude: state.latitude.toString(),
              longitude: state.longitude.toString(),
              isPrimaryAddress: state.isPrimary,
            )
          : await deliveryAddressService.updateAddress(
              addressID: addressID ?? '',
              nameAddress: nameAddress,
              nameReceiver: nameReceiver,
              phoneReceiver: phoneReceiver,
              province: state.selectedProvince?.name ?? '',
              provinceId: state.selectedProvince?.id ?? '',
              district: state.selectedDistrict?.name ?? '',
              districtId: state.selectedDistrict?.id ?? '',
              subdistrict: state.selectedSubDistrict?.name ?? '',
              subdistrictId: state.selectedSubDistrict?.id ?? '',
              village: state.selectedVillage?.name ?? '',
              villageId: state.selectedVillage?.id ?? '',
              fullAddress: fullAddress,
              latitude: state.latitude.toString(),
              longitude: state.longitude.toString(),
              isPrimaryAddress: state.isPrimary,
            );
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.hideDialogLoading,
        ),
      );
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.hideDialogLoading,
        ),
      );
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteAddress({required int addressID}) async {
    emit(
      state.copyWith(
        selectedProvince: state.selectedProvince,
        provinceData: state.provinceData,
        districtData: state.districtData,
        selectedDistrict: state.selectedDistrict,
        subDistrictData: state.subDistrictData,
        selectedSubDistrict: state.selectedSubDistrict,
        villageData: state.villageData,
        selectedVillage: state.selectedVillage,
        status: GlobalState.showDialogLoading,
      ),
    );
    try {
      await deliveryAddressService.deleteAddress(addressID: addressID);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.hideDialogLoading,
        ),
      );
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.hideDialogLoading,
        ),
      );
      emit(
        state.copyWith(
          selectedProvince: state.selectedProvince,
          provinceData: state.provinceData,
          districtData: state.districtData,
          selectedDistrict: state.selectedDistrict,
          subDistrictData: state.subDistrictData,
          selectedSubDistrict: state.selectedSubDistrict,
          villageData: state.villageData,
          selectedVillage: state.selectedVillage,
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
