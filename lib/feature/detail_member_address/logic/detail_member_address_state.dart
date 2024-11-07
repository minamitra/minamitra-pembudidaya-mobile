part of 'detail_member_address_cubit.dart';

class DetailMemberAddressState extends Equatable {
  const DetailMemberAddressState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isPrimary = false,
    this.provinceData,
    this.districtData,
    this.subDistrictData,
    this.villageData,
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedSubDistrict,
    this.selectedVillage,
    this.latitude = '',
    this.longitude = '',
    this.snapshotMap,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isPrimary;
  final ProvinceResponse? provinceData;
  final DistrictResponse? districtData;
  final SubDistrictResponse? subDistrictData;
  final VillageResponse? villageData;
  final ProvinceResponseData? selectedProvince;
  final DistrictResponseData? selectedDistrict;
  final SubDistrictResponseData? selectedSubDistrict;
  final VillageResponseData? selectedVillage;
  final String? latitude;
  final String? longitude;
  final File? snapshotMap;

  DetailMemberAddressState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isPrimary,
    ProvinceResponse? provinceData,
    DistrictResponse? districtData,
    SubDistrictResponse? subDistrictData,
    VillageResponse? villageData,
    ProvinceResponseData? selectedProvince,
    DistrictResponseData? selectedDistrict,
    SubDistrictResponseData? selectedSubDistrict,
    VillageResponseData? selectedVillage,
    String? latitude,
    String? longitude,
    File? snapshotMap,
    String? urlImage,
  }) {
    return DetailMemberAddressState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isPrimary: isPrimary ?? this.isPrimary,
      provinceData: provinceData,
      districtData: districtData,
      subDistrictData: subDistrictData,
      villageData: villageData,
      selectedProvince: selectedProvince,
      selectedDistrict: selectedDistrict,
      selectedSubDistrict: selectedSubDistrict,
      selectedVillage: selectedVillage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      snapshotMap: snapshotMap ?? this.snapshotMap,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isPrimary,
        provinceData ?? '',
        districtData ?? '',
        subDistrictData ?? '',
        villageData ?? '',
        selectedProvince ?? '',
        selectedDistrict ?? '',
        selectedSubDistrict ?? '',
        selectedVillage ?? '',
        latitude ?? '',
        longitude ?? '',
        snapshotMap ?? '',
      ];
}
